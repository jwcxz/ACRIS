#!/bin/sh

cd `dirname $0`

echo "Press ^C to stop"
./bootloader.py -P /dev/ttyUSB0 -n

echo "Programming..."
./bootloader.py -P /dev/ttyUSB0 -p $@
