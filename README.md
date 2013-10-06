ACRIS -- Advanced, Controllable Room Illumination System
========================================================

By JWC

Born out of a separate project I worked on over January and February of 2011,
ACRIS is a system designed to provide precise control of high-powered LEDs.  It
consists of a set of LED controller boards, which drive LEDs using
constant-current sink drivers and are controlled over an RS-485 network, and a
communications board, which interfaces with a computer over USB and talks to
the LED controllers.  This hardware is very easily controlled via simple serial
commands sent by software.

My goal for ACRIS is to provide a complete stack from base hardware to
software.


## Features

1.  Each LED controller supports up to 15 channels, with each channel sinking
    up to 360mA
2.  Each channel has 4096 levels of brightness
3.  LED controllers are around 2.3"x3.9"
4.  Status LEDs on the board tell you what the hell is going on
5.  LED controllers have a bootloader, so you can program a new main
    application, set the addresses of various controllers, and set the
    application baud rate all over the RS-485 network!
6.  You can even control which devices you program; you can act on single
    devices, blocks of devices, or all devices at once!


## Development

This repository has a lot of stuff that's continually being updated.  Current
effort is to convert the system to be wireless using the NRF24L01+ chip.
