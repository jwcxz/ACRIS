import backend.plugin
import time

class Plugin(backend.plugin.Plugin):
    def run(self):
        backend.plugin.Plugin.run(self);

        if len(self.args) >= 1: timedelay = int(self.args[0]);
        else                  : timedelay = 1;

        while self.enabled:
            self.network.cmd([255, 0,0,0, 0,0,0, 0,0,0, 0,0,0, 0,0,0]);
