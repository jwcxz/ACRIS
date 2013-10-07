Test FW: Wireless Communication
===============================

This project, dependong on how it's built, transfers or receives a
`COM_PL_SIZE`-byte packet.  The receiver sets the debug LEDs based on its first
10 bytes, delaying between each setting.

The receiver address is fixed at `0xAAAA01` and the transmitter address is
fixed at `0x555501`.
