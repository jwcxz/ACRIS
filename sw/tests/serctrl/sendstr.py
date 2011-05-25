#!/usr/bin/env python2

import math, time, serial, sys

SYNC=0x55

def convert(d):
    if d == SYNC: d += 1;
    return chr(min(255, max(0, int(d))));

def wbyte(a, b):
    return [ (a>>4)&0xFF , ((a&0xF) << 4) | ( (b>>8)&0xF ) , b&0xFF ];

def send(rgb):
    sendarr = [ 0x01, 0xFF ];
    r,g,b = rgb;

    """
    sendarr.append( r>>8 );
    sendarr.append( r&0xFF );
    sendarr.append( g>>4 );
    sendarr.append( ((g&0xF)<<4) | b>>8 );
    sendarr.append( b&0xFF );
    """

    sendarr.extend( wbyte(0, r)[1:3] );
    sendarr.extend( wbyte(g, b) );
    sendarr.extend( wbyte(r, g) );
    sendarr.extend( wbyte(b, r) );
    sendarr.extend( wbyte(g, b) );
    sendarr.extend( wbyte(r, g) );
    sendarr.extend( wbyte(b, r) );
    sendarr.extend( wbyte(g, b) );

    print sendarr;

    sendstr = chr(SYNC);
    for _ in sendarr:
        sendstr += convert(_);

    cxn.write(sendstr);


serport = "/dev/ttyUSB0"
cxn = serial.Serial(serport, 38400, parity=serial.PARITY_EVEN);
print ":: opened", cxn.portstr;

send( [ int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]) ] );

cxn.close();
