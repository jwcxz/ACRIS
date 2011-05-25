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

        if len(self.args) >= 1: maxv = int(self.args[0]);
        else:                   maxv = 255;

        if len(self.args) >= 2: timestep = float(self.args[1]);
        else:                   timestep = .01;

        if len(self.args) >= 3: burstdly = float(self.args[2]);
        else:                   burstdly = .07;

        if len(self.args) >= 4: fade = float(self.args[3]);
        else:                   fade = .7;


        lights = [];
        comp = [];
        for col in range(4):
            _ = [];
            for row in range(5):
                _.append([0,0,0]);
            lights.append(_);
            comp.append([0,0,0,0,0]);

        bursts = [];
        bdelq = [];
        bcount = 0;

        while self.enabled:
            if bcount == 0:
                b = {};
                # choose location for burst center
                b['x'] = random.randint(0, len(lights)-1);
                b['y'] = random.randint(0, len(lights[0])-1);

                # choose random color
                b['hue'] = random.randint(0, 360);

                # choose radius
                b['r'] = random.randint(1,2);

                # transition speed
                b['ts'] = random.randint(5,20);

                b['frame'] = 0;

                bursts.append(b);

            bcount = (bcount+1)%int(burstdly/timestep);

            # assemble bursts
            for bursts_idx in range(len(bursts)):
                b = bursts[bursts_idx];

                if b['frame'] < b['ts']:
                    # burst
                    _ = backend.utils.hsv2rgb(b['hue'], 1.0, float(b['frame'])/float(b['ts']));
                    __ = [ int(maxv*___) for ___ in _ ];
                    for ___ in range(len(__)):
                        lights[b['x']][b['y']][___] += __[___];
                    comp[b['x']][b['y']] += 1;

                else:
                    if b['frame'] < 2*b['ts']:
                        # explosion
                        _ = backend.utils.hsv2rgb(b['hue'], 1.0, float(b['frame']-b['ts'])/float(b['ts']));
                        __ = [ int(maxv*___) for ___ in _ ]; # lololololol

                    else:
                        # fade
                        _ = backend.utils.hsv2rgb(b['hue'], 1.0, float(2*b['ts'] - fade*b['frame'])/float(b['ts']));
                        __ = [ int(max(0,min(255,maxv*___))) for ___ in _ ]; # lololololol
                        if __ == [0,0,0]:
                            bdelq.append(bursts_idx);

                    for xoff in range(-b['r']+1,b['r']):
                        if b['x']+xoff < 0 or b['x']+xoff >= len(lights):
                            break;
                        for yoff in range(-b['r']+1,b['r']):
                            if b['y']+yoff < 0 or b['y']+yoff >= len(lights[0]):
                                break;

                            for ___ in range(3):
                                lights[b['x']+xoff][b['y']+yoff][___] += __[___];
                            comp[b['x']+xoff][b['y']+yoff] += 1;

                b['frame'] += 1;

            # delete stale bursts
            newbursts = [];
            for idx in range(len(bursts)):
                if idx not in bdelq:
                    newbursts.append(bursts[idx]);
            bursts = newbursts;
            bdelq = [];

            # adjust each pixel according to the average
            for x in range(len(lights)):
                for y in range(len(lights[0])):
                    if comp[x][y] != 0:
                        for c in range(3):
                            lights[x][y][c] = int(max(0,min(255,lights[x][y][c]/float(comp[x][y]))));
                        comp[x][y] = 0;

            #print("")
            #print(lights[0]);
            #print(lights[1]);
            #print(lights[2]);
            #print(lights[3]);
            #print(bursts)
            #print("")
            # update all lights
            for i in range(4):
                self.hkns[i].each(lights[i]);

            self.left.all(lights[0][0]);
            self.right.all(lights[3][4]);

            # clear lights array
            for row in range(len(lights)):
                for col in range(len(lights[0])):
                    lights[row][col] = [0,0,0];

            # wait a bit before producing next frame
            time.sleep(timestep);
