#!/usr/bin/env python2

# counts to 16

import serial, time

cxn = serial.Serial("/dev/ttyS0", 38400, parity=serial.PARITY_EVEN);
print ":: opened", cxn.portstr;

i = 0
while True:
   cxn.write(chr(i));
   i = (i+1) % 0x7;
   time.sleep(.05);
