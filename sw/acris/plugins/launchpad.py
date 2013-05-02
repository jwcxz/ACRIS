import argparse, math, time, zmq

import backend.plugin
import backend.utils as utils

import controllers.five

import numpy as np;

CMDS = {
        'pulse_on'   : 1,
        'pulse_off'  : 2,
        'set_decay'  : 3,
        'set_speed'  : 4,
        'set_shape'  : 5,
        'strobe_on'  : 6,
        'strobe_off' : 7,
        'sine_on'    : 8,
        'sine_off'   : 9,
        };


BLANK_OUTPUT = [];
for i in xrange(5):
    BLANK_OUTPUT.append([]);
    for j in xrange(5):
        BLANK_OUTPUT[-1].append([0,0,0]);


class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

        # set up instruments
        inst_addrs = [ 0x70, 0x71, 0x72, 0x73, 0x74 ];

        self.devs = [];
        
        for ia in inst_addrs:
            self.devs.append(controllers.five.FiveRGBLeft(network, ia));
            self.devs[-1].set_mode('hd');
            self.addresses.append(ia);

        # set up zmq context
        self.zmq_ctx = zmq.Context();
        self.zmq_sub = self.zmq_ctx.socket(zmq.SUB);

        # generate options
        p = argparse.ArgumentParser();
        
        p.add_argument('-s', '--source', dest='source', type=str,
                default='tcp://127.0.0.1:44444', help='zmq source');
        
        p.add_argument('-v', '--max-val', dest='maxval', type=int,
                default=128, help='maximum value');
        
        p.add_argument('-t', '--timestep', dest='timestep', type=float,
                default=0.01, help='timestep');

        self.args = p.parse_args(args);


        # starting action and parameters
        self.action = self.action_pulse

        # common params
        self.params = {
                'decay': 0.5,
                'speed': 0.25,
                'shape': 1
                }

        # pulse params
        self.pulses = [{}, {}, {}, {}, {}];

        # strobe params
        self.strobe_count = [0, 0];

        # sine params
        self.sine_count = 0;

    def run(self):
        backend.plugin.Plugin.run(self);

        self.zmq_sub.connect(self.args.source);
        self.zmq_sub.setsockopt(zmq.SUBSCRIBE, "");

        while self.enabled:
            # important note: I don't have time to actually properly use
            # threads right now.  This is nothing short of embarrassing.
            try:
                data = self.zmq_sub.recv_pyobj(flags=zmq.NOBLOCK);
            except zmq.ZMQError:
                data = None;

            if data != None:
                # unpack data
                command, params = data;

                if command == CMDS['pulse_on']:
                    line = params[0];
                    hue = params[1] * 360./8.;
                    self.pulse_on(line, params[1], hue);

                elif command == CMDS['pulse_off']:
                    line, idx = params;
                    self.pulse_off(line, idx);

                elif command == CMDS['set_decay']:
                    self.params['decay'] = float(params[0]+1)/8.;

                elif command == CMDS['set_speed']:
                    self.params['speed'] = float(params[0]+1) * 5/8.;

                elif command == CMDS['set_shape']:
                    self.params['shape'] = 1/float(params[0]+1);

                elif command == CMDS['strobe_on']:
                    self.action = self.action_strobe;
                elif command == CMDS['sine_on']:
                    self.action = self.action_sine;
                elif command == CMDS['strobe_off'] or command == CMDS['sine_off']:
                    self.action = self.action_pulse;

                else:
                    print "unrecognized command";


            self.action();

            time.sleep(self.args.timestep);


    def stop(self):
        backend.plugin.Plugin.stop(self);
        self.zmq_ctx.destroy();


    def action_pulse(self):
        # update all pulse transmission lines
        self.pulse_step();

        # combine lines to produce RGB array
        output = self.combine_pulses();

        #print output[0]

        # drive display
        for o, d in zip(output, self.devs):
            #d.each(o[0] + o[1] + o[2] + o[3] + o[4]);
            d.each(o);

    def action_strobe(self):
        # use speed slider to set on timesteps and shape slider to set off timesteps
        if not self.strobe_count[0]:
            #offmax = int(8*self.params['shape']);
            offmax = 1

            # in off mdoe
            self.strobe_count[1] += 1;
            if self.strobe_count[1] >= offmax:
                self.strobe_count = [1, 0];

            for d in self.devs:
                d.all([0]*3);
        else:
            # in on mode
            #onmax = int(8*self.params['speed']);
            onmax = 1

            self.strobe_count[1] += 1;
            if self.strobe_count[1] >= onmax:
                self.strobe_count = [0, 0];

            for d in self.devs:
                d.all([self.args.maxval]*3);

    def action_sine(self):
        # use the speed slider to adjust frequency of sine wave
        pass



    def pulse_on(self, line, index, hue):
        new_pulse = Pulse(hue, self.params['decay'], self.params['speed']);
        self.pulses[line][index] = new_pulse;

    def pulse_off(self, line, index):
        print "%d: %d" % (line, len(self.pulses[line]));
        self.pulses[line][index].switch_decay();

    def pulse_step(self):
        for line in self.pulses:
            for index in line.keys():
                line[index].step();

                if line[index].done:
                    line.pop(index, None);


    def combine_pulses(self):
        output = BLANK_OUTPUT[:];

        for line in xrange(5):
            for pulse in self.pulses[line].values():
                rgb = pulse.rgb();

                output[line] = [
                        [ prev + new for prev, new 
                            in zip(output[line][led], rgb[led]) ]
                        for led in xrange(5) ];

            # after all elements of the line have been computed, convert to
            # integer command form
            num_pulses = len(self.pulses[line]);
            if num_pulses:
                multiplier = self.args.maxval/float(num_pulses);
                for led in xrange(5):
                    for comp in xrange(3):
                        output[line][led][comp] = int(round(multiplier * output[line][led][comp]));

        return output;



class Pulse:
    def __init__(self, hue, decay, speed, index=0., bound=5):
        self.hue = hue;
        self.decay = decay;
        self.speed = speed;
        self.index = index;
        self.bound = 5;
        self.done = False;
        self.up = True;

        if self.speed > self.bound:
            self.vals = [1]*self.bound;
            self.index = self.bound
        else:
            self.vals = [0]*self.bound;

    def switch_decay(self):
        self.up = False;

    def step(self):
        if self.up:
            if self.index < self.bound:
                # building up
                iidx = int(self.index);

                for i in xrange(iidx):
                    self.vals[i] = 1.0;
                
                fidx = self.index - iidx;
                self.vals[iidx] = fidx;
                self.index += self.speed;
            else:
                self.vals = [1.0]*self.bound;
                self.index = self.bound;
        else:
            # decaying
            self.vals = [ (1 - self.decay)*val for val in self.vals ];
            if sum(self.vals) < .001:
                self.done = True;


    def rgb(self):
        out = [];
        for val in self.vals:
            rgb = utils.hsv2rgb(self.hue, 1.0, val);
            out.append(rgb);

        return out;

    

    """
    # old crazy code... fuck this noise
    def reflect(self):
        iidx = int(self.index);
        fidx = self.index - iidx;

        if self.index == 0 or self.index == self.bound-1:
            cur = iidx;
            nxt = None;
        elif self.speed > 0:
            cur = iidx;
            nxt = iidx + 1;
        elif self.speed < 0:
            cur = iidx + 1;
            nxt = iidx;
            fidx = 1 - fidx;

        new = [0]*self.bound;
        new[cur] = self.newval * (1-fidx);
        if nxt != None:
            new[nxt] = self.newval * fidx;

        self.index += self.speed;

        if self.index >= self.bound-1:
            self.index = self.bound-1;
            self.speed = -1 * self.speed;
            self.newval = (1 - self.decay) * self.newval;
        elif self.index <= 0:
            self.index = 0;
            self.speed = -1 * self.speed;
            self.newval = (1 - self.decay) * self.newval;

        return new;
    """
