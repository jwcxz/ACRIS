import backend.plugin

default_params = backend.plugin.PluginConfig(
        values = []
        );

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, params):
        super().__init__(network, params);

    def run(self):
        super().run();

        self.network.cmd([255]+self.params['values']);
        self.enabled = False;
