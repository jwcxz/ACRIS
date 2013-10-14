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
#define EEPROM_ADDR_INST    ((uint8_t *) 0)


// UART config
#define UART_PRESCALER  21
#define UART_DBL        1
#define UART_PARITY     0

#define UART_RX_BUFSZ   64
#define UART_TX_BUFSZ   64


// USART-as-SPI baud rate
#define NRF_BAUD_RATE   1000000UL
#define NRF_PRESCALER   ( (uint16_t) (SYSCLK/(2*NRF_BAUD_RATE) - 1) )


// this project is run in receiver mode
#if ( !defined(NRF_FN_RX) && !defined(NRF_FN_TX) )
#define NRF_FN_RX
#endif


// instrument addresses
#define TX_ADDR {0x01, 0x55, 0x55}
#define RX_ADDR {0x01, 0xAA, 0xAA}

// minimum time to pulse CE to initiate a transmit
#define NRF_TX_PULSE_MIN_US 10

#endif
