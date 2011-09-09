import backend.plugin, time

class Plugin(backend.plugin.Plugin):
    def run(self): 
        backend.plugin.Plugin.run(self);

        if len(self.args) >= 1: brightness = int(self.args[0]);
        else:                   brightness = 200;

        if len(self.args) >= 2: offtime = float(self.args[1]);
        else:                   offtime = .07

        if len(self.args) >= 3: ontime = float(self.args[2]);
        else:                   ontime = .01

        oncmd = [255, brightness, brightness, brightness, 0, 0, 0, brightness,
                brightness, brightness, 0, 0, 0, brightness, brightness,
                brightness];
        offcmd = [255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

        while self.enabled:
            self.network.cmd(oncmd);
            time.sleep(ontime);

            self.network.cmd(offcmd);
            time.sleep(offtime);
