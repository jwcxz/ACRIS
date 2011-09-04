import backend.plugin

class Plugin(backend.plugin.Plugin):
    def run(self): 
        backend.plugin.Plugin.run(self);

        self.network.cmd([255]+self.args);
        self.enabled = False;
