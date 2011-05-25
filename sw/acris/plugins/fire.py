import math, random, time

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

        hueparams = { 'scale': [2, 10, 10], 'frequency': [1.0, .2, .1], 'offset': [2, 10, 20]};
        valrdmparams = { 'rangelo': 0.6, 'rangehi': 0.75 };
        valparams = { 'offset': [0, .1, .2] };
        sat = [ 1.0, 1.0, 1.0 ];

        maxv = 100;
        timedelay = 0.05;
        step = 0;

        while self.enabled:
            #hue = [
                #hueparams['scale'][i] * math.sin(step * hueparams['frequency'][i]) +
                #hueparams['offset'][i] for i in range(3) ];

            hue = [5, 10, 20];

            _ = random.uniform(valrdmparams['rangelo'], valrdmparams['rangehi']);
            val = [ min(1.0, _+valparams['offset'][i]) for i in range(3) ];

            rgb = [ [ int(maxv * i) for i in backend.utils.hsv2rgb(hue[j], sat[j], val[j]) ] for j in range(3) ];

            self.left.each(rgb[0], rgb[1], rgb[2]);
            self.right.each(rgb[0], rgb[1], rgb[2]);

            time.sleep(timedelay);
            #step += 1;
