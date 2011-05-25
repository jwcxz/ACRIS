import time

import backend.plugin
import backend.utils

import controllers.wallsconce

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

        self.left = controllers.wallsconce.WallSconce(network, 1);
        self.addresses.append(self.left.address);

        self.right = controllers.wallsconce.WallSconce(network, 0);
        self.addresses.append(self.right.address);

    def run(self):
        backend.plugin.Plugin.run(self);

        sat = 1.0;
        val = 1.0;
        hue = 0;

        if len(self.args) >= 1: maxv = int(self.args[0]);
        else:                   maxv = 90;

        if len(self.args) >= 2: timedelay = float(self.args[1]);
        else:                   timedelay = 0.05;

        if len(self.args) >= 3: huestep = int(self.args[2]);
        else:                   huestep = 1;

        if len(self.args) >= 4: phaseoff = int(self.args[3]);
        else:                   phaseoff = 45;

        phase = [ 0, phaseoff ];

        while self.enabled:
            rgb = [ [ int(maxv * i) for i in backend.utils.hsv2rgb(hue + x, sat, val) ] for x in phase ];

            self.left.twotone(rgb[1], rgb[0]);
            self.right.twotone(rgb[1], rgb[0]);

            time.sleep(timedelay);
            hue = (hue + huestep) % 360
