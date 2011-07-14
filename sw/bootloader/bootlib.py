#!/usr/bin/env python2

import serial, sys

class Bootloader:
    def __init__(self, port='/dev/ttyS0'):
        # bootloader baud rate is forced at 9600
        self.cxn = serial.Serial(port, 9600);

    def activate(self):
        # TODO
        #self.cxn.write(chr(0x200));
        self.cxn.flush();
    
    def write(self, data):
        self.cxn.write(data);
        self.cxn.flush();
