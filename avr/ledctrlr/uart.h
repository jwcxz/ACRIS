#ifndef _UART_H_
#define _UART_H_

#include "main.h"

// uart baud rate prescale (if nothing found on the EEPROM)
#define DEF_BAUD_PRESCALE 64    // 38400
#define DEF_BAUD_DOUBLE 1
#define DEF_BAUD_PRESCALE_SLOW 129    // 9600
#define DEF_BAUD_DOUBLE_SLOW 0

void uart_init(void);
uint8_t uart_rx(void);
uint8_t uart_data_rdy(void);
void uart_tx(uint8_t);

#endif
