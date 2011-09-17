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

        maxv = 100;
        timedelay = 0.05;
        step = 0;

        phase = [ 0, 45, 90 ];
        minhue = 240;
        maxhue = 360;
        sat = 1.0;
        val = 100;

        hueamp = (maxhue - minhue)/2;
        hueoff = minhue + hueamp;

        while self.enabled:
            hue = [ hueamp * math.sin(step * freq + p ) + hueoff for p in phase ];

            rgb = [ [ int(maxv * i) for i in backend.utils.hsv2rgb(h, sat, val) ] for h in hue ];
            
            self.left.each(rgb[0], rgb[1], rgb[2]);
            self.right.each(rgb[0], rgb[1], rgb[2]);

            time.sleep(timedelay);
            step = (step + 1) % freq;
