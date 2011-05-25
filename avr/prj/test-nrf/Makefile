#
# AVR Project Makefile
# build configuration for this project
# jwc :: jwcxz.com
#

D_ROOT=../..
D_PROJ=.

MODE=rx
TRGT=breadboard

ifeq ($(MODE), rx)
	DEF=NRF_FN_RX
else
	MODE=tx
	DEF=NRF_FN_TX
endif

ifeq ($(TRGT), breadboard)
	DEF+=NRF_TG_BB
else
	DEF+=NRF_TG_LC
endif


PROJECT_NAME=test-nrf-$(MODE)-$(TRGT)

# project source files
S_SRC=main.c

# module source files
S_SRC+=dbg.c nrf.c

# if targeting the breadboard, use SPI, otherwise use USART
ifeq ($(TRGT), breadboard)
	S_SRC+=nrfspi_spi.c uart_printf.c uart_rb.c uart.c
else
	S_SRC+=nrfspi_usart.c
endif


# program the chip with the bootloader?
ifeq ($(TRGT), breadboard)
	PGM_WITH_BOOTLOADER=1
else
	PGM_WITH_BOOTLOADER=0
endif


# AVR part hardware options
AVR_LFUSE=0xce
AVR_HFUSE=0xdf
ifeq ($(TRGT), breadboard)
	AVR_EFUSE=0xf8
else
	AVR_EFUSE=0xf9
endif


CFLAGS+=$(addprefix -D,$(DEF))

include $(D_ROOT)/bld/Makefile.in
