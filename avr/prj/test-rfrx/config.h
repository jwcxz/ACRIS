#ifndef __CONFIG_H_
#define __CONFIG_H_


#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include <avr/boot.h>
#include <avr/eeprom.h>

#include "pins.h"
#include "macros.h"

#include "nrf.h"


// system clock
#define SYSCLK 20000000UL
#define F_CPU  SYSCLK


// number of bytes in instrument address and payload packet
#define COM_AD_SIZE  3
#define COM_PL_SIZE 25


// USART-as-SPI baud rate
#define NRF_BAUD_RATE 5000000UL
#define NRF_PRESCALER SYSCLK/(2*NRF_BAUD_RATE) - 1


// this project is run in receiver mode
#define NRF_FN  NRF_FN_RX


#endif
