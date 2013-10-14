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


// number of bytes in instrument address and payload packet
#define COM_AD_SIZE  3
#define COM_PL_SIZE 25


// commands
#define CMD_LDSET_LEGACY 0xAA
#define CMD_LDSET 0x00
#define CMD_HDSET 0x01
#define CMD_LDALL 0x10
#define CMD_HDALL 0x11

#define CMD_STATS 0x20


// USART-as-SPI baud rate
#define NRF_BAUD_RATE   5000000UL
#define NRF_PRESCALER   ( (uint16_t) (SYSCLK/(2*NRF_BAUD_RATE) - 1) )


// this project is run in receiver mode
#define NRF_FN_RX


#endif
