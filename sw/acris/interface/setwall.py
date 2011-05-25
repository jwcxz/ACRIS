#!/usr/bin/env python2

import os, socket, sys

if len(sys.argv) < 2:
    # choose a color
    x = os.popen("kcolorchooser --print --color '#700000'");
    color = x.read();
    x.close();

# convert to integers
color = color.rstrip();
color = color.strip("#");

rgb = str(int(color[0:2], 16)) + " " + str(int(color[2:4], 16)) + " " + str(int(color[4:6], 16));

print(rgb);

os.system("echo plugin wallset %s | nc localhost 55555" % rgb);
