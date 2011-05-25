#!/usr/bin/env python2

import argparse, os, socket, sys

parser = argparse.ArgumentParser(description="Client interface for ACRIS",
        epilog="Runs a raw command when no switches are given; brings up a color chooser if rgb arguments are required but not given",
        prog="ACRIS Client");

parser.add_argument('-r', '--refresh', action='store_true', dest='refresh', help='reload plugins');
parser.add_argument('-l', '--list', action='store_true', dest='list', help='list available plugins');
parser.add_argument('-a', '--activated', action='store_true', dest='activated', help='list activated plugins');
parser.add_argument('-A', '--addresses', action='store_true', dest='addresses', help='list addresses in use');

parser.add_argument('-p', '--plugin', action='store', dest='plugin', nargs='+', metavar=('PLUGIN', 'ARGS'), help='activate a plugin with arguments');
parser.add_argument('-s', '--stop', action='store', dest='stop', nargs=1, metavar='PLUGIN', help='stop a plugin');
parser.add_argument('-S', '--stop-all', action='store_true', dest='stopall', help='stop all active plugins');

parser.add_argument('-k', '--kill', action='store_true', dest='kill', help='kill the server');

parser.add_argument('-R', '--raw', action='store', dest='raw', nargs='+', metavar='RAWDATA', help='raw data to send to server');

parser.add_argument('-H', '--host', action='store', dest='host', default='localhost', help='ACRIS server host');
parser.add_argument('-P', '--port', action='store', dest='port', default=55555, type=int, help='ACRIS server port');

#parser.add_argument('', action='store', nargs='*', help='Plugin arguments');

args = parser.parse_args();

commands = [];

if args.refresh:
    commands.append("refresh");

if args.list:
    commands.append('list');

if args.activated:
    commands.append('activated');

if args.addresses:
    commands.append('addresses');

if args.stop:
    commands.append('stop ' + args.stop[0]);
elif args.stopall:
    commands.append('stopall');

if args.plugin:
    if len(args.plugin) == 1:
        if args.plugin[0] == 'wallset':
            # bring up color chooser to set wall lamps
            x = os.popen("kcolorchooser --print --color \#700000");
            color = x.read();
            x.close();

            color = color.rstrip().strip("#");
            if len(color) != 6:
                print("Invalid color chosen");
                sys.exit(1);
            else:
                args.plugin.extend([ str(int(color[i:i+2], 16)) for i in range(0,6,2) ]);

    commands.append('plugin ' + ' '.join(args.plugin));

if args.raw:
    commands.append(' '.join(args.raw));

if args.kill:
    commands = ['die'];

for c in commands:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((args.host, args.port));
    print("Sending %s" % c);
    s.send(c);
    data = s.recv(1024)
    s.close()
    print(data,)
