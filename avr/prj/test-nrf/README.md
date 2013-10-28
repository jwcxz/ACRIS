Test FW: Wireless Communication
===============================

This is a highly-configurable testing firmware that interacts with the
NRF24L01+ to send or receive data.  The relative build parameters to pass to
`make` are `MODE` and `TRGT`.


## Transmitter target

When building with `MODE=tx TRGT=breadboard` (`TRGT=ledctrlr` untested),
firmware that simply sends payloads of incrementing values to the fixed
receiver address of `0xAAAA01`.  The transmitter's own address is `0x555501`,
but this is irrelevant.


## Receiver target

The receiver listens for incoming packets and happily blinks LEDs when it
receives them.  There are two options for building with `MODE=rx`.


### Breadboard setup

Building with `TRGT=breadboard` produces firmware that is designed to operate
with the NRF24L01+ on the eral SPI bus and a serial console on the UART.  A
serial bootloader must be installed on the chip.

The firmware spits out received packets to the UART for inspection.
`sw/tests/nrf-dbg/nrf-cap.py` is useful here.


### Reworked ACRIS board setup

Building with `TRGT=ledctrlr` produces firmware that is designed for reworked
ACRIS LED controllers.  The NRF24L01+ is attached to the USART and the boards
are programmed directly over JTAG.

Therefore, no UART output is available, but you can watch the debug LEDs
happily blink received packets.
