import threading
import colorsys

class Plugin(threading.Thread):
    enabled = False;

    def __init__(self, network, params):
        threading.Thread.__init__(self);
        # what to do on initialization of the plugin
        self.network = network;
        self.params = params;
        self.enabled = False;
        self.addresses = [];

    def run(self):
        # called to start the thread
        self.enabled = True

    def stop(self):
        # called when the thread is stopped
        self.enabled = False


def rgb_to_hex(crgb, pfx=''):
    chex = ''.join([ "%02x" % round(c*255) for c in crgb ]);
    return pfx + chex;

def hex_to_rgb(chex):
    chex_str = chex;
    if chex_str[0] == '#': chex_str = chex_str[1:];
    chex_lst = [ chex_str[i:i+2] for i in range(0,6,2) ];
    rgb = [ int(h, 16) / 255. for h in chex_lst ];
    return rgb;


class PluginConfig(dict):
    def __init__(self, *args, **kwargs):
        super().__init__(self, *args, **kwargs);

    def update(self, other):
        for key in other.keys():
            try:
                self[key].update(other[key]);
            except:
                self[key] = other[key];

    def copy(self):
        cp = PluginConfig();
        cp.update(self);
        return cp;


class PluginColor(dict):
    def __init__(self, *args):
        if len(args) == 1:
            self.set(args[0]);
        elif len(args) > 1:
            self.set(args);
        else:
            self.set([0, 0, 0]);

    def set(self, value, fmt=None):
        if isinstance(value, PluginColor):
            hsv = [ value['hue'], value['sat'], value['val'] ];
        else:
            # try to infer format if it is not specified
            if not fmt:
                if len(value) >= 6:
                    fmt = 'hex';
                else:
                    fmt = 'hsv';

            if fmt == 'hex':
                hsv = colorsys.rgb_to_hsv(*hex_to_rgb(value));

            elif fmt == 'rgb':
                hsv = colorsys.rgb_to_hsv(*value);

            elif fmt == 'hsv':
                hsv = value;

        self['hue'] = hsv[0];
        self['sat'] = hsv[1];
        self['val'] = hsv[2];

    def update(self, other):
        # TODO: support partial reconfiguration (e.g. just value in HSV triplet)
        self.set(other);

    def copy(self):
        cp = PluginColor();
        cp.update(self);
        return cp;

    def as_hsv(self):
        return (self['hue'], self['sat'], self['val']);

    def as_rgb(self):
        return list(colorsys.hsv_to_rgb(*self.as_hsv()));

    def as_rgb_int(self, max_value):
        return [ int(max_value * i) for i in self.as_rgb() ];

    def as_dhsv(self):
        dh = self['hue'] * 360;
        return [ dh, self['sat'], self['val'] ];

    def as_hex(self):
        return rgb_to_hex(self.as_rgb());

    def __repr__(self):
        return "%r (#%s)" % (self.as_hsv(), self.as_hex());
