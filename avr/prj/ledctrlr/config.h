#ifndef __CONFIG_H_
#define __CONFIG_H_


// system clock
#define SYSCLK 20000000UL
#define F_CPU  SYSCLK


#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include <avr/boot.h>
#include <avr/eeprom.h>

#include "pins.h"
#include "macros.h"


// number of bytes in instrument address and payload packet
#define COM_AD_SIZE  3
#define COM_PL_SIZE 25


// EEPROM addresses
#define EEPROM_INST_ADDR    ((uint8_t*) 1)


// UART config
#define UART_PRESCALER  259
#define UART_DBL        1
#define UART_PARITY     0

#define UART_RX_BUFSZ   128
#define UART_TX_BUFSZ   1


#endif
