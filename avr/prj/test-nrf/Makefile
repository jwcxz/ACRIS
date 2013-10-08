#
# AVR Project Makefile
# build configuration for this project
# jwc :: jwcxz.com
#

D_ROOT=../..
D_PROJ=.

MODE=rx
ifeq ($(MODE), rx)
	DEF=NRF_FN_RX
else
	MODE=tx
	DEF=NRF_FN_TX
endif

PROJECT_NAME=test-nrf-$(MODE)

# project source files
S_SRC=main.c

# module source files
S_SRC+=dbgled.c nrf.c nrfspi_usart.c

# program the chip with the bootloader?
PGM_WITH_BOOTLOADER=1

# AVR part hardware options
AVR_LFUSE=0xce
AVR_HFUSE=0xdf
AVR_EFUSE=0xf8

CFLAGS+=$(addprefix -D,$(DEF))

include $(D_ROOT)/bld/Makefile.in
