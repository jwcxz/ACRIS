LED Controller Application
==========================

This is the main project of ACRIS: the firmware that runs on the LED drivers.
This version receives command packets via the UART.


## Protocol

The application-layer protocol format is: `[CMD][ARG0][ARG1]...[ARGn]`

    CMD  NAME  #ARGS ARGS / DESCRIPTION
    ____ _____ _____ _____________________________________________________
    0xAA LDSET 15    0RED 0GRN 0BLU 1RED 1GRN 1BLU ... 4RED 4GRN 4BLU
    0x00                8-bit control of each LED on the controller
                        enforces backwards compatibility with the existing
                        protocol (total 5*3*8=120 bits)
    0x01 HDSET  23   0000|0REDH 0REDL|0GRNH 0GRNL|0BLUH ...
                        12-bit packed control of each LED
                        (total 5*3*12=180 bits + 4 bits for alignment)
    0x10 LDALL  3    RED GRN BLU
                        8-bit control of all the LEDs on a given device
                        (total 3*8=24 bits)
    0x11 HDALL  5    0000|REDH REDL|GRNH ...
                        12-bit control of all the LEDs on a given device
                        (total 3*12=36 bits -> 40 bits with the firstmost
                        nibble ignored)


## Addressing

Addressing is handled in the communication layer.  It is `COM_AD_SIZE` bytes
long.  LED controllers are designed to be receivers.  Their addresses are set
in the bootloader by the EEPROM.  In the UART version, only the least
significant byte is minded.


## TODOs:

1.  Merge this into mainline wireless controller firmware and allow
    compile-time selection of the underlying communication system.
