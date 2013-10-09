#
# AVR Project Makefile
# build configuration for this project
# jwc :: jwcxz.com
#

D_ROOT=../..
D_PROJ=.

BRDREV?=2

PROJECT_NAME=ledctrlruart

BLD_OLVL=2

# project source files
S_SRC=main.c

# module source files
S_SRC+=dbg.c eeprom.c ledset.c led.c tlc.c uart.c uart_rb.c

# program the chip with the bootloader?
PGM_WITH_BOOTLOADER=1

# AVR part hardware options
AVR_LFUSE=0xce
AVR_HFUSE=0xdf
AVR_EFUSE=0xf9

CFLAGS+=-D"BRDREV=$(BRDREV)"

include $(D_ROOT)/bld/Makefile.in
