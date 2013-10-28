ACRIS Firmware
==============

This directory contains firmware for the AVR MCU.  It is targeted at the
ATmega168.  The ATmega88 won't work because the bootloader is too big.


## Structure

    bld/        - configuration files for build
    inc/        - include files
    lib/        - library modules
    prj/        - projects
    Makefile    - rules for making projects from the fw dir
    README.md   - well, what are you reading?


## Projects

Projects are located in the `prj` dir.

    bootloader  - ACRIS bootloader (broken due to size issues)
    ledctrlr    - main LED controller firmware (getting there)
    rftxer      - wireless transmitter module (basic idea down)

    test-nrf    - first attempt at wireless communication with an NRF24L01+

    bootloader_uart - modified legacy bootloader that communicates over serial
    ledctrlr_uart   - modified legacy LED controller firmware, also serial


### Project structure

Each project includes:

    Makefile    - rules for making the project
    config.h    - master configuration file with project-specific rules
    pins.h      - project pinout
    main.c/h    - main project source
    README.md   - exactly what you would expect


## Libraries

There are also libraries.  In some cases, a single header can be supported by
multiple underlying designs.  Example: the `nrfspi_` module can either be
driven by the USART or the SPI module on the AVR.

    inc/ - include headers
    lib/ - library modules

    fn prefix   files       description
    __________  __________  __________________________________________________
    dbg_        dbg.h       control of board debug LEDs
                dbg.c

    eeprom_     eeprom.h    reading and writing settings in the EEPROM
                eeprom.c

    flash_      flash.h     flash memory access functions
                flash.c

    led_        led.h       action translator for LED array output
                led.c

    ledset_     ledset.h    functions for setting up TLC output buffer
                ledset.c

    nrf_        nrf.h       driver for NRF24L01+
                nrf.c

    nrfspi_     nrfspi.h    underlying data transfer layer between MCU and NRF
                nrfspi_spi.c      using HW SPI module
                nrfspi_usart.c    using USART in SPI master mode

    tlc_        tlc.h       driver for TLC5940
                tlc.c

    uart_       uart.h      UART communication layer
                uart.c

    uart_printf_    uart_printf.h   retargeting printf for uart output
                    uart_printf.c

    uart_rb_    uart_rb.h   ring-buffer com layer to make receiving streaming
                uart_rb.c   data easier


## Build

The `bld` directory contains the master rules for building projects.


## TODOs:
0.  Fix the wireless bootloader... it's too big for the flash.  This probably
    means an architectural change in reality, but at the very minimum involves
    statically linking to the end of the app-space flash or something stupid
    and dangerous like that.

1.  Install a shim between `nrf_` and the application layer to allow
    switching between wireless communication over NRF24L01+ and wired
    communication over RS-485.

2.  Add optional automatic retransmission support to the NRF driver.

3.  [partial] Update the bootloader to support wireless communication, with
    automatic retransmission to guarantee a good firmware load.

4.  Come up with a decent scheme for identifying all devices on the network and
    talking with each one of them (i.e. some kind of auto-discovery).  I have
    some ideas floating around in my head that make use of the multi-pipe
    features of the Nordic chips.

5.  Add training to startup to determine best communication channels; come up
    with a way to change network channels on the fly.

6.  Expand transmitter system to support multiple transmitters on a single host
    to boost throughput.  For extra lulz, make some run on the USART and others
    run on SPI and make the whole architecture event driven.
