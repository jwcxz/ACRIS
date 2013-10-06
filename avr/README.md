ACRIS Firmware
==============

This directory contains firmware for the AVR MCU.  It is targeted at the
ATmega168.  The ATmega88 won't work because the bootloader is too big.


## Structure

    inc/        - include files
    lib/        - library modules
    prj/        - projects
    tools/      - development tools
    README.md   - well, what are you reading?


## Projects

Projects are located in the `prj` dir.

    bootloader  - ACRIS bootloader 
    ledctrlr    - main LED controller firmware
    rftxer      - wireless transmitter module

    test-rfrx   - first attempt at wireless reception with an NRF24L01+
    test-rftx   - first attempt at wireless transmission with an NRF24L01+


### Project structure

Each project includes:

    Makefile    - rules for making the project
    config.h    - master configuration file with project-specific rules
    pins.h      - project pinout
    main.c/h    - main project source
    README      - exactly what you would expect


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


## Tools

Finally, there are some tools for fimrware development in the `tools` dir:

    mktags  - invoke exhuberant ctags with fw dir and AVR toolchain dir


## TODOs:

    1.  Decouple address matching in LED functions and move everything to a
        communication layer

    2.  Install a shim between `nrf_` and the application layer to allow
        switching between wireless communication over NRF24L01+ and wired
        communication over RS-485.

    3.  Add optional automatic retransmission support to the NRF driver.

    4.  Update the bootloader to support wireless communication, with automatic
        retransmission to guarantee a good firmware load.
