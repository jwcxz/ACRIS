import serial

class Commands:
    LDSET = 0xAA;
    HDSET = 0x01;
    LDALL = 0x10;
    HDALL = 0x11;

class Network:
    SYNC = 0x55.to_bytes(1, 'little');

    def __init__(self, port='/dev/ttyS0', baud=38400, parity=serial.PARITY_EVEN):
        # the default baud rate is 38400, but it will vary based on user
        # configuration
        self.cxn = serial.Serial(port, baud, parity=parity)

    def send(self, bytestr):
        self.cxn.write(bytestr);
        self.cxn.flush();

    def cmd(self, args, sendsync=True):
        # send a command string
        s = b"";
        if sendsync: s += self.SYNC;
        for a in args: s += self.c(a);

        self.send(s);

    def inst(self, addr, command, args):
        # silly wrapper to perform a command on a single light
        self.cmd([command, addr] + args);

    def group(self, group, args):
        # send a command to a group of lights
        self.cmd([command, 250+self.c(group)] + args);

    def dev_off(self, address):
        self.cmd([Commands.LDSET, address] + [0]*15);

    def all_devs_off(self):
        self.cmd([Commands.LDSET, 0xFF] + [0]*15);

    # utilities
    def c(self, v):
        # convert to a value acceptable for input (don't allow sync)
        _ = min(255, max(0, int(v)));
        if _ == ord(self.SYNC):
            return (_+1).to_bytes(1, 'little');
        else:
            return _.to_bytes(1, 'little');

class DummyNetwork(Network):
    def __init__(self):
        pass;

    def send(self, bytestr):
        print("> SEND: %r" % ([ "%02x" % b for b in bytestr ]));
