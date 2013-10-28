#ifndef __CONFIG_H_
#define __CONFIG_H_


#include "config_top.h"
#include "pins.h"


// UART configuration
#define UART_PRESCALER  21
#define UART_DBL        1
#define UART_PARITY     0

#define UART_RX_BUFSZ   64
#define UART_TX_BUFSZ   64


// this device's address
#define MY_ADDR {0x01, 0x55, 0x55}

// mask for receive devices
#define RX_MASK1 0xAA
#define RX_MASK2 0xAA

#endif
