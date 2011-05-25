#!/usr/bin/env python2

import argparse, math, time, serial, sys


def mkpld(arr):
    return "".join([ chr(_) for _ in arr ]);


if __name__ == "__main__":
    p = argparse.ArgumentParser(description='tester for communicating with the NRF24L01+');

    p.add_argument('-a', '--addr', dest='addr', type=str, nargs=3,
            default=['0xC2', '0xC2', '0xC2'], help='target address to send payload to');

    p.add_argument('-s', '--size', dest='size', type=int,
            default=25, help='payload size');

    p.add_argument('-S', '--sync', dest='sync', type=int,
            default=3, help='number of syncs to send');

    p.add_argument('-p', '--port', dest='port', type=str,
            default='/dev/ttyUSB0', help='serial port');

    p.add_argument('-b', '--baud', dest='baud', type=int,
            default=38400, help='serial baud');

    args = p.parse_args();

    cxn = serial.Serial(args.port, args.baud, parity=serial.PARITY_NONE, timeout=0.5);
    cxn.flush();

    pld = range(args.size);

    try:
        while True:
            for i in xrange(len(pld)):
                pld[i] = (pld[i] + 1) % 256;

            pkt  = chr(0xAA)*args.sync;
            pkt += "".join([ chr(int(_, 0)) for _ in args.addr ]);

            pkt += mkpld(pld);

            cxn.write(pkt);

            addr = cxn.read(3);
            addr = [ "%02X" % ord(_) for _ in addr ];
            addr = "0x" + "".join(addr);

            ack = cxn.read(1);
            if ack == ".":
                ack = "okay";
            elif ack == "X":
                ack = "FAIL";
            else:
                ack = "ERR!";

            print "%s -> %s: %s" % (ack, addr, " ".join(["%02X" % ord(_) for _ in pkt]));

            time.sleep(0.05);

    except KeyboardInterrupt:
        print "stop"
        cxn.close();
