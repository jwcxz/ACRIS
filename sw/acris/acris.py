#!/usr/bin/env python3

import argparse, serial, socket, sys

from backend.network import Network, DummyNetwork
from backend.interpreter import CommandInterpreter
from backend.httpserver import get_httpd
from backend.pushservice import HomebridgePushService

import plugins

import importlib

class Acris:
    def __init__(self, skthost='localhost', sktport=55555, serport='/dev/ttyUSB0', serbaud=38400, serparity=serial.PARITY_EVEN):
        if serport.lower() != "dummy":
            self.network = Network(serport, serbaud, serparity);
        else:
            self.network = DummyNetwork();

        # build plugins list
        # name -> (obj, description)
        self.plugins = {};
        # name -> params
        self.plugin_params = {};
        self.refresh_plugins();

        # current plugins
        # name -> instance
        self.activated = {};

        # addresses in use by plugins
        # address -> plugin_name
        self.used_addresses = {};

        # socket configuration
        self.skthost = skthost;
        self.sktport = sktport;

        # push service
        self.push_service = None;


    def set_interpreter(self, interpreter):
        self.interpreter = interpreter;

    def set_server(self, server):
        self.server = server;

    def run_server(self):
        self.server.serve_forever();


    def set_push_service(self, push_service):
        self.push_service = push_service;

    def call_push_service(self, plugin_name, new_state):
        if not self.push_service:
            return;

        self.push_service.push_state(plugin_name, new_state);


    def update_plugin_params(self, plugin_name, new_params):
        self.plugin_params[plugin_name].update(new_params);


    def start_or_restart_plugin(self, plugin_name, force=False):
        plugin_obj = self.plugins[plugin_name][0];
        new_plugin = plugin_obj(self.network, self.plugin_params[plugin_name]);

        # if plugin is already activated, replace it; otherwise ensure that
        # only one plugin can access each address by either stopping the other
        # plugins or rejecting the request depending on the value of force
        if plugin_name in self.activated:
            print("Plugin already active.  Restarting...");
            self.stop_plugin(plugin_name, False);
        else:
            # check if plugin is already active
            overlapping_addresses = [];
            overlapping_plugins = set();

            for addr in new_plugin.addresses:
                if addr in self.used_addresses:
                    overlapping_addresses.append(addr);
                    overlapping_plugins.add(self.used_addresses[addr]);

                if len(overlapping_addresses):
                    # there are overlapping addresses, so either stop the
                    # owning plugins or return an error depending on the value
                    # of force

                    if force:
                        for opn in overlapping_plugins:
                            # when stopping, shut off the lights of those
                            # overlapping plugins since some addresses may not
                            # be used by the new plugin
                            self.stop_plugin(opn, True);
                    else:
                        print("Not starting because of overlapping addresses: %s" % plugin_name);
                        print("    Wanted:", new_plugin.addresses);
                        print("    In use:", overlapping_addresses);
                        print("    Owners:", overlapping_plugins);
                        return False;

        # report the plugin as active
        self.activated[plugin_name] = new_plugin;

        # store addresses used by the plugin
        for addr in new_plugin.addresses:
            self.used_addresses[addr] = plugin_name;

        # start the plugin
        self.activated[plugin_name].start();

        # push the notification if available
        self.call_push_service(plugin_name, True);

        return True;


    def stop_plugin(self, plugin_name, lights_off=True):
        if plugin_name in self.activated and self.activated[plugin_name] != None:
            if self.activated[plugin_name].enabled:
                self.activated[plugin_name].stop();

            # free up addresses (and shut off lights if lights_off is True)
            for addr in self.activated[plugin_name].addresses:
                if addr in self.used_addresses:
                    del(self.used_addresses[addr]);

                    if lights_off:
                        self.network.dev_off(addr);
                else:
                    print("Warning: 0x%02X not in address list" % addr);

            # remove plugin object
            del(self.activated[plugin_name]);

            # TODO: should we avoid situations associated with rapid stop/start
            # patterns on the same plugin?
            self.call_push_service(plugin_name, False);

            return True

        else:
            print("Error: %s not activated" %(plugin_name));
            return False


    def get_plugin_state(self, plugin_name):
        return plugin_name in self.activated and self.activated[plugin_name];


    def get_plugin_params(self, plugin_name):
        return self.plugin_params[plugin_name];


    def stop_all_plugins(self):
        # save a copy of the activated plugins list because self.stop_plugin()
        # will delete entries
        activated_plugins = list(self.activated.keys());
        for plugin_name in activated_plugins:
            # don't shut off the lights here because they'll be shut off with a
            # single network command below
            self.stop_plugin(plugin_name, False);

        self.lights_off();


    def list_all_plugins(self):
        return list(self.plugins.keys());


    def list_active_plugins(self):
        return list(self.activated.keys());


    def list_active_addresses(self):
        return [ "0x%02X" % a for a in self.used_addresses ];


    def refresh_plugins(self):
        importlib.reload(plugins);

        for p in plugins.__all__:
            _ = __import__('plugins.'+p, globals(), locals(), [p], 0);
            importlib.reload(_);
            self.plugins[p] = (_.Plugin, plugins.enabled[p]);
            self.plugin_params[p] = _.default_params.copy();

        print("-> Refreshed plugins: %s" % ' '.join(self.plugins.keys()));


    def die(self):
        self.stop_all_plugins();
        self.lights_off();
        sys.exit(0);


    def lights_off(self):
        self.network.all_devs_off();



if __name__ == "__main__":
    p = argparse.ArgumentParser(description="The ACRIS Master Server");

    p.add_argument('-s', '--server-host', dest='skthost', action='store',
            default='', help='host address to bind to');
    p.add_argument('-p', '--server-port', dest='sktport', action='store',
            default=55555, type=int, help='host port to bind to');

    p.add_argument('-P', '--serial-port', dest='serport', action='store',
            default='/dev/ttyUSB0', help='serial port');
    p.add_argument('-B', '--serial-baud', dest='serbaud', action='store',
            default='38400', help='serial baud rate');
    p.add_argument('-R', '--serial-parity', dest='serprty', action='store',
            default='even', help='serial parity (none, even, odd)');

    p.add_argument('--homebridge-push-host', dest='homebridge_push_host', action='store',
            default=None, help='if specified alongside --homebridge-push-port, \
            ACRIS will push a "homebridge-http-notification-server"-compatible \
            message on plugin state change');

    p.add_argument('--homebridge-push-port', dest='homebridge_push_port', action='store',
            default=None, type=int, help='if specified alongside \
            --homebridge-push-host, ACRIS will push a \
            "homebridge-http-notification-server"-compatible message on \
            plugin state change');


    args = p.parse_args();

    if   args.serprty == "even": serparity = serial.PARITY_EVEN;
    elif args.serprty == "odd":  serparity = serial.PARITY_ODD;
    else:                        serparity = serial.PARITY_NONE;

    acris = Acris(args.skthost, int(args.sktport), args.serport, int(args.serbaud), serparity);
    acris.set_interpreter(CommandInterpreter(acris));
    acris.set_server(get_httpd(acris, args.skthost, args.sktport));

    if args.homebridge_push_host and args.homebridge_push_port:
        push_service = HomebridgePushService(args.homebridge_push_host, args.homebridge_push_port);
        acris.set_push_service(push_service);

    acris.run_server();
