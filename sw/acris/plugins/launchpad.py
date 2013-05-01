import argparse, math, time, zmq

import backend.plugin
import backend.utils as utils

import controllers.five

CMDS = {
        'add_pulse': 1,
        'pulse_decay': 2,
        'pulse_speed': 3,
        'pulse_shape': 4,
        'strobe_on': 5,
        'strobe_off': 6,
        'sine_on': 7,
        'sine_off': 8,
        };

class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

        # set up instruments
        inst_addrs = [ 0x70, 0x71, 0x72, 0x73, 0x74 ];

        self.devs = [];
        
        for ia in inst_addrs:
            self.devs.append(controllers.five.FiveRGBLeft(network, ia));
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

        self.args = p.parse_args(' '.join(self.args));


        # starting action and parameters
        self.action = self.action_pulse

        # common params
        self.params = {
                'decay': 0.5,
                'speed': 0.25,
                'shape': 1
                }

        # strobe params
        self.strobe_count = [0, 0];

        # sine params
        self.sine_count = 0;

    def run(self):
        backend.plugin.Plugin.run(self);

        self.pulses = [];

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
                print data
                # unpack data
                command, params = data;

                if command == CMDS['add_pulse']:
                    line = params[0];
                    hue = params[1] * 360./8.;
                    self.add_pulse(line, hue);

                elif command == CMDS['pulse_decay']:
                    self.params['decay'] = 1/float(params[0]);

                elif command == CMDS['pulse_speed']:
                    self.params['speed'] = (params[0]+1)/8.;

                elif command == CMDS['pulse_shape']:
                    self.params['shape'] = 1/float(params[0]);

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

    def action_pulse(self):
        # update all pulse transmission lines
        self.pulse_step();

        # combine lines to produce RGB array
        output = self.combine_pulses();

        print output

        # drive display
        for o, d in zip(output, self.devs):
            #d.each(o[0] + o[1] + o[2] + o[3] + o[4]);
            d.each(o);

    def action_strobe(self):
        # use speed slider to set on timesteps and shape slider to set off timesteps
        if not self.strobe[0]:
            offmax = int(8*self.params['shape']);

            # in off mdoe
            self.strobe_count[1] += 1;
            if self.strobe_count[1] == offmax:
                self.strobe_count = [1, 0];

            for d in self.devs:
                self.devs.all([0]*3);
        else:
            # in on mode
            onmax = int(8*self.params['speed']);

            self.strobe_count[1] += 1;
            if self.strobe_count[1] == onmax:
                self.strobe_count = [0, 0];

            for d in self.devs:
                self.devs.all([self.args.maxval]*3);

    def action_sine(self):
        # use the speed slider to adjust frequency of sine wave
        pass



    def add_pulse(self, line, hue):
        self.pulses.append(Pulse(line, hue, self.params['decay'], self.params['speed'], self.params['shape']));

    def pulse_step(self):
        for pulse in self.pulses:
            pulse.step();

    def combine_pulses(self):
        output = [];
        for i in xrange(5):
            output.append([]);
            for j in xrange(5):
                output[-1].append([0,0,0]);

        for p in self.pulses:
            line = p.line;
            rgb = p.rgb(self.args.maxval);

            for i in xrange(5):
                output[line][i] = [o+r for o,r in zip(output[line][i], rgb[i])];

        return output;



class Pulse:
    def __init__(self, line, hue, decay, speed, shape, index=0, bound=5):
        self.line = line;
        self.hue = hue;
        self.decay = decay;
        self.speed = speed;
        self.shape = shape;
        self.index = index;
        self.bound = 5;

        self.vals = [0]*self.bound;

        self.newval = 1.0;

    def step(self):
        new = self.reflect();

        # update vals
        for i in xrange(self.bound):
            self.vals[i] = (1 - self.shape) * self.vals[i] + \
                           (self.shape) * new[i];

    def rgb(self, amp):
        out = [];
        for val in self.vals:
            rgb = [int(round(amp*c)) for c in
                        utils.hsv2rgb(self.hue, 1.0, val)];
            out.append(rgb);

        return out;

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
