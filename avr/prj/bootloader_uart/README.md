Bootloader Firmware
===================

In order to provide OTA firmware updates, I wrote a bootloader.  For more
information, see the [ACRIS bootloader page].


## Development Note

This project will require extensive modifications to support wireless
communication.  The existing wireless driver needs to support automatic
retransmission and have error modes that inform the master firmware updater
application of failures.


## Features

This bootloader provides the following features:

1.  Fast startup time (i.e. bootloader->application time)
2.  Downloading of program to device
3.  Set address of instrument
4.  Set the transmission baud rate (via the divisor)
5.  Set a mask (only operate on some devices)
6.  View the instrument address on the debug LEDs
7.  Program verification (not ready)


## Protocol

Transmission is done through a serial protocol, which looks like `[CMD][ARG0][ARG1]...[ARGn]`

    FN  ARGS    DESCRIPTION
    ___ _______ ____________________________________________________
    170 0       SYNC -- start of a packet

    N   0       NOP -- sent to wake bootloader up

    A   1       Set 1-byte address of the device in EEPROM

    B   2       [High][Low][Double?] -- set divisor and U2XN of the UART in EEPROM

    D   0       Show the high nibble of the instrument address on the debug LEDs

    E   0       Show the low nibble of the instrument address on the debug LEDs

    M   1       [InstAddr] Instrument address to work with for all following commands
                    0xFF - all instruments
                    0xF0-0xFE - blocks of 16

    P   2       [Addr][Page...] - Send program one page at a time
                    To simplify the bootloader, it does NOT take an Intel HEX
                    file as an input.  Rather, a special "program" script reads
                    the HEX file and outputs the following format:
                        [Starting Address][Page][Checksum]
                    The checksum is the one's complement of the sum of the
                    page stream.

                    Note: this means that the stream length depends on the page
                    size (whereas Intel HEX files have known lengths).
                    Furthermore, it requires that unused bytes be 0-filled or
                    something.  I'd rather make the programmer

    R   0       BOOT - boot the application


## TODOs:

1.  Enable automatic retransmission
2.  Allow reading bytes from EEPROM to debug LEDs
3.  Add ability to write to and read from any EEPROM address



[ACRIS bootloader page]:http://jwcxz.com/projects/acris/bootloader.php
