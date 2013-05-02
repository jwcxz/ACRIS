import argparse, math, time, zmq

import backend.plugin
import backend.utils as utils

import controllers.five

import numpy as np;

CMDS = {
        'action_on'  : 1,
        'action_off' : 2,
        'set'        : 3,
        'set_action' : 4,
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

        self.new_action_type = Pulse;
        self.params = [4,4,4];

        # line setup
        self.lines = [];
        for i in xrange(5):
            new = [ [], [], [], [],
                    [], [], [], [] ];

            self.lines.append(new);


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

                if command == CMDS['action_on']:
                    line, idx = params;

                    new_action = self.new_action_type();
                    new_action.set_params([index] + self.params);
                    self.lines[line][idx].append(new_action);

                elif command == CMDS['action_off']:
                    line, idx = params;
                    for action in self.pulses[line][idx]:
                        action.switch_off();

                elif command == CMDS['set']:
                    index, val = params;
                    if index < 3:
                        self.params[index] = val;

                elif command == CMDS['set_action']:
                    val = params[0];
                    if val == 'pulse':
                        self.new_action_type = Pulse;
                    elif val == 'sine':
                        self.new_action_type = Sine;

                else:
                    print "unrecognized command";


            self.action();

            time.sleep(self.args.timestep);


    def action(self):
        # step all visualizations
        for line in xrange(5):
            for index in xrange(8):
                for action in self.lines[line][index]:
                    action.step();
                    if action.done:
                        self.lines[line][index].remove(action);


        # combine lines to produce RGB array
        output = self.combine_pulses();

        #print output[0]

        # drive display
        for o, d in zip(output, self.devs):
            #d.each(o[0] + o[1] + o[2] + o[3] + o[4]);
            d.each(o);


    def combine_pulses(self):
        output = BLANK_OUTPUT[:];

        for line in xrange(5):
            for index in xrange(8):
                for action in self.lines[line][index]:
                    rgb = action.rgb();

                    output[line] = [
                            [ prev + new for prev, new 
                                in zip(output[line][led], rgb[led]) ]
                                    for led in xrange(5) ];

            # after all elements of the line have been computed, convert to
            # integer command form
            num_pulses = sum([len(self.lines[line][index]) for index in xrange(8)]);
            if num_pulses:
                multiplier = self.args.maxval/float(num_pulses);
                for led in xrange(5):
                    for comp in xrange(3):
                        output[line][led][comp] = int(round(multiplier * output[line][led][comp]));

        return output;


    def stop(self):
        backend.plugin.Plugin.stop(self);
        self.zmq_ctx.destroy();



    """
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



    def pulse_step(self):
        for line in self.pulses:
            for index in line.keys():
                line[index].step();

                if line[index].done:
                    line.pop(index, None);
    """




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
    def __init__(self, params):
        LPVis.__init__(self, params);

        if self.p['speed'] > self.bound:
            self.vals = [1]*self.bound;
            self.index = self.bound
        else:
            self.vals = [0]*self.bound;

    def set_params(arr):
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

                for i in xrange(iidx):
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

class Sine:
    def __init__(self, params):
        LPVis.__init__(self, params);

        self.vals = [0]*self.bound;

    def set_params(arr):
        in_hue, in_decay, in_speed, in_offs = arr;

        if in_hue   != None: self.p['hue']   = in_hue * 360/9.;
        if in_decay != None: self.p['decay'] = (in_decay+1) * 1/8.;
        if in_speed != None: self.p['speed'] = (in_speed+1) * 5/8.;
        if in_offs  != None: self.p['offs']  = in_offs * 1/8.;
    
    def step(self):
       pass
