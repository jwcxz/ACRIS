#ifndef _MAIN_H_
#define _MAIN_H_

#include "config.h"

#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>


// buffer sizes (handle up to the maximum number of command arguments for
// receive, some small number for transmit)
#define UART_RX_BUFSZ   32 // 1+24 necessary
#define UART_TX_BUFSZ   4

/* UART BUFFERS */
extern volatile uint8_t uart_rxbuf[UART_RX_BUFSZ];
extern volatile uint8_t *uart_rxbuf_iptr;
extern volatile uint8_t *uart_rxbuf_optr;
extern volatile uint8_t uart_rxbuf_count;
extern volatile uint8_t rxen;

extern volatile uint8_t uart_txbuf[UART_TX_BUFSZ];
extern volatile uint8_t *uart_txbuf_iptr;
extern volatile uint8_t *uart_txbuf_optr;
extern volatile uint8_t uart_txbuf_count;

/* GLOBAL VARIABLES */
extern uint8_t my_addr;    // instrument address
extern uint8_t tlc[3][24];

int main(void);
void receive_data(void);

#define MAXARGS 24

// state machine states
#define CST_IDLE 0
#define CST_SYNC 1
#define CST_ARGS 2


// commands
#define CMD_SYNC 0x55

#define CMD_LDSET_LEGACY 0xAA
#define CMD_LDSET 0x00
#define CMD_HDSET 0x01
#define CMD_LDALL 0x10
#define CMD_HDALL 0x11

#endif
