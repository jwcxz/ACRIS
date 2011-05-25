import time

import backend.plugin
import backend.utils

import controllers.wallsconce

import pyaudio, audioop, math

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

        self.left = controllers.wallsconce.WallSconce(network, 1);
        self.addresses.append(self.left.address);

        self.right = controllers.wallsconce.WallSconce(network, 0);
        self.addresses.append(self.right.address);

        self.chunk = 512;
        self.pa = pyaudio.PyAudio();
        self.stream = self.pa.open(format = pyaudio.paInt16,
                                   channels = 1,
                                   rate = 44100,
                                   input = True,
                                   input_device_index=0,
                                   frames_per_buffer = self.chunk);

    def run(self):
        backend.plugin.Plugin.run(self);

        sat = 1.0;
        hues = [ 0, 45, 90 ]; # LED hues
        vals = [ 0, 0, 0 ];
        v = [0, 0, 0];

        if len(self.args) >= 1: maxv = int(self.args[0]);
        else:                   maxv = 90;

        if len(self.args) >= 2: alpha = float(self.args[1]);
        else:                   alpha = .5;

        while self.enabled:
            try:
                data = self.stream.read(self.chunk);
                #sz = audioop.max(data, 2);    # value between 0 and 32768
                sz = audioop.rms(data, 2);    # value between 0 and 32768

                # process value
                relsz = (float(sz) / 4096.0) ** 2;
                #relsz = float(sz) / 4000.;
                v[0] = min(1.0, max(0.0, relsz-0.55)); # least sensitive
                v[1] = min(1.0, max(0.0, relsz-0.40));
                v[2] = min(1.0, max(0.0, relsz-0.20));      # most sensitive

                vals = [ (1-alpha)*vals[i] + (alpha)*v[i] for i in range(3) ];

                rgb = [ [ int(maxv * i) for i in backend.utils.hsv2rgb(hues[j], sat, vals[j]) ] for j in range(3) ];
                self.left.each(rgb[0], rgb[1], rgb[2]);
                self.right.each(rgb[0], rgb[1], rgb[2]);

                #time.sleep(0.001);

            except IOError:
                # frame error... safe to ignore
                pass

    def stop(self):
        backend.plugin.Plugin.stop(self);
        time.sleep(.25);
        self.stream.close();
        self.pa.terminate();
