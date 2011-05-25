#!/usr/bin/env python2

import math, time, serial, sys

SYNC=0x55;
timestep = 0.01;
huestep = 1;
maxrange = int(sys.argv[1]);
huephase=15;

def convert(d):
    #if d == SYNC: d += 1;
    return chr(min(255, max(0, int(d))));

def hsv2rgb(h, s, v):
    hi = math.floor(h / 60.0) % 6
    f =  (h / 60.0) - math.floor(h / 60.0)
    p = v * (1.0 - s)
    q = v * (1.0 - (f*s))
    t = v * (1.0 - ((1.0 - f) * s))
    return { 0: (v, t, p), 1: (q, v, p), 2: (p, v, t), 3: (p, q, v), 4: (t, p, v), 5: (v, p, q), }[hi]

def wbyte(a, b):
    return [ (a>>4)&0xFF , ((a&0xF) << 4) | ( (b>>8)&0xF ) , b&0xFF ];

def send(rgb):
    sendarr = [ 0x01, int(sys.argv[2]) ];

    sendarr.extend( wbyte(0, rgb[0][0])[1:3] );
    sendarr.extend( wbyte(rgb[0][1], rgb[0][2]) );
    sendarr.extend( wbyte(rgb[1][0], rgb[1][1]) );
    sendarr.extend( wbyte(rgb[1][2], rgb[2][0]) );
    sendarr.extend( wbyte(rgb[2][1], rgb[2][2]) );
    sendarr.extend( wbyte(rgb[3][0], rgb[3][1]) );
    sendarr.extend( wbyte(rgb[3][2], rgb[4][0]) );
    sendarr.extend( wbyte(rgb[4][1], rgb[4][2]) );

    #print sendarr

    sendstr = chr(SYNC);
    for _ in sendarr:
        sendstr += convert(_);

    cxn.write(sendstr);


serport = "/dev/ttyUSB0"
cxn = serial.Serial(serport, 38400, parity=serial.PARITY_EVEN);
print ":: opened", cxn.portstr;

hue = 0;

while True:
    rgb = [ [ int(maxrange*_) for _ in hsv2rgb(hue+offs, 1.0, 1.0) ] for offs in (2*huephase, 1*huephase, 0, 1*huephase, 2*huephase) ];
    #print rgb
    send(rgb);
    hue = (hue-huestep) % 360.;
    time.sleep(timestep);

cxn.close();
