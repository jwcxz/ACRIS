import backend.plugin, time

class Plugin(backend.plugin.Plugin):
    def run(self): 
        backend.plugin.Plugin.run(self);

        if len(self.args) >= 1: offtime = float(self.args[0]);
        else:                   offtime = .07

        if len(self.args) >= 2: ontime = float(self.args[1]);
        else:                   ontime = .01

        oncmd = [255, 100, 100, 100, 0, 0, 0, 100, 100, 100, 0, 0, 0, 100, 100, 100];
        offcmd = [255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

        while self.enabled:
            self.network.cmd(oncmd);
            time.sleep(ontime);

            self.network.cmd(offcmd);
            time.sleep(offtime);
