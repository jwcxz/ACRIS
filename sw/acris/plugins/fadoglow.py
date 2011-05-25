import time

import backend.plugin
import backend.utils

import controllers.fado

default_params = backend.plugin.PluginConfig(
        value = 0.1,
        value_denom = 1.0,
        time_delay = 0.05,
        hue_step = 1,
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

        # TODO: find a better way to handle value normalization
        value_norm = float(self.params['value'])/float(self.params['value_denom']);

        color = backend.plugin.PluginColor(0, 1.0, value_norm);

        while self.enabled:
            rgb = color.as_rgb_int(self.params['maxv']);
            self.fado.all(rgb);

            time.sleep(self.params['time_delay']);
            color['hue'] = ((360*color['hue'] + self.params['hue_step']) % 360) / 360.;
