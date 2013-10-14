#!/bin/sh

cd `dirname $0`

echo "Press enter to start programming..."
./bootloader.py -P /dev/ttyUSB0 -n -p $1 -r
