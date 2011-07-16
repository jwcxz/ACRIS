/* A C R I S   P R O J E C T        *
 * LED Controller Bootloader        *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo - http://jwcxz.com/  *
 *                                  *
 * Main bootloader header file      *
 ************************************/

#include "config.h"
#include "macros.h"

#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include <avr/boot.h>
#include <avr/eeprom.h>

#define PAGESIZE 128
#define AM_ALL 255
#define CMD_NOP 'N'
//#define CMD_SYNC 170
#define CMD_ADDR 'A'
#define CMD_BAUD 'B'
#define CMD_BOOT 'R'
#define CMD_DISP_ADDR_H 'D'
#define CMD_DISP_ADDR_L 'E'
#define CMD_MASK 'M'
#define CMD_PROG 'P'
#define CMD_FNSH 'F'

#define CST_IDLE     0
#define CST_SYNC     1
#define CST_MASK     2
#define CST_ADDR     3
#define CST_BAUD_H   4
#define CST_BAUD_L   5
#define CST_BAUD_D   6
#define CST_PROG_A_H 7
#define CST_PROG_A_L 8
#define CST_PROG_D   9
#define CST_PROG_V   10


/* UART BUFFERS */
extern volatile uint8_t uart_rxbuf[UART_RX_BUFSZ];
extern volatile uint8_t *uart_rxbuf_iptr;
extern volatile uint8_t *uart_rxbuf_optr;
extern volatile uint8_t uart_rxbuf_count;
extern volatile uint8_t rxen;

/* GLOBAL VARIABLES */
extern uint8_t instaddr;    // instrument address

int main(void);
void receive_data(void);
void process_rx(void);
void give_up(uint8_t);
void addr_set(uint8_t);
void baud_set(uint8_t);
void write_page(void);
void verify_flash(uint8_t);
uint8_t applies_to_me(void);
