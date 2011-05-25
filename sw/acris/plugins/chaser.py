import time

import backend.plugin
import backend.utils

import controllers.wallsconce
import controllers.hknboard

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

        self.hkns = [ controllers.hknboard.HKNBoard(network, 0x40 + i) for i in range(4) ];
        self.addresses.extend([_.address for _ in self.hkns]);

        self.numleds = 4*5;


    def run(self):
        backend.plugin.Plugin.run(self);

        if len(self.args) >= 1: maxv = int(self.args[0]);
        else:                   maxv = 255;

        if len(self.args) >= 2: timedelay = float(self.args[1]);
        else:                   timedelay = 0.01;

        if len(self.args) >= 3: decay = int(self.args[2]);
        else:                   decay = 0.7;

        if len(self.args) >= 4: huestep = int(self.args[3]);
        else:                   huestep = 1;

        sat = 1.0;
        hue = 0;

        valstep = 0;
        vals = [0]*(self.numleds);
        vals[valstep] = 1.0;

        while self.enabled:
            # determine rgbs for all lights
            rgbs = [ [ int(maxv * col) for col in backend.utils.hsv2rgb(hue, sat, vals[i]) ] for i in range(self.numleds) ];

            # set outputs
            # first, set the two wall sconces at each side
            # now the hkn boards
            for i in range(0, self.numleds, 5):
                self.hkns[i/5].each(rgbs[i:i+5]);

            # prepare to apply new step
            time.sleep(timedelay);

            # update hue
            hue = (hue + huestep) % 360;

            # update vals
            for i in range(len(vals)):
                if i == valstep:
                    vals[i] = 1.0;
                else:
                    vals[i] = decay * vals[i];

            # update step
            if valstep == 0:
                dir = 'f';
                valstep = 1;
            elif valstep == len(vals)-1:
                dir = 'b';
                valstep = len(vals)-2;
            elif dir == 'f':
                valstep += 1;
            else:
                valstep -= 1;
