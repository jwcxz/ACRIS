class Controller:
    def __init__(self, network, address):
        self.network = network; # serial connection
        self.address = address; # device address

    def set(self, args):
        self.network.cmd([self.address]+args);
