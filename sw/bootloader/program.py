#!/usr/bin/env python2

import argparse, time
from bootlib import *

p = argparse.ArgumentParser(description="Program the LED Controller");

p.add_argument(dest='file', metavar='file', type=str,
        help='Intel HEX input file');

p.add_argument("-p", "--port", dest='port', action='store', default="/dev/ttyUSB0",
        help='communications port');

args = p.parse_args();

btldr = Bootloader(args.port);
# wait for the bootloader to activate
btldr.activate();

f = open(args.file, 'r');

# file is an intel hex file, which has the format
#   : [1 NUMBYTES] [2 Address] [1 Record Type] [n DATA] [1 Checksum]

addrs = [0];
datastrs = [""];
offset = 0;

for line in f.readlines():
    numbytes = line[1:2+1];
    address = line[3:6+1];
    rectype = line[7:8+1];
    data = line[9:-2];
    csum = line[-2:];

    if rectype == "00":
        addrnum = int(address, 16);
        if addrnum == addrs[-1] + offset:
            datastrs[-1] += data;
            offset += int(numbytes, 16);
        else:
            addrs.append(addrnum);
            offset = 0;
            datastrs.append(data);

pagesize=128

dlists = [];
for d in datastrs:
    # split strings into chunks of size pagesize*2 (two characters per byte)

    # http://stackoverflow.com/questions/312443/how-do-you-split-a-list-into-evenly-sized-chunks-in-python
    dlist = [d[i:i+pagesize*2] for i in range(0, len(d), pagesize*2)]

    if len(dlist[-1]) < pagesize*2:
        dlist[-1] += "0"*(pagesize*2-len(dlist[-1]));

    dlists.append(dlist);

# now we have strings of size pagesize*2
for _ in zip(addrs, dlists):
    addr = _[0];
    dlist = _[1];
    
    # split data string into bytes
    for d in dlist:
        b = [int(d[i:i+2],16) for i in range(0, len(d), 2)]
        csum = ~sum(b);

        btldr.write(chr(170));
        btldr.write('P');
        btldr.write(chr(addr>>8));
        btldr.write(chr(addr&0xFF));
        for _ in b: btldr.write(chr(_));
        btldr.write(chr(csum&0xFF));

        print 170;
        print 'P';
        print addr, addr>>8, addr&0xFF;
        print b;
        print csum;

        time.sleep(0.500);

        addr += pagesize
