import time

import backend.plugin
import backend.utils

import controllers.fado

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

        self.fado = controllers.fado.FADO(network, 0x41);
        self.fado.set_mode('hd');
        self.addresses.append(self.fado.address);

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
            
            self.fado.all(rgb[0]);

            time.sleep(timedelay);
            hue = (hue + huestep) % 360
