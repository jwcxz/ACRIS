import math, random, time

import backend.plugin
import backend.utils

import controllers.wallsconce

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);
        self.left = controllers.wallsconce.WallSconce(network, 1);
        self.right = controllers.wallsconce.WallSconce(network, 0);

    def run(self): 
        backend.plugin.Plugin.run(self);

        hueparams = { 'scale': [2, 10, 10], 'period': [.4, .2, .1], 'offset': [2, 10, 20]};
        valrdmparams = { 'rangelo': 0.8, 'rangehi': 1.0 };
        valparams = { 'offset': [0, .1, .2] };
        sat = [ 1.0, 1.0, 1.0 ];

        maxv = 100;
        timedelay = 0.1;
        step = 0;

        while self.enabled:
            hue = [ 
                hueparams['scale'][i] * math.sin(step * hueparams['period'][i]) +
                hueparams['offset'][i] for i in xrange(3) ];

            _ = random.uniform(valrdmparams['rangelo'], valrdmparams['rangehi']);
            val = [ min(1.0, _+valparams['offset'][i]) for i in xrange(3) ]; 

            rgb = [ [ int(maxv * i) for i in backend.utils.hsv2rgb(hue[j], sat[j], val[j]) ] for j in xrange(3) ];
            
            self.left.each(rgb[0], rgb[1], rgb[2]);
            self.right.each(rgb[0], rgb[1], rgb[2]);

            time.sleep(timedelay);
            step += 1;
