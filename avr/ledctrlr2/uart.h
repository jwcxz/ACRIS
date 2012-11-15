#ifndef _UART_H_
#define _UART_H_

// uart baud rate prescale (if nothing found on the EEPROM)
#define DEF_BAUD_PRESCALE 64    // 38400
#define DEF_BAUD_DOUBLE 1
#define DEF_BAUD_PRESCALE_SLOW 129    // 9600
#define DEF_BAUD_DOUBLE_SLOW 0

// buffer sizes (handle up to the maximum number of command arguments for
// receive, some small number for transmit)
#define UART_RX_BUFSZ   32 // 1+24 necessary
#define UART_TX_BUFSZ   4

void uart_init(void);
uint8_t uart_rx(void);
uint8_t uart_data_rdy(void);
void uart_tx(uint8_t);

#endif
