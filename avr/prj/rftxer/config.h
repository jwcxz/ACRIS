#ifndef __CONFIG_H_
#define __CONFIG_H_


#include "config_top.h"
#include "pins.h"

// number of sync bytes to expect
#define NUM_SYNCS 3

// UART configuration
#define UART_PRESCALER  86
#define UART_DBL        1
#define UART_PARITY     0

#define UART_RX_BUFSZ   4*(NUM_SYNCS+COM_AD_SIZE+COM_PL_SIZE)
#define UART_TX_BUFSZ   64


// this device's address
#define MY_ADDR {0xE7, 0xE7, 0xE7}

// mask for receive devices
#define RX_MASK {0xFF, 0xC2, 0xC2}

#endif
