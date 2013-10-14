#!/usr/bin/env python2

# counts to 16

import serial, time

cxn = serial.Serial("/dev/ttyS0", 38400, parity=serial.PARITY_EVEN);
print ":: opened", cxn.portstr;

i = 0
while True:
    cxn.write(chr(0xAA));
    cxn.write(chr(0x20));

    _ = [0]*15;
    _[ 0 ] = i;
    i = (i+3) % 0xFF;

    for __ in _:
        cxn.write(chr(__));

    cxn.flush();

    time.sleep(0.01);
