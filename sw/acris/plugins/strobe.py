import backend.plugin, time

class Plugin(backend.plugin.Plugin):
    def run(self): 
        backend.plugin.Plugin.run(self);

        if len(self.args) >= 1: offtime = float(self.args[0]);
        else:                   offtime = .07

        if len(self.args) >= 2: ontime = float(self.args[1]);
        else:                   ontime = .01

        oncmd = [255, 220, 220, 220, 0, 0, 0, 220, 220, 220, 0, 0, 0, 220, 220, 220];
        offcmd = [255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

        while self.enabled:
            self.network.cmd(oncmd);
            time.sleep(ontime);

            self.network.cmd(offcmd);
            time.sleep(offtime);
