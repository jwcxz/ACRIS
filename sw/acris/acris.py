#!/usr/bin/env python3

import argparse, serial, socket, sys

from backend.network import Network, DummyNetwork
from backend.interpreter import CommandInterpreter
from backend.httpserver import get_httpd

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
        self.used_addresses = [];

        # socket configuration
        self.skthost = skthost;
        self.sktport = sktport;


    def set_interpreter(self, interpreter):
        self.interpreter = interpreter;

    def set_server(self, server):
        self.server = server;

    def run_server(self):
        self.server.serve_forever();


    def update_plugin_params(self, plugin_name, new_params):
        self.plugin_params[plugin_name].update(new_params);


    def start_or_restart_plugin(self, plugin_name, force=False):
        plugin_obj = self.plugins[plugin_name][0];
        new_plugin = plugin_obj(self.network, self.plugin_params[plugin_name]);

        # if plugin is already activated, replace it; otherwise ensure that
        # only one plugin can access each address
        if plugin_name in self.activated:
            print("Plugin already active.  Restarting...");
            self.stop_plugin(plugin_name);
        else:
            # TODO: enable force functionality
            for addr in new_plugin.addresses:
                if addr in self.used_addresses:
                    print("Addresses in use already:", new_plugin.addresses, self.used_addresses);
                    return False;

        self.activated[plugin_name] = new_plugin;
        self.used_addresses.extend(new_plugin.addresses);
        self.activated[plugin_name].start();
        return True;


    def stop_plugin(self, plugin_name):
        if plugin_name in self.activated and self.activated[plugin_name] != None:
            if self.activated[plugin_name].enabled:
                self.activated[plugin_name].stop();

            # free up addresses
            for addr in self.activated[plugin_name].addresses:
                if addr in self.used_addresses:
                    self.used_addresses.remove(addr);
                else:
                    print("Warning: 0x%02X not in address list" % addr);

            # garbage collect
            del(self.activated[plugin_name]);
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
            self.stop_plugin(plugin_name);

        self.lights_off();


    def list_all_plugins(self):
        return self.plugins.keys();


    def list_active_plugins(self):
        return self.activated.keys();


    def list_active_addresses(self):
        return [ "0x%02X" %(a) for a in self.used_addresses ];


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
        self.network.stopall();



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

    args = p.parse_args();

    if   args.serprty == "even": serparity = serial.PARITY_EVEN;
    elif args.serprty == "odd":  serparity = serial.PARITY_ODD;
    else:                        serparity = serial.PARITY_NONE;

    acris = Acris(args.skthost, int(args.sktport), args.serport, int(args.serbaud), serparity);
    acris.set_interpreter(CommandInterpreter(acris));
    acris.set_server(get_httpd(acris, args.skthost, args.sktport));
    acris.run_server();
