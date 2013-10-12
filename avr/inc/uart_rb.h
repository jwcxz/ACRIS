#ifndef __UART_RB_H
#define __UART_RB_H


void uart_rb_init(void);

uint8_t uart_rb_data_rdy(void);

uint8_t uart_rb_rx(void);
void uart_rb_tx(uint8_t);

void uart_rb_rxh(uint8_t data);
void uart_rb_txh(void);


#endif
