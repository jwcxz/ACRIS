#!/usr/bin/env python2

from serlib import *

sat = 1.0;
val = 1.0;
hue = 0;

# phase = [ 0, 45, 90, 135 ];
maxphase = 45;
maxv = 128;
timedelay = 0.1
huestep = 1;

phase = range(0,maxphase,maxphase/4);
while 1:
    p1 = limit([ int(maxv * i) for i in hsv2rgb(hue + phase[0], sat, val) ]);
    p2 = limit([ int(maxv * i) for i in hsv2rgb(hue + phase[1], sat, val) ]);
    p3 = limit([ int(maxv * i) for i in hsv2rgb(hue + phase[2], sat, val) ]);
    p4 = limit([ int(maxv * i) for i in hsv2rgb(hue + phase[3], sat, val) ]);

    cxn.write(convert(SYNC) + convert(0) +
            convert(p1[0]) + convert(p1[1]) + convert(p1[2]) +
            convert(0) + convert(0) + convert(0) + 
            convert(0) + convert(0) + convert(0) + 
            convert(0) + convert(0) + convert(0) + 
            convert(0) + convert(0) + convert(0)
            );

    time.sleep(timedelay);
    hue += huestep;

print "done"
sys.exit(0);
