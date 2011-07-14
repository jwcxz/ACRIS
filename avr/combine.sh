#!/bin/bash

# (temporary)

cd bootloader && make clean && make && make hex && cd ../boardtest && make clean && make && make hex && cd .. && srec_cat boardtest/boardtst.hex -I bootloader/ledbtldr.hex -I -o combined.hex -I && avrdude -F -c ponyser -p m168 -P /dev/ttyS0 -e -U flash:w:combined.hex 
