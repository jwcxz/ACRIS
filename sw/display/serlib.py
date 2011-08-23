#!/usr/bin/env python2

import math, time, serial, sys

SYNC=170

def convert(d):
    return chr(min(255, max(0, int(d))));

def limit(i):
    if i == 170: return 171;
    else: return i

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

