#ifndef __CONFIG_H_
#define __CONFIG_H_


#include "config_top.h"
#include "pins.h"


// UART config
#define UART_PRESCALER  21
#define UART_DBL        1
#define UART_PARITY     0

#define UART_RX_BUFSZ   64
#define UART_TX_BUFSZ   64


// this project is run in receiver mode by default
#if ( !defined(NRF_FN_RX) && !defined(NRF_FN_TX) )
#define NRF_FN_RX
#endif

// target the breadboard by default
#if ( !defined(NRF_FN_BB) && !defined(NRF_FN_LC) )
#define NRF_FN_BB
#endif

// instrument addresses
#define TX_ADDR {0xE7, 0xE7, 0xE7}
#define RX_ADDR {0xC2, 0xC2, 0xC2}


#endif
