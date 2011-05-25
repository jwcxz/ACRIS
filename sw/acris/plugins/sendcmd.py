import backend.plugin

default_params = backend.plugin.PluginConfig(
        command = []
        );

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, params):
        super().__init__(network, params);

    def run(self):
        super().run();

        self.network.cmd(self.params['command'], sendsync=False);
        self.enabled = False;
