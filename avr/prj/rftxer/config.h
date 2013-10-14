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

#include "eeprom_map.h"
#include "pins.h"
#include "macros.h"


// UART configuration
#define UART_BAUD_RATE  115200
#define UART_PRESCALER  ( (uint16_t) (SYSCLK/(2*UART_BAUD_RATE) - 1) )
#define UART_DBL        0
#define UART_PARITY     0


// number of bytes in instrument address and payload packet
#define COM_CHANNEL  5
#define COM_AD_SIZE  3
#define COM_PL_SIZE 25


// USART-as-SPI baud rate
#define NRF_BAUD_RATE   1000000UL
#define NRF_PRESCALER   ( (uint16_t) (SYSCLK/(2*NRF_BAUD_RATE) - 1) )


// this is a transmitter
#define NRF_FN_TX


// this device's address
#define TX_ADDR {0x01, 0x55, 0x55}

// mask for receive devices
#define RX_MASK1 0xAA
#define RX_MASK2 0xAA

#endif
