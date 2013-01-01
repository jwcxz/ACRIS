import math

def hsv2rgb(h, s, v):
    hi = math.floor(h / 60.0) % 6
    f =  (h / 60.0) - math.floor(h / 60.0)
    p = v * (1.0 - s)
    q = v * (1.0 - (f*s))
    t = v * (1.0 - ((1.0 - f) * s))
    return { 0: (v, t, p), 1: (q, v, p), 2: (p, v, t), 3: (p, q, v), 4: (t, p, v), 5: (v, p, q), }[hi]

def wbyte(a, b):
    return [ (a>>4)&0xFF , ((a&0xF) << 4) | ( (b>>8)&0xF ) , b&0xFF ];

def hdpack(hd):
    ld = [];

    ld.extend( wbyte(       0, hd[0][0])[1:3] );
    ld.extend( wbyte(hd[0][1], hd[0][2]) );
    ld.extend( wbyte(hd[1][0], hd[1][1]) );
    ld.extend( wbyte(hd[1][2], hd[2][0]) );
    ld.extend( wbyte(hd[2][1], hd[2][2]) );
    ld.extend( wbyte(hd[3][0], hd[3][1]) );
    ld.extend( wbyte(hd[3][2], hd[4][0]) );
    ld.extend( wbyte(hd[4][1], hd[4][2]) );

    return ld;
