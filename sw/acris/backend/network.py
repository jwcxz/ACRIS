import serial

class Commands:
    LDSET = 0xAA;
    HDSET = 0x01;
    LDALL = 0x10;
    HDALL = 0x11;

class Network:
    SYNC = chr(0x55);

    def __init__(self, port='/dev/ttyS0', baud=38400, parity=serial.PARITY_EVEN):
        # the default baud rate is 38400, but it will vary based on user
        # configuration
        self.cxn = serial.Serial(port, baud, parity=parity)

    def cmd(self, args, sendsync=True):
        # send a command string
        s = "";
        if sendsync: s += self.SYNC;
        for a in args: s += self.c(a);

        self.cxn.write(s);
        self.cxn.flush();

    def inst(self, addr, command, args):
        # silly wrapper to perform a command on a single light
        self.cmd([command, addr] + args);

    def group(self, group, args):
        # send a command to a group of lights
        self.cmd([command, 250+self.c(group)] + args);
        
    def stopall(self):
        self.cmd([Commands.LDSET, 0xFF] + [0]*15);

    # utilities
    def c(self, v):
        # convert to a value acceptable for input (don't allow sync)
        _ = min(255, max(0, int(v)));
        if _ == ord(self.SYNC):
            return chr(_+1);
        else:
            return chr(_);

class DummyNetwork(Network):
    def __init__(self):
        pass;

    def cmd(self, args, sendsync=True):
        pass;
