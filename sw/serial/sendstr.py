#!/usr/bin/env python2

import math, time, serial, sys

SYNC=0x55

def convert(d):
    if d == SYNC: d += 1;
    return chr(min(255, max(0, int(d))));

serport = "/dev/ttyUSB0"
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
    
    print sendarr;
    
    sendstr = chr(SYNC);
    for _ in sendarr:
        sendstr += convert(_);

    cxn.write(sendstr);
    
    
send( [ int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]) ] );

cxn.close();
