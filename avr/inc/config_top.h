#ifndef __CONFIG_TOP_H
#define __CONFIG_TOP_H

// system clock
#define SYSCLK 20000000UL
#define F_CPU  SYSCLK


#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>

#include "eeprom_map.h"
#include "pins_top.h"
#include "macros.h"


// number of bytes in instrument address and payload packet
#define COM_AD_SIZE  3
#define COM_PL_SIZE 25


// USART-as-SPI baud rate
#define NRF_BAUD_RATE   5000000UL
#define NRF_PRESCALER   ( (uint16_t) (SYSCLK/(2*NRF_BAUD_RATE) - 1) )


#endif
