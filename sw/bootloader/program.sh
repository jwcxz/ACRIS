#!/bin/sh

cd `dirname $0`

echo "Press ^C to stop"
./bootloader.py -P /dev/ttyUSB1 -n

echo "Programming..."
./bootloader.py -P /dev/ttyUSB1 -p $1

echo "Setting address..."
./bootloader.py -P /dev/ttyUSB1 -a $2
