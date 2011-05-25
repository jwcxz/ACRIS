#!/usr/bin/env python2

import argparse, threading, time
from bootlib import *


class KBDWait(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self);
        self.pressed = False;

    def run(self):
        sys.stdin.read(1);
        self.pressed = True;


if __name__ == "__main__":
    p = argparse.ArgumentParser(description="Send Actions to the LED Controller Bootloader");

    p.add_argument('-P', '--port', dest='port', action='store', default='/dev/ttyUSB0',
            help='communications port');

    p.add_argument('-n', '--nops', dest='nops', action='store_true',
            help='send a string of NOPs to initialize the bootloader (stop with ctrl+C)');

    p.add_argument('-m', '--mask', dest='mask', action='store', default=None,
            help='set device mask for all operations');

    p.add_argument('-a', '--address', dest='address', action='store', default=None,
            help='set instrument address');
    p.add_argument('-b', '--baud', dest='baud', action='store', default=None,
            nargs=2, help='set device baud prescale and double', metavar=('BAUD', 'DOUBLE'));
    p.add_argument('-p', '--prog', dest='file', action='store', default=None,
            help='program the device');


    p.add_argument('-D', '--display-high', dest='dsph', action='store_true',
            help='display the high nibble of the address');
    p.add_argument('-d', '--display-low', dest='dspl', action='store_true',
            help='display the low nibble of the address');

    p.add_argument('-f', '--finish', dest='finish', action='store_true',
            help='enable flash after programming');
    p.add_argument('-r', '--boot', dest='boot', action='store_true',
            help='run the application');

    args = p.parse_args();

    btldr = Bootloader(args.port);
    # wait for the bootloader to activate
    btldr.activate();

    if args.nops == True:
        kbw = KBDWait();
        kbw.start();

        while not kbw.pressed:
            btldr.write(btldr.CMDS['NOP']);
            time.sleep(0.150);

    if args.mask != None:
        print "applying mask 0x%02x" % int(args.mask);
        btldr.mask(int(args.mask));
        time.sleep(.1);

    if args.address != None:
        print "setting address 0x%02x" % int(args.address);
        btldr.setaddr(int(args.address));
        time.sleep(.1);

    if args.baud != None:
        print "setting baud prescale 0x%04x with double %s" % (int(args.baud[0]), args.baud[1]);
        btldr.setbaud(int(args.baud[0]), int(args.baud[1]));
        time.sleep(.1);

    if args.file != None:
        print "programming with %s" % args.file;
        btldr.program(args.file);
        time.sleep(.1);

    if args.dsph == True:
        print "displaying high address nibble";
        btldr.disph();
        time.sleep(.1);

    if args.dspl == True:
        print "displaying low address nibble";
        btldr.displ();
        time.sleep(.1);

    if args.finish == True:
        print "re-enabling the application section";
        btldr.finish();
        time.sleep(.1);

    if args.boot == True:
        print "booting the device";
        btldr.boot();
        time.sleep(.1);
