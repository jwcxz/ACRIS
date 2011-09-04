import serial

class Network:
    SYNC = chr(170);

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

    def inst(self, addr, args):
        # silly wrapper to perform a command on a single light
        self.cmd([addr]+args);

    def group(self, group, args):
        # send a command to a group of lights
        self.cmd(self, [250+self.c(group)]+args);

    # utilities
    def c(self, v):
        # convert to a value acceptable for input (don't allow sync)
        _ = min(255, max(0, int(v)));
        if _ == self.SYNC: 
            return chr(_+1);
        else:
            return chr(_);
