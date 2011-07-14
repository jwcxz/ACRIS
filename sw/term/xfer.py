#!/usr/bin/env python2

import serial, sys

def convert(d):
    return chr(min(255, max(0, int(d))));

cxn = serial.Serial('/dev/ttyUSB0', 9600);
print ":: opened", cxn.portstr;

if len(sys.argv) == 3:
    f = open(sys.argv[2], 'r');
    data = f.readlines();
    print ":: read data from", sys.argv[2];
else:
    data = sys.stdin.readlines();
    print ":: read data from stdin"

if len(data) == 1: data = data[0].split(' ');

tx = "";
for d in data:
    tx += convert(d);

cxn.write(tx);

print "done"
sys.exit(0);
