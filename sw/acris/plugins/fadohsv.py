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

        hue = 0;
        sat = 1.0;
        val = 1.0;

        maxv = 4095;

        if len(self.args) >= 1: hue = float(self.args[0]);
        if len(self.args) >= 2: sat = float(self.args[1]);
        if len(self.args) >= 3: val = float(self.args[2]);
        if len(self.args) >= 4: maxv = int(self.args[3]);

        rgb = [ int(maxv * i) for i in backend.utils.hsv2rgb(hue, sat, val) ];
        self.fado.all(rgb);
