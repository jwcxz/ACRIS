import math

import time

import backend.plugin
import backend.utils

import controllers.five
import controllers.wallsconce

import random

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

        self.table = controllers.five.FiveRGBLeft(network, 0x42);
        self.addresses.append(self.table.address);

    def run(self):
        backend.plugin.Plugin.run(self);

        if len(self.args) >= 1: maxv = int(self.args[0]);
        else:                   maxv = 255;

        if len(self.args) >= 2: timestep = float(self.args[1]);
        else:                   timestep = 0.02;

        outers_val = 0;
        outers_phase = 0.0;

        inners_hue = [240,0,240];
        inners_val = [0,0,0];
        inners_phase = [0, math.pi, 0];

        outers_rgb = [0,0,0];
        inners_rgb = [ [0,0,0], [0,0,0], [0,0,0] ];

        while self.enabled:
            # outer LEDs yellow, pulsing
            outers_val = 0.4 * math.cos(outers_phase) + 0.6;

            outers_phase += .07;
            if outers_phase >= 2*math.pi:
                outers_phase = outers_phase - 2*math.pi;

            outers_rgb = [int(maxv*_) for _ in backend.utils.hsv2rgb(60, 1.0, outers_val)];


            # inner LEDs red and blue, flashing slowly
            for v in range(len(inners_val)):
                inners_val[v] = 0.4 * math.cos(inners_phase[v]) + 0.6;
                inners_phase[v] += .15
                if inners_phase[v] >= 2*math.pi:
                    inners_phase[v] = inners_phase[v] - 2*math.pi;

            inners_rgb = [ [int(0.75*maxv*_) for _ in
                backend.utils.hsv2rgb(inners_hue[i], 1.0, inners_val[i])]
                    for i in range(len(inners_hue))];

            self.table.each([outers_rgb, inners_rgb[0], inners_rgb[1], inners_rgb[2], outers_rgb]);
            time.sleep(timestep);
