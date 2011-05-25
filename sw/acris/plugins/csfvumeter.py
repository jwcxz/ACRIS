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

        self.hkns = [ controllers.hknboard.HKNBoard(network, 0x40 + i) for i in range(4) ];
        self.addresses.extend([_.address for _ in self.hkns]);

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
        hues = [ 90, 60, 40, 20, 0 ]; # LED hues
        vals = [ 0, 0, 0, 0, 0 ];
        v = [0, 0, 0, 0, 0];

        if len(self.args) >= 1: maxv = int(self.args[0]);
        else:                   maxv = 255;

        if len(self.args) >= 2: alpha = float(self.args[1]);
        else:                   alpha = .5;

        if len(self.args) >= 2: timestep = float(self.args[1]);
        else:                   timestep = .1;

        lights = [];

        for col in range(4):
            _ = [];
            for row in range(5):
                _.append([0,0,0]);
            lights.append(_);

        while self.enabled:
            try:
                data = self.stream.read(self.chunk);
                #sz = audioop.max(data, 2);    # value between 0 and 32768
                sz = audioop.rms(data, 2);    # value between 0 and 32768

                # process value
                relsz = (float(sz) / 1024.0) ** 2;
                #relsz = float(sz) / 4000.;
                v[4] = min(1.0, max(0.0, relsz-0.55)); # least sensitive
                v[3] = min(1.0, max(0.0, relsz-0.50));
                v[2] = min(1.0, max(0.0, relsz-0.40));
                v[1] = min(1.0, max(0.0, relsz-0.30));
                v[0] = min(1.0, max(0.0, relsz-0.20)); # most sensitive

                vals = [ (1-alpha)*vals[i] + (alpha)*v[i] for i in range(len(v)) ];

                for col in range(len(lights[0])):
                    rgb = [ max(0, min(255, int(maxv*i))) for i in backend.utils.hsv2rgb(hues[col], 1.0, vals[col]) ];

                    lights[0][col] = rgb;
                    lights[1][col] = rgb;
                    lights[2][col] = rgb;
                    lights[3][col] = rgb;

                for i in range(4):
                    self.hkns[i].each(lights[i]);

                self.left.all(lights[0][0]);
                self.right.all(lights[3][4]);

                time.sleep(timestep);

            except IOError:
                # frame error... safe to ignore
                pass

    def stop(self):
        backend.plugin.Plugin.stop(self);
        time.sleep(.25);
        self.stream.close();
        self.pa.terminate();
