RF Transmitter
==============

This project essentially acts as a serial-to-RF transmitter.  Eventually it'll
be replaced by a true USB CDC module, but for now, it reads in a packet of data
to send to a given address, and sends it.


## Protocol

The current protocol to transmit a packet is simply:

    [SYNC][SYNC][ADDR][PAYLOAD...]

Since `[PAYLOAD...]` has a specific width (`COM_PL_SIZE`), the state machine is pretty simple.


## TODOs
    
1.  Allow enabling or disabling various features like auto-retransmit (useful
    for firmware updating, not useful for data streaming)

2.  Provide capability for LED controllers to report back their status in their
    ACK payloads and pass it up to the application layer.

3.  Lots of other stuff.
