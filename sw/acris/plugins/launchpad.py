import argparse, math, time, zmq

import backend.plugin
import backend.utils as utils

import controllers.five

import numpy as np;

CMDS = {
        'clock_pulse' : 0,
        'action_on'   : 1,
        'action_off'  : 2,
        'set'         : 3,
        'set_action'  : 4,
        };


BLANK_OUTPUT = [];
for i in range(5):
    BLANK_OUTPUT.append([]);
    for j in range(5):
        BLANK_OUTPUT[-1].append([0,0,0]);


class Plugin(backend.plugin.Plugin):
    def __init__(self, network, args):
        backend.plugin.Plugin.__init__(self, network, args);

        # set up instruments
        inst_addrs = [ 0x72, 0x73, 0x74, 0x70, 0x71 ];

        self.devs = [];

        for ia in inst_addrs:
            self.devs.append(controllers.five.FiveRGBLeft(network, ia));
            self.devs[-1].set_mode('hd');
            self.addresses.append(ia);

        # set up zmq context
        self.zmq_ctx = zmq.Context();
        self.zmq_pull = self.zmq_ctx.socket(zmq.PULL);

        # generate options
        p = argparse.ArgumentParser();

        p.add_argument('-a', '--address', dest='bindaddr', type=str,
                default='tcp://*:44444', help='zmq bind address');

        p.add_argument('-v', '--max-val', dest='maxval', type=int,
                default=128, help='maximum value');

        p.add_argument('-t', '--timestep', dest='timestep', type=float,
                default=0.01, help='timestep (or 0 for midi sync)');

        self.args = p.parse_args(args);

        self.new_action_type = Pulse;
        self.params = [4,4,4];

        # line setup
        self.lines = [];
        for i in range(5):
            new = [ [], [], [], [],
                    [], [], [], [] ];

            self.lines.append(new);


    def run(self):
        backend.plugin.Plugin.run(self);

        self.zmq_pull.bind(self.args.bindaddr);

        while self.enabled:
            # important note: I don't have time to actually properly use
            # threads right now.  This is nothing short of embarrassing.

            if self.args.timestep == 0:
                data = self.zmq_pull.recv_pyobj();
                self.process_indata(data);
            else:
                try:
                    data = self.zmq_pull.recv_pyobj(flags=zmq.NOBLOCK);
                except zmq.ZMQError:
                    data = None;

                if data != None:
                    self.process_indata(data);

                self.action();
                time.sleep(self.args.timestep);


    def process_indata(self, data):
        # unpack data
        command, params = data;

        if command == CMDS['clock_pulse']:
            self.action();

        elif command == CMDS['action_on']:
            line, idx = params;

            new_action = self.new_action_type();
            new_action.set_params([idx] + self.params);
            self.lines[line][idx].append(new_action);

        elif command == CMDS['action_off']:
            line, idx = params;
            for action in self.lines[line][idx]:
                action.switch_off();

        elif command == CMDS['set']:
            idx, val = params;
            if idx < 3:
                self.params[idx] = val;

        elif command == CMDS['set_action']:
            val = params[0];
            if val == 'pulse':
                self.new_action_type = Pulse;
            elif val == 'sine':
                self.new_action_type = Sine;

        else:
            print("unrecognized command");


    def action(self):
        # step all visualizations
        for line in range(5):
            for index in range(8):
                for action in self.lines[line][index]:
                    action.step();
                    if action.done:
                        self.lines[line][index].remove(action);


        # combine lines to produce RGB array
        output = self.combine_pulses();

        # drive display
        for o, d in zip(output, self.devs):
            d.each(o);


    def combine_pulses(self):
        output = BLANK_OUTPUT[:];

        for line in range(5):
            for index in range(8):
                for action in self.lines[line][index]:
                    rgb = action.rgb();

                    output[line] = [
                            [ prev + new for prev, new
                                in zip(output[line][led], rgb[led]) ]
                                    for led in range(5) ];

            # after all elements of the line have been computed, convert to
            # integer command form
            num_pulses = sum([len(self.lines[line][index]) for index in range(8)]);
            if num_pulses:
                multiplier = self.args.maxval/float(num_pulses);
                for led in range(5):
                    for comp in range(3):
                        output[line][led][comp] = int(round(multiplier * output[line][led][comp]));

        return output;


    def stop(self):
        backend.plugin.Plugin.stop(self);
        self.zmq_ctx.destroy();



class LPVis:
    def __init__(self, start_params=[4,4,4,4], start_index=0., bound=5):
        self.p = {};

        # visualization finished?
        self.done = False;

        # on_state = 1 when button is pushed down, 0 when up
        self.on_state = True;

        self.index = start_index;
        self.bound = bound;

        self.set_params(start_params);


    def set_params(arr):
        pass;

    def switch_on(self):
        self.on_state = True;
    def switch_off(self):
        self.on_state = False;

    def step(self):
        pass;

    def rgb(self):
        pass


class Pulse(LPVis):
    def __init__(self, params=[4,4,4,4]):
        LPVis.__init__(self, params);

        if self.p['speed'] > self.bound:
            self.vals = [1]*self.bound;
            self.index = self.bound
        else:
            self.vals = [0]*self.bound;

    def set_params(self, arr):
        in_hue, in_decay, in_speed, in_shape = arr;

        if in_hue   != None: self.p['hue']   = in_hue * 360/9.;
        if in_decay != None: self.p['decay'] = (in_decay+1) * 1/8.;
        if in_speed != None: self.p['speed'] = (in_speed+1) * 5/8.;
        if in_shape != None: self.p['shape'] = (in_shape+1) * 1/8.;

    def step(self):
        if self.on_state:
            if self.index < self.bound:
                # building up
                iidx = int(self.index);

                for i in range(iidx):
                    self.vals[i] = 1.0;

                fidx = self.index - iidx;
                self.vals[iidx] = fidx;
                self.index += self.p['speed'];
            else:
                self.vals = [1.0]*self.bound;
                self.index = self.bound;
        else:
            # decaying
            self.vals = [ (1 - self.p['decay'])*val for val in self.vals ];
            if sum(self.vals) < .001:
                self.done = True;

    def rgb(self):
        out = [];
        for val in self.vals:
            rgb = utils.hsv2rgb(self.p['hue'], 1.0, val);
            out.append(rgb);

        return out;

class Sine(LPVis):
    def __init__(self, params=[4,4,4,4]):
        LPVis.__init__(self, params);

        self.vals = [0]*self.bound;

    def set_params(self, arr):
        in_hue, in_decay, in_speed, in_offs = arr;

        if in_hue   != None: self.p['hue']   = in_hue * 360/9.;
        if in_decay != None: self.p['decay'] = (in_decay+1) * 1/8.;
        if in_speed != None: self.p['speed'] = (in_speed+1) * 1/8. * 2*math.pi*1/5.;
        if in_offs  != None: self.p['offs']  = in_offs/7.;

        self.offsets = [ o * self.p['offs'] * math.pi/4. for o in range(5) ]

    def step(self):
        if self.on_state:
            freq = self.p['speed'];
            newvals = [abs(math.sin((self.index)*freq + o) + 1)/2. for o in self.offsets];
            self.vals = newvals;
            self.index += 1;
        else:
            self.index = 0;
            self.vals = [ (1 - self.p['decay'])*val for val in self.vals ];
            if sum(self.vals) < .001:
                self.done = True;

    def rgb(self):
        out = [];
        for val in self.vals:
            rgb = utils.hsv2rgb(self.p['hue'], 1.0, val);
            out.append(rgb);

        return out;
