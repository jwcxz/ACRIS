#!/usr/bin/env python2

import argparse, serial, socket, sys

import backend.network

import plugins

class Acris:
    def __init__(self, skthost='localhost', sktport=55555, serport='/dev/ttyUSB0', serbaud=38400, serparity=serial.PARITY_EVEN):
        self.network = backend.network.Network(serport, serbaud, serparity);

        # build plugins list
        # name -> (obj, description)
        self.plugins = {};
        self.refresh_plugins();

        # current plugins
        # name -> instance
        self.activated = {};

        # addresses in use by plugins
        self.used_addresses = [];

        # socket configuration
        self.skthost = skthost;
        self.sktport = sktport;


    def run(self):
        blog = 5;
        size = 1024;

        self.skt = socket.socket(socket.AF_INET, socket.SOCK_STREAM);
        self.skt.bind( (self.skthost,self.sktport) );
        self.skt.listen(blog);

        while True:
            try:
                client, address = self.skt.accept();
                print ":: Accepted", address
                data = client.recv(size);
                print "::   Received:", data.rstrip();
                statusmsg = "";
                if data:
                    # data contains a command and optional arguments
                    data = data.split(None);
                    cmd = data[0]

                    if cmd == "plugin":
                        if data[1] in self.plugins:
                            statusmsg = "Activating %s with args %r" %(data[1], data[2:]);
                            if not self.activate_plugin(data[1], data[2:]):
                                statusmsg = "Failed to activate %s: addresses in use" %(data[1]);
                        else:
                            statusmsg = "Plugin %s (with args %r) not found)" %(data[1], data[2:]);

                    elif cmd == "stop":
                        statusmsg = "Stopping %s" %(data[1]);
                        if not self.stop_plugin(data[1]):
                            statusmsg = "Failed to stop %s: not activated" %(data[1]);

                    elif cmd == "stopall":
                        statusmsg = "Stopping all plugins and shutting lights off";
                        act = self.activated.keys();
                        for p in act:
                            self.stop_plugin(p);
                        self.lights_off();

                    elif cmd == "list":
                        statusmsg = "Available plugins: "
                        for p in self.plugins:
                            statusmsg += "\n    %s: %s" % (p, self.plugins[p][1]);

                    elif cmd == "activated":
                        statusmsg = "Activated plugins: %s" %( ' '.join(self.activated.keys()) );

                    elif cmd == "addresses":
                        statusmsg = "Addresses in use: %s" %( ' '.join(["0x%02X" %(a) for a in self.used_addresses]) );

                    elif cmd == "refresh":
                        statusmsg = "Reloading plugins"
                        self.refresh_plugins();

                    elif cmd == "die":
                        act = self.activated.keys();
                        for p in act:
                            self.stop_plugin(p);
                        self.lights_off();

                        statusmsg = "Exiting";
                        print "::  ", statusmsg;  # hack
                        client.send(statusmsg);   #
                        self.skt.shutdown(socket.SHUT_RDWR);
                        self.skt.close();
                        sys.exit(0);

                    else:
                        statusmsg = "Invalid command";

                print "::  ", statusmsg;
                client.send(statusmsg+"\n");
                client.close();
            except socket.error:
                print "whoops"

    def lights_off(self):
        self.network.cmd([255, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0]);

    def activate_plugin(self, pluginname, args):
        pluginobj = self.plugins[pluginname][0];
        newplugin = pluginobj(self.network, args);

        # if pulgin is already activated, replace it; otherwise ensure that
        # only one plugin can access each address
        if pluginname in self.activated:
            print "Plugin already active.  Restarting...";
            self.stop_plugin(plugginname);
        else:
            for addr in newplugin.addresses:
                if addr in self.used_addresses:
                    print "Addresses in use already:", newplugin.addresses, self.used_addresses;
                    return False;

        self.activated[pluginname] = newplugin;
        self.used_addresses.extend(newplugin.addresses);
        self.activated[pluginname].start();
        return True;

    def stop_plugin(self, pluginname):
        if pluginname in self.activated and self.activated[pluginname] != None:
            if self.activated[pluginname].enabled:
                self.activated[pluginname].stop();
                
            # free up addresses
            for addr in self.activated[pluginname].addresses:
                if addr in self.used_addresses:
                    self.used_addresses.remove(addr);
                else:
                    print "Warning: 0x%02X not in address list" % addr;

            # garbage collect
            del(self.activated[pluginname]);
            return True

        else:
            print "Error: %s not activated" %(pluginname);
            return False


    def refresh_plugins(self):
        reload(plugins);

        for p in plugins.__all__:
            _ = __import__('plugins.'+p, globals(), locals(), [p], -1);
            reload(_);
            self.plugins[p] = (_.Plugin, plugins.enabled[p]);

        print "-> Refreshed plugins: %s" % ' '.join(self.plugins.keys());


p = argparse.ArgumentParser(description="The ACRIS Master Server");

p.add_argument('-s', '--server-host', dest='skthost', action='store', default='localhost', help='host address to bind to');
p.add_argument('-p', '--server-port', dest='sktport', action='store', default='55555', help='host port to bind to');

p.add_argument('-P', '--serial-port', dest='serport', action='store', default='/dev/ttyUSB0', help='serial port');
p.add_argument('-B', '--serial-baud', dest='serbaud', action='store', default='38400', help='serial baud rate');
p.add_argument('-R', '--serial-parity', dest='serprty', action='store', default='even', help='serial parity (none, even, odd)');

args = p.parse_args();

if   args.serprty == "even": serparity = serial.PARITY_EVEN;
elif args.serprty == "odd":  serparity = serial.PARITY_ODD;
else:                        serparity = serial.PARITY_NONE;

acris = Acris(args.skthost, int(args.sktport), args.serport, int(args.serbaud), serparity);
acris.run();
