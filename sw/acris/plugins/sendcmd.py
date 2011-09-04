import backend.plugin

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

    def run(self): 
        backend.plugin.Plugin.run(self);

        self.network.cmd(self.args, sendsync=False);
        self.enabled = False;
