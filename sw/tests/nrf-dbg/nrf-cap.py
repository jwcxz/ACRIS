#!/usr/bin/env python2

import argparse, math, time, serial, sys

if __name__ == "__main__":
    p = argparse.ArgumentParser(description='tester for communicating with the NRF24L01+');

    p.add_argument('-p', '--port', dest='port', type=str,
            default='/dev/ttyUSB0', help='serial port');

    p.add_argument('-b', '--baud', dest='baud', type=int,
            default=38400, help='serial baud');

    args = p.parse_args();

    cxn = serial.Serial(args.port, args.baud, parity=serial.PARITY_NONE);
    cxn.flush();

    i = 0;
    while True:
        print "%02X" % ord(cxn.read(1)),;

        if ( i == 0 ):
            print ""
        i = ( i + 1 ) % 30;


    cxn.close();
