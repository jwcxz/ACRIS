#
# AVR Project Makefile
# build configuration for this project
# jwc :: jwcxz.com
#

D_ROOT=../..
D_PROJ=.

PROJECT_NAME=rftxer

# project source files
S_SRC=main.c

# module source files
S_SRC+=dbg.c nrf.c nrfspi_spi.c uart_printf.c uart_rb.c uart.c

# program the chip with the bootloader?
PGM_WITH_BOOTLOADER=1

# AVR part hardware options
AVR_LFUSE=0xce
AVR_HFUSE=0xdf
AVR_EFUSE=0xf8

include $(D_ROOT)/bld/Makefile.in
