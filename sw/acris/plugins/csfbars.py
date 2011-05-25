import time

import backend.plugin
import backend.utils

import controllers.wallsconce
import controllers.hknboard

import random

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

        self.left = controllers.wallsconce.WallSconce(network, 1);
        self.addresses.append(self.left.address);

        self.right = controllers.wallsconce.WallSconce(network, 0);
        self.addresses.append(self.right.address);

        self.hkns = [ controllers.hknboard.HKNBoard(network, 0x40 + i) for i in range(4) ];
        self.addresses.extend([_.address for _ in self.hkns]);

    def run(self):
        backend.plugin.Plugin.run(self);

        if len(self.args) >= 1: maxv = int(self.args[0]);
        else:                   maxv = 255;

        if len(self.args) >= 2: alpha = float(self.args[1]);
        else:                   alpha = .1;

        if len(self.args) >= 3: timestep = float(self.args[2]);
        else:                   timestep = .01;

        if len(self.args) >= 4: chgdelay = float(self.args[3]);
        else:                   chgdelay = .05;


        lights = [];
        for col in range(4):
            _ = [];
            for row in range(5):
                _.append([0,0,0]);
            lights.append(_);

        target = [0]*len(lights);
        vals = [];
        for col in range(len(lights)):
            vals.append([0,0,0,0,0]);

        hues = [90, 75, 60, 30, 0];
        changect = 0;

        while self.enabled:
            if changect == 0:
                # get new target values
                for col in range(len(target)):
                    target[col] = random.random()*len(lights[0]);
                changect = 0;

            changect = (changect+1)%int(chgdelay/timestep);

            # adjust the current values to get to the target value
            for col in range(len(vals)):
                for row in range(len(vals[0])):
                    vals[col][row] = max(0.0, min(1.0,
                        alpha*(target[col] - row) +
                        (1-alpha)*vals[col][row]));

            # convert hsv2rgb for all pixels
            for col in range(len(lights)):
                for row in range(len(lights[0])):
                    _ = backend.utils.hsv2rgb(hues[row], 1.0, vals[col][row]);
                    lights[col][row] = [ int(maxv*_[i]) for i in range(3) ];

            # update all lights
            for i in range(4):
                self.hkns[i].each(lights[i]);

            self.left.all(lights[0][0]);
            self.right.all(lights[3][4]);

            # clear lights display
            for row in range(len(lights)):
                for col in range(len(lights[0])):
                    lights[row][col] = 0;

            # wait a bit before producing next frame
            time.sleep(timestep);
