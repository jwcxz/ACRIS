#include "config.h"
#include "macros.h"

#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>

#ifndef CTRLR_TYPE
    #define CTRLR_TYPE CTRLR_RGB
    //#define CTRLR_TYPE CTRLR_UVS
#endif

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
extern uint8_t instaddr;    // instrument address

// tlc driver data holder
// for rgb LEDs, tlc[0] is red, [1] is grn, and [2] is blu
// for uv/strobes, tlc[0] is white, tlc[1] is uv
// we should probably use pointers and stuff
// XXX: remove volatile
#if (CTRLR_TYPE == CTRLR_RGB)
extern volatile uint8_t tlc[3][24];
#elif (CTRLR_TYPE == CTRLR_UVS)
extern volatile uint8_t tlc[2][24];
#endif /* CTRLR_TYPE */

extern uint8_t action;          // current action
extern uint8_t numargs;         // number of arguments to expect
extern uint8_t args[12];        // array to store arguments
                                // XXX: the array size needs to be changed if
                                // we ever expect more than 12 args
extern uint8_t* argptr;         //   ... associated pointer

extern uint8_t timed_out;       // 1 when we're in timeout mode
extern uint8_t to_direc;        // 0 when shifting one way and 1 when shifting
                                // the other

int main(void);
void get_addr(void);
void receive_data(void);



