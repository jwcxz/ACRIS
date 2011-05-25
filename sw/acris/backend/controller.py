from backend.network import Commands as cmd
import backend.utils

class Controller:
    mode = "ld";

    def __init__(self, network, address):
        self.network = network; # serial connection
        self.address = address; # device address

    def set_mode(self, newmode):
        if newmode == "hd":
            self.mode = "hd";
        elif newmode == "ld":
            self.mode = "ld";

    def set(self, args):
        if self.mode == "ld":
            self.ldset(args);
        else:
            self.hdset(args);

    def hdset(self, args):
        packedargs = backend.utils.hdpack(args);
        self.network.cmd([cmd.HDSET, self.address]+packedargs);

    def ldset(self, args):
        packedargs = [];

        for i in range(5):
            packedargs.extend(args[i]);

        self.network.cmd([cmd.LDSET, self.address]+packedargs);
