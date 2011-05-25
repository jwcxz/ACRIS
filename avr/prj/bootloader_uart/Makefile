#
# AVR Project Makefile
# build configuration for this project
# jwc :: jwcxz.com
#

D_ROOT=../..
D_PROJ=.

PROJECT_NAME=ledbtldruart

BLD_OLVL=2

# project source files
S_SRC=main.c

# module source files
S_SRC+=dbg.c eeprom.c flash.c uart.c uart_rb.c

# program the chip with the bootloader?
PGM_WITH_BOOTLOADER=0

# AVR part hardware options
AVR_LFUSE=0xce
AVR_HFUSE=0xd4
AVR_EFUSE=0xf8

LDFLAGS+=-Wl,--section-start=.text=0x3800

include $(D_ROOT)/bld/Makefile.in
