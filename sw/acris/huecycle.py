#!/usr/bin/env python2

import time

import acris.network
import acris.utils
import wallsconce

# TODO: add arguments for baud
cxn = acris.network.Network();

firstSconce = wallsconce.WallSconce(cxn, 0);

sat = 1.0;
val = 1.0;
hue = 0;

phase = [ 0, 45 ];
maxv = 128;
timedelay = 0.1;
huestep = 4;

while 1:
    p1 = [ int(maxv * i) for i in acris.utils.hsv2rgb(hue + phase[0], sat, val) ];
    p2 = [ int(maxv * i) for i in acris.utils.hsv2rgb(hue + phase[1], sat, val) ];
    
    firstSconce.all(p1);

    time.sleep(timedelay);
    hue += huestep;

print "done"
sys.exit(0);
