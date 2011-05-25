import backend.plugin
import controllers.wallsconce

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

        self.left = controllers.wallsconce.WallSconce(network, 1);
        self.addresses.append(self.left.address);

        self.right = controllers.wallsconce.WallSconce(network, 0);
        self.addresses.append(self.right.address);

    def run(self):
        backend.plugin.Plugin.run(self);

        if len(self.args) == 3:
            # set all leds to the same color
            self.left.all(self.args);
            self.right.all(self.args);

        elif len(self.args) == 6:
            # set a two-tone color on each
            self.left.twotone(self.args[0:3], self.args[3:6]);
            self.right.twotone(self.args[0:3], self.args[3:6]);

        elif len(self.args) == 9:
            # set all three LEDs on each
            self.left.each(self.args[0:3], self.args[3:6], self.args[6:9]);
            self.right.each(self.args[0:3], self.args[3:6], self.args[6:9]);

        elif len(self.args) == 18:
            # set every led individually
            self.left.each(self.args[0:3], self.args[3:6], self.args[6:9]);
            self.right.each(self.args[9:12], self.args[12:15], self.args[15:18]);

        self.enabled = False;
