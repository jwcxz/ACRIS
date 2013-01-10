/* A C R I S   P R O J E C T
 * http://jwcxz.com/projects/acris
 * JWC
 */

#include "main.h"

#include "dbgled.h"
#include "eeprom.h"
#include "led.h"
#include "tlc.h"
#include "uart.h"

volatile uint8_t uart_rxbuf[UART_RX_BUFSZ];
volatile uint8_t *uart_rxbuf_iptr = uart_rxbuf;
volatile uint8_t *uart_rxbuf_optr = uart_rxbuf;
volatile uint8_t uart_rxbuf_count = 0;
volatile uint8_t rxen = 0;

volatile uint8_t uart_txbuf[UART_TX_BUFSZ];
volatile uint8_t *uart_txbuf_iptr = uart_txbuf;
volatile uint8_t *uart_txbuf_optr = uart_txbuf;
volatile uint8_t uart_txbuf_count = 0;

uint8_t my_addr = 0;

uint8_t tlc[3][24];

uint8_t action;         // current action
uint8_t numargs;        // number of arguments to expect
uint8_t args[MAXARGS];  // array to store arguments
uint8_t *argptr = args; //   ... associated pointer

static uint8_t cmdstate;

int main(void) {
    // initialize debug LEDs
    dbg_init();
    dbg_set(0x8);

    // initialize TLC
    tlc_init();
    // set everything off
    //tlc_drive();

    // get the address of the device
    my_addr = get_addr();

    // initialize UART
    uart_init();
    
    // enable interrupts
    sei();
    rxen = 1;

    while (1) {
        if ( uart_data_rdy() ) {
            receive_data();
        }
    }

	return 0;
}

void receive_data(void) {
    unsigned char inbyte;

    inbyte = uart_rx();

    if ( inbyte == CMD_SYNC )  {
        // the sync byte is always treated as a trigger to reset the state
        // machine -- never send it as an argument
        cmdstate = CST_SYNC;
    } else {
        switch (cmdstate) {
            case CST_IDLE:
                cmdstate = CST_IDLE;
                break;
                
            case CST_SYNC:
                // save command for later processing
                action = inbyte;
                
                // reset arg pointer
                argptr = args;

                switch (inbyte) {
                    case CMD_LDSET:
                    case CMD_LDSET_LEGACY:
                        dbg_set(0x4);
                        action = CMD_LDSET; // replace legacy action code
                        numargs = 16;
                        cmdstate = CST_ARGS;
                        break;

                    case CMD_HDSET:
                        dbg_set(0x4|0x1);
                        numargs = 24;
                        cmdstate = CST_ARGS;
                        break;

                    case CMD_LDALL:
                        dbg_set(0x2);
                        numargs = 24;
                        numargs = 4;
                        cmdstate = CST_ARGS;
                        break;

                    case CMD_HDALL:
                        dbg_set(0x2|0x1);
                        numargs = 6;
                        cmdstate = CST_ARGS;
                        break;
                        
                    case CMD_STATS:
                        dbg_set(0x8);
                        numargs = 1;
                        cmdstate = CST_ARGS;
                        break;

                    default:
                        cmdstate = CST_IDLE;
                        break;
                }
                break;

            case CST_ARGS:
                *argptr++ = inbyte;

                if ( argptr - args == numargs ) {
                    // all arguments collected
                    // perform appropriate action
                    
                    if (action == CMD_STATS) {
                        // send back system status
                        if (my_addr == args[0]) {
                            uart_tx(tlc_read_xerr());
                        }
                    } else {
                        led_action(action, args);
                    }

                    cmdstate = CST_IDLE;
                } else {
                    cmdstate = CST_ARGS;
                }
                break;

            default:
                // the hell!?
                cmdstate = CST_IDLE;
                break;
        }
    }
}
