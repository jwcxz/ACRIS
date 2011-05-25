#!/usr/bin/env python2

import math, time, serial, sys

SYNC=0x55

def convert(d):
    if d == SYNC:
        d += 1;
    return chr(min(255, max(0, int(d))));

def hsv2rgb(h, s, v):
    hi = math.floor(h / 60.0) % 6
    f =  (h / 60.0) - math.floor(h / 60.0)
    p = v * (1.0 - s)
    q = v * (1.0 - (f*s))
    t = v * (1.0 - ((1.0 - f) * s))
    return { 0: (v, t, p), 1: (q, v, p), 2: (p, v, t), 3: (p, q, v), 4: (t, p, v), 5: (v, p, q), }[hi]

if len(sys.argv) < 2:
    serport = "/dev/ttyUSB0"
else:
    serport = sys.argv[1]

cxn = serial.Serial(serport, 38400, parity=serial.PARITY_EVEN);
print ":: opened", cxn.portstr;


def send(rgb):
    sendarr = [ 0x11, 0xFF ];
    r,g,b = rgb;

    sendarr.append( r>>8 );
    sendarr.append( r&0xFF );
    sendarr.append( g>>4 );
    sendarr.append( ((g&0xF)<<4) | b>>8 );
    sendarr.append( b&0xFF );

    sendstr = chr(SYNC);
    for _ in sendarr:
        sendstr += convert(_);

    cxn.write(sendstr);

for step in range(4096):
    send([0, 0, step]);
    time.sleep(0.005);

cxn.close();
