#!/usr/bin/env python2

import argparse, serial, socket, sys

import backend.network

import plugins

class Acris:
    def __init__(self, skthost='localhost', sktport=55555, serport='/dev/ttyUSB0', serbaud=38400, serparity=serial.PARITY_EVEN):
        self.network = backend.network.Network(serport, serbaud, serparity);

        # build plugins list
        self.plugins = {};
        self.refresh_plugins();

        # current plugin
        self.plugin = None;

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
                print "::   Received:", data[:-1];
                if data:
                    # data contains a command and optional arguments
                    data = data.split(None);
                    cmd = data[0]

                    if cmd == "plugin":
                        if data[1] in self.plugins:
                            statusmsg = "Activating %s with args %r" %(data[1], data[2:]);
                            self.stop_plugin();
                            self.activate_plugin(data[1], data[2:]);
                        else:
                            statusmsg = "Plugin %s (with args %r) not found)" %(data[1], data[2:]);

                    elif cmd == "stop":
                        statusmsg = "Stopping plugin and shutting lights off";
                        self.stop_plugin();
                        self.lights_off();

                    elif cmd == "list":
                        statusmsg = "Available plugins: %r" %self.plugins.keys();

                    elif cmd == "refresh":
                        statusmsg = "Reloading plugins"
                        self.refresh_plugins();

                    elif cmd == "die":
                        self.stop_plugin();
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
        pluginobj = self.plugins[pluginname];
        self.plugin = pluginobj(self.network, args);
        self.plugin.start();

    def stop_plugin(self):
        if self.plugin != None and self.plugin.enabled:
            self.plugin.stop();
            self.plugin = None; # garbage collect

    def refresh_plugins(self):
        reload(plugins);

        for p in plugins.__all__:
            _ = __import__('plugins.'+p, globals(), locals(), [p], -1);
            reload(_);
            self.plugins[p] = _.Plugin;

        print "-> Refreshed plugins: %r" %self.plugins.keys();


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
