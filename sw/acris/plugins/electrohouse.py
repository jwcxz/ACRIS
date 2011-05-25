import time

import backend.plugin
import backend.utils

import controllers.five
import controllers.wallsconce

import random

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

        self.leftcouch = controllers.five.FiveRGBLeft(network, 0x41);
        self.addresses.append(self.leftcouch.address);

        self.rightcouch = controllers.five.FiveRGBRight(network, 0x42);
        self.addresses.append(self.rightcouch.address);

        self.leftsconce = controllers.wallsconce.WallSconce(network, 1);
        self.addresses.append(self.leftsconce.address);

        self.rightsconce = controllers.wallsconce.WallSconce(network, 0);
        self.addresses.append(self.rightsconce.address);

        for dev in [self.leftcouch, self.rightcouch, self.leftsconce, self.rightsconce]:
            dev.set_mode("hd");

    def updatecouch(self, vector):
        """small helper function to update couch devices
            vector is [ [r,g,b], [r,g,b], ... ]
                      left side      right side
        """

        self.leftcouch.each(vector[:5]);
        self.rightcouch.each(vector[5:]);

    def run(self):
        backend.plugin.Plugin.run(self);

        if len(self.args) >= 1: maxv = int(self.args[0]);
        else:                   maxv = 3172;

        if len(self.args) >= 2: style = self.args[1];
        else:                   style = "linear";

        if len(self.args) >= 3: timestep = float(self.args[1]);
        else:                   timestep = 0.02;

        if len(self.args) >= 4: huestep = int(self.args[3]);
        else:                   huestep = 0.5;


        #couch_hsvs = [ [_*(10),1.0,1.0] for _ in range(5*2) ];
        couch_hsvs = [ [_*(10),1.0,1.0] for _ in [0,2,4,6,8,8,6,4,2,0] ];
        couch_rgbs = [ [0,0,0] for _ in range(5*2) ];

        while self.enabled:
            for led in range(len(couch_hsvs)):
                rgb = backend.utils.hsv2rgb(couch_hsvs[led][0], couch_hsvs[led][1], couch_hsvs[led][2]);
                couch_rgbs[led] = [ int(max(0,min(4095,maxv*_))) for _ in rgb ];
                if style == "linear":
                    couch_hsvs[led][0] += huestep;
                elif style == "mirror":
                    if led < 5:
                        couch_hsvs[led][0] += huestep;
                    else:
                        couch_hsvs[led][0] -= huestep;

            self.updatecouch(couch_rgbs);

            self.leftsconce.twotone(couch_rgbs[3], couch_rgbs[4]);
            self.rightsconce.twotone(couch_rgbs[3], couch_rgbs[4]);

            time.sleep(timestep);
