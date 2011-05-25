RF Transmitter
==============

This project essentially acts as a serial-to-RF transmitter.  Eventually it'll
be replaced by a true USB CDC module on a nice microprocessor, but for now, it
reads in a packet of data to send to a given address, and sends it.


## Protocol

The current protocol to transmit a packet is simply:

    [SYNC...][ADDR][PAYLOAD...]

The `[SYNC...]` header consists of `NUM_SYNCS` copies of `CMD_SYNC` to sync up
the serial stream.

The target address `[ADDR]` is a single byte (the LSB of the full address) for
now.  The full `COM_AD_SIZE` address space may be used later.

Since `[PAYLOAD...]` has a specific width (`COM_PL_SIZE`), the state machine is
pretty simple.


## Testing

The utility `sw/tests/nrf-dbg/nrf-txpld.py` sends test payloads to the
transmitter firmware.


## TODOs

1.  Allow enabling or disabling various features like auto-retransmit (useful
    for firmware updating, not useful for data streaming)

2.  Provide capability for LED controllers to report back their status in their
    ACK payloads and pass it up to the application layer.

3.  Lots of other stuff, like multiple-transmitter support.
