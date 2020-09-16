import time

import backend.plugin
import backend.utils

import controllers.fado

default_params = backend.plugin.PluginConfig(
        color = backend.plugin.PluginColor(0, 1, 1),
        maxv = 2047
        );

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, params):
        super().__init__(network, params);

        self.fado = controllers.fado.FADO(network, 0x41);
        self.fado.set_mode('hd');
        self.addresses.append(self.fado.address);

    def run(self):
        super().run();

        rgb = [ int(self.params['maxv'] * i) for i in self.params['color'].as_rgb() ];
        self.fado.all(rgb);
