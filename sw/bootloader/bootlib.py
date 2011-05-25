import serial, sys, time

class Bootloader:
    PAGESIZE=128

    CMDS = {
            'SYNC': chr(0xAA),
            'NOP' : 'N',
            'MASK': 'M',
            'ADDR': 'A',
            'BAUD': 'B',
            'BOOT': 'R',
            'DSPH': 'D',
            'DSPL': 'E',
            'PROG': 'P',
            'FNSH': 'F'
            };

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

    def setaddr(self, addr):
        self.write(self.CMDS['SYNC']);
        self.write(self.CMDS['ADDR']);
        self.write(chr(addr));

    def setbaud(self, baud, double):
        # convert prescale into two bytes
        self.write(self.CMDS['SYNC']);
        self.write(self.CMDS['BAUD']);
        self.write(chr(baud>>8));
        self.write(chr(baud&0xFF));
        if double:
            self.write(chr(1));
        else:
            self.write(chr(0));

    def disph(self):
        self.write(self.CMDS['SYNC']);
        self.write(self.CMDS['DSPH']);

    def displ(self):
        self.write(self.CMDS['SYNC']);
        self.write(self.CMDS['DSPL']);

    def mask(self, mask):
        self.write(self.CMDS['SYNC']);
        self.write(self.CMDS['MASK']);
        self.write(chr(mask));

    def boot(self):
        self.write(self.CMDS['SYNC']);
        self.write(self.CMDS['BOOT']);

    def prog(self, addr, bytearr, csum):
        self.write(self.CMDS['SYNC']);
        self.write(self.CMDS['PROG']);
        self.write(chr(addr>>8));
        self.write(chr(addr&0xFF));
        for _ in bytearr: self.write(chr(_));
        self.write(chr(csum))

    def finish(self):
        self.write(self.CMDS['SYNC']);
        self.write(self.CMDS['FNSH']);

    def program(self, file):
        # file is an intel hex file, which has the format
        #   : [1 NUMBYTES] [2 Address] [1 Record Type] [n DATA] [1 Checksum]
        f = open(file, 'r');

        addrs = [0];
        datastrs = [""];
        offset = 0;

        for line in f.readlines():
            line = line.rstrip('\r\n')
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

        dlists = [];
        for d in datastrs:
            # split strings into chunks of size self.PAGESIZE*2 (two characters per byte)

            # http://stackoverflow.com/questions/312443/how-do-you-split-a-list-into-evenly-sized-chunks-in-python
            dlist = [d[i:i+self.PAGESIZE*2] for i in range(0, len(d), self.PAGESIZE*2)]

            # fill the rest of the last entry
            if len(dlist[-1]) < self.PAGESIZE*2:
                dlist[-1] += "F"*(self.PAGESIZE*2-len(dlist[-1]));

            dlists.append(dlist);

        # now we have strings of size self.PAGESIZE*2
        for _ in zip(addrs, dlists):
            addr = _[0];
            dlist = _[1];

            # split data string into bytes
            for d in dlist:
                b = [int(d[i:i+2],16) for i in range(0, len(d), 2)]
                csum = ~sum(b);

                print "writing 0x%03x" % addr,;
                self.prog(addr, b, (csum&0xFF));
                time.sleep(0.100);
                print "-> done";

                addr += self.PAGESIZE
