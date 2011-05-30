#!/usr/bin/env python2
import math

def hsv2rgb(h, s, v):
    hi = math.floor(h / 60.0) % 6
    f =  (h / 60.0) - math.floor(h / 60.0)
    p = v * (1.0 - s)
    q = v * (1.0 - (f*s))
    t = v * (1.0 - ((1.0 - f) * s))
    return { 0: (v, t, p), 1: (q, v, p), 2: (p, v, t), 3: (p, q, v), 4: (t, p, v), 5: (v, p, q), }[hi]

def h2r(h,s,v):
    hi = math.floor(h/42);
    if hi == 6:
        hi = 0
        f = 0;
    else:
        f = h % 42;

    p = v * ( 255 - s );
    p = p >> 8;
    #print "p", p

    _ = (f*s) / 42;
    q = v * ( 255 - _ );
    q = q >> 8;
    #print "q", q

    _ = ((42-f)*s)/42;
    t = v * ( 255 - _ )
    t = t >> 8;
    #print "t", t

    return { 0: (v, t, p), 1: (q, v, p), 2: (p, v, t), 3: (p, q, v), 4: (t, p, v), 5: (v, p, q), }[hi]

s = 255
v = 128
for h in xrange(255):
    _ = hsv2rgb(h*360/255., s/255., v/255.);
    print h2r(h,s,v),;
    #print [ int(255*__) for __ in _ ];
    #print [ abs(__[0] - __[1]) for __ in zip(h2r(h,s,v),[int(255*___) for ___ in _]) ];
    print ""
