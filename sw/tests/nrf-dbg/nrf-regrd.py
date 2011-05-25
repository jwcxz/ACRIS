#!/usr/bin/env python2

import argparse, math, time, serial, sys

nrfregs = [ 'CONFIG',
            'EN_AA',
            'EN_RXADDR',
            'SETUP_AW',
            'SETUP_RETR',
            'RF_CH',
            'RF_SETUP',
            'STATUS',
            'OBSERVE_TX',
            'RPD',
            'RX_ADDR_P0', 'RX_ADDR_P1', 'RX_ADDR_P2', 'RX_ADDR_P3', 'RX_ADDR_P4', 'RX_ADDR_P5',
            'TX_ADDR',
            'RX_PW_P0', 'RX_PW_P1', 'RX_PW_P2', 'RX_PW_P3', 'RX_PW_P4', 'RX_PW_P5',
            'FIFO_STATUS',
            '', '', '', '',
            'DYNPD',
            'FEATURE' ];


if __name__ == "__main__":
    p = argparse.ArgumentParser(description='tester for communicating with the NRF24L01+');

    p.add_argument('-p', '--port', dest='port', type=str,
            default='/dev/ttyUSB0', help='serial port');

    p.add_argument('-b', '--baud', dest='baud', type=int,
            default=38400, help='serial baud');

    p.add_argument(nargs='+', dest='regs', type=str, help='registers to read');

    args = p.parse_args();

    cxn = serial.Serial(args.port, args.baud, parity=serial.PARITY_NONE);
    cxn.flush();

    print "REG REGNAME DATA"
    print "--- ------- ----"

    for reg in args.regs:
        ireg = int(reg, 0);
        cxn.write(chr(ireg));

        inp = ord(cxn.read(1));
        print "0x%02x %s 0x%02x" %(ireg, nrfregs[ireg], inp);

    cxn.close();
