#!/usr/bin/env python2

import math, time, serial, sys

SYNC=0x55;
timestep = 0.01;
huestep = 1;
maxrange = 4095;

def convert(d):
    if d == SYNC: d += 1;
    return chr(min(255, max(0, int(d))));

def hsv2rgb(h, s, v):
    hi = math.floor(h / 60.0) % 6
    f =  (h / 60.0) - math.floor(h / 60.0)
    p = v * (1.0 - s)
    q = v * (1.0 - (f*s))
    t = v * (1.0 - ((1.0 - f) * s))
    return { 0: (v, t, p), 1: (q, v, p), 2: (p, v, t), 3: (p, q, v), 4: (t, p, v), 5: (v, p, q), }[hi]

def send(rgb):
    sendarr = [ 0x11, 0x80 ];
    r,g,b = [ int(_) for _ in rgb ];
    
    sendarr.append( r>>8 );
    sendarr.append( r&0xFF );
    sendarr.append( g>>4 );
    sendarr.append( ((g&0xF)<<4) | b>>8 );
    sendarr.append( b&0xFF );
    
    sendstr = chr(SYNC);
    for _ in sendarr:
        sendstr += convert(_);

    cxn.write(sendstr);
    

serport = "/dev/ttyUSB0"
cxn = serial.Serial(serport, 38400, parity=serial.PARITY_EVEN);
print ":: opened", cxn.portstr;

send( [ 0, 0, 0 ] );

hue = 0;

while True:
    rgb = [ maxrange*_ for _ in hsv2rgb(hue, 1.0, 1.0) ];
    send(rgb);
    hue = (hue+huestep) % 360.;
    time.sleep(timestep);
    
cxn.close();
