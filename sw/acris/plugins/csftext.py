import time

import backend.plugin
import backend.utils

import controllers.wallsconce
import controllers.hknboard

import random

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

        self.left = controllers.wallsconce.WallSconce(network, 1);
        self.addresses.append(self.left.address);

        self.right = controllers.wallsconce.WallSconce(network, 0);
        self.addresses.append(self.right.address);

        self.hkns = [ controllers.hknboard.HKNBoard(network, 0x40 + i) for i in range(4) ];
        self.addresses.extend([_.address for _ in self.hkns]);

    def run(self):
        backend.plugin.Plugin.run(self);

        if len(self.args) >= 1: text = self.args[0].upper();
        else:                   text = "ACRIS";

        if len(self.args) >= 2: maxv = int(self.args[1]);
        else:                   maxv = 255;

        if len(self.args) >= 3: timestep = float(self.args[3]);
        else:                   timestep = .01;

        if len(self.args) >= 4: decay = float(self.args[4]);
        else:                   decay = .7;

        if len(self.args) >= 4: huestep = int(self.args[4]);
        else:                   huestep = 1;

        if len(self.args) >= 5: framestep = int(self.args[5]);
        else:                   framestep = 5;

        lights = [];
        vals = [];
        for col in range(4):
            _ = [];
            for row in range(5):
                _.append([0,0,0]);
            lights.append(_);
            vals.append([0,0,0,0,0]);

        hue = 0;
        frame = 0;

        txtmtx = [ [], [], [], [], [] ];
        for c in text:
            o = ord(c)
            t = [];
            if o in range(ord('0'), ord('9')):
                # got a number
                t = chars[o-ord('0')+26];
            elif o in range(ord('A'), ord('Z')):
                # got a letter
                t = chars[o-ord('A')];
            elif c == '.':
                t = chars[-1];

            if t != []:
                for row in range(len(txtmtx)):
                    txtmtx[row].extend(t[row]);
                    txtmtx[row].append(0);


        while self.enabled:
            for row in range(len(lights)):
                for col in range(len(lights[0])):
                    pxl = txtmtx[col][(row+int(frame/framestep))%len(txtmtx[0])];
                    if pxl:
                        vals[row][col] = float(pxl);
                    else:
                        vals[row][col] *= (1.-decay);

                    rgb = backend.utils.hsv2rgb(hue, 1.0, vals[row][col]);

                    hue = (hue+huestep)%360;

                    lights[row][col] = [ int(max(0,min(255,maxv*_))) for _ in rgb ];

            frame = (frame+1)%(len(txtmtx[0])*framestep);

            #print("")
            #print(lights[0]);
            #print(lights[1]);
            #print(lights[2]);
            #print(lights[3]);
            #print("")
            # update all lights
            for i in range(4):
                self.hkns[i].each(lights[i]);

            self.left.all(lights[0][0]);
            self.right.all(lights[3][4]);

            # wait a bit before producing next frame
            time.sleep(timestep);

rawchars = [
    [ [0,1,1,0],
      [1,0,0,1],
      [1,1,1,1],
      [1,0,0,1],
      [1,0,0,1] ],

    [ [1,1,1,0],
      [1,0,0,1],
      [1,1,1,0],
      [1,0,0,1],
      [1,1,1,0] ],

    [ [0,1,1,1],
      [1,0,0,0],
      [1,0,0,0],
      [1,0,0,0],
      [0,1,1,1] ],

    [ [1,1,1,0],
      [1,0,0,1],
      [1,0,0,1],
      [1,0,0,1],
      [1,1,1,0] ],

    [ [1,1,1,1],
      [1,0,0,0],
      [1,1,1,1],
      [1,0,0,0],
      [1,1,1,1] ],

    [ [1,1,1,1],
      [1,0,0,0],
      [1,1,1,1],
      [1,0,0,0],
      [1,0,0,0] ],

    [ [0,1,1,1],
      [1,0,0,0],
      [1,0,1,1],
      [1,0,0,1],
      [0,1,1,0] ],

    [ [1,0,0,1],
      [1,0,0,1],
      [1,1,1,1],
      [1,0,0,1],
      [1,0,0,1] ],

    [ [1,1,1,1],
      [0,1,1,0],
      [0,1,1,0],
      [0,1,1,0],
      [1,1,1,1] ],

    [ [1,1,1,1],
      [0,0,1,1],
      [0,0,1,1],
      [1,0,1,1],
      [1,1,1,0] ],

    [ [1,0,0,1],
      [1,0,1,0],
      [1,1,0,0],
      [1,0,1,0],
      [1,0,0,1] ],

    [ [1,0,0,0],
      [1,0,0,0],
      [1,0,0,0],
      [1,0,0,0],
      [1,1,1,1] ],

    [ [1,0,0,1],
      [1,1,1,1],
      [1,0,0,1],
      [1,0,0,1],
      [1,0,0,1] ],

    [ [1,0,0,1],
      [1,1,0,1],
      [1,1,1,1],
      [1,0,1,1],
      [1,0,0,1] ],

    [ [0,1,1,0],
      [1,0,0,1],
      [1,0,0,1],
      [1,0,0,1],
      [0,1,1,0] ],

    [ [1,1,1,0],
      [1,0,0,1],
      [1,1,1,0],
      [1,0,0,0],
      [1,0,0,0] ],

    [ [1,1,1,0],
      [1,0,0,1],
      [1,0,0,1],
      [1,0,1,0],
      [0,1,0,1] ],

    [ [1,1,1,0],
      [1,0,0,1],
      [1,1,1,0],
      [1,0,1,0],
      [1,0,0,1] ],

    [ [0,1,1,1],
      [1,0,0,0],
      [0,1,1,0],
      [0,0,0,1],
      [1,1,1,0] ],

    [ [1,1,1,1],
      [0,1,1,0],
      [0,1,1,0],
      [0,1,1,0],
      [0,1,1,0] ],

    [ [1,0,0,1],
      [1,0,0,1],
      [1,0,0,1],
      [1,0,0,1],
      [1,1,1,1] ],

    [ [1,0,0,1],
      [1,0,0,1],
      [1,0,0,1],
      [1,0,0,1],
      [0,1,1,0] ],

    [ [1,0,0,1],
      [1,0,0,1],
      [1,1,0,1],
      [1,1,1,1],
      [0,1,1,0] ],

    [ [1,0,0,1],
      [1,1,1,1],
      [1,1,1,1],
      [1,1,1,1],
      [1,0,0,1] ],

    [ [1,0,0,1],
      [1,0,0,1],
      [0,1,1,0],
      [0,1,1,0],
      [0,1,1,0] ],

    [ [1,1,1,1],
      [0,0,1,1],
      [0,1,1,0],
      [1,1,0,0],
      [1,1,1,1] ],

    [ [0,1,1,0],
      [1,0,1,1],
      [1,1,0,1],
      [1,1,0,1],
      [0,1,1,0] ],

    [ [0,1,1,0],
      [1,1,1,0],
      [0,1,1,0],
      [0,1,1,0],
      [1,1,1,1] ],

    [ [1,1,1,0],
      [0,0,1,1],
      [0,1,1,0],
      [1,1,0,0],
      [1,1,1,1] ],

    [ [1,1,1,0],
      [0,0,1,1],
      [0,1,1,0],
      [0,0,1,1],
      [1,1,1,0] ],

    [ [1,0,0,1],
      [1,0,0,1],
      [0,1,1,1],
      [0,0,0,1],
      [0,0,0,1] ],

    [ [1,1,1,1],
      [1,0,0,0],
      [1,1,1,0],
      [0,0,0,1],
      [1,1,1,0] ],

    [ [0,1,1,1],
      [1,0,0,0],
      [1,1,1,0],
      [1,0,0,1],
      [0,1,1,0] ],

    [ [1,1,1,1],
      [0,0,1,1],
      [0,1,1,0],
      [1,1,0,0],
      [1,1,0,0] ],

    [ [0,1,1,0],
      [1,0,0,1],
      [0,1,1,0],
      [1,0,0,1],
      [0,1,1,0] ],

    [ [0,1,1,0],
      [1,0,0,1],
      [0,1,1,1],
      [0,0,0,1],
      [0,1,1,0] ],

    [ [0,0,0,0],
      [0,0,0,0],
      [0,0,0,0],
      [0,0,0,0],
      [0,0,0,0] ] ];

# let's correct for my ineptitude!
chars = [];
for c in rawchars:
    chars.append([]);
    chars[-1] = [
        [ c[4][0], c[4][1], c[4][2], c[4][3] ],
        [ c[3][0], c[3][1], c[3][2], c[3][3] ],
        [ c[2][0], c[2][1], c[2][2], c[2][3] ],
        [ c[1][0], c[1][1], c[1][2], c[1][3] ],
        [ c[0][0], c[0][1], c[0][2], c[0][3] ] ]
