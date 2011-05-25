ACRIS -- Advanced, Controllable Room Illumination System
========================================================

Inspired by a separate project I worked on over January and February of 2011,
[ACRIS] is a system designed to provide precise control of high-powered LEDs.
It consists of a set of LED controller boards, which drive LEDs using
constant-current sink drivers and are controlled over an RF network by a
transmitter.  This hardware is very easily controlled via simple serial
commands sent by software.

The goal for ACRIS is to provide a complete stack from base hardware to
software to facilitate rapid construction and control of many kinds of lighting
fixtures.


## Features

1.  Each LED controller supports up to 15 channels, with each channel sinking
    up to 360mA
2.  Each channel has 4096 levels of brightness
3.  LED controllers are around 2.3"x3.9"
4.  LED controllers have a bootloader, so one can program new firmware to all
    devices on the bus easily
5.  Host device commands the LED controllers over an RS-485 network (functional
    and mature) or over RF (under development)


## Repository Layout

The repository structure is as follows:

* `avr`: firmware for the ATmega microcontrollers used in the LED controllers
* `boards`: schematics and PCBs
* `sw`: software for configuring and controlling the system



[ACRIS]:http://jwcxz.com/projects/acris
