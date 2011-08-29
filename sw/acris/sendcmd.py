#!/usr/bin/env python2

import sys
import acris.network

# TODO: add arguments for port, baud
nwk = acris.network.Network();
print ":: opened", nwk.cxn.portstr;

data = [_.rstrip('\r\n') for _ in sys.stdin.readlines()];
data = data[0].split(' ');
print ":: read data from stdin"
print data

nwk.cmd(data, sendsync=False);

print "done"
sys.exit(0);
