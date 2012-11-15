#ifndef _MAIN_H_
#define _MAIN_H_

#include "config.h"

#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>

/* UART BUFFERS */
extern volatile uint8_t uart_rxbuf[UART_RX_BUFSZ];
extern volatile uint8_t *uart_rxbuf_iptr;
extern volatile uint8_t *uart_rxbuf_optr;
extern volatile uint8_t uart_rxbuf_count;
extern volatile uint8_t rxen;

/* XXX: uncomment when enabling TX
extern unsigned char uart_txbuf[UART_TX_BUFSZ];
extern unsigned char *uart_txbuf_iptr = uart_txbuf;
extern unsigned char *uart_txbuf_optr = uart_txbuf;
extern unsigned short int uart_txbuf_count = 0;
*/

/* GLOBAL VARIABLES */
extern uint8_t my_addr;    // instrument address

// tlc driver data holder
// XXX: remove volatile
extern uint8_t tlc[3][24];

int main(void);
void receive_data(void);

#define MAXARGS 24

// state machine states
#define CST_IDLE 0
#define CST_SYNC 1
#define CST_ARGS 2

// commands
#define CMD_LDSET_LEGACY 0xAA
#define CMD_LDSET 0x00
#define CMD_HDSET 0x01
#define CMD_LDALL 0x10
#define CMD_HDALL 0x11

#endif
