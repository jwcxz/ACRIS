import backend.plugin, time

default_params = backend.plugin.PluginConfig(
        brightness = 1.0,
        on_time = 0.01,
        off_time = 0.07,
        maxv = 200
        );

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, params):
        super().__init__(network, params);

    def run(self):
        super().run();

        value = int(self.params['maxv'] * self.params['brightness']);

        on_cmd = [255, value, value, value, 0, 0, 0, value, value, value, 0, 0,
                    0, value, value, value];
        off_cmd = [255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

        while self.enabled:
            self.network.cmd(on_cmd);
            time.sleep(self.params['on_time']);

            self.network.cmd(off_cmd);
            time.sleep(self.params['off_time']);
