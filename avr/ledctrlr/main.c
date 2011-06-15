/* A C R I S   P R O J E C T ********
 * LED Controller Bootloader        *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo -- http://jwcxz.com/ *
 *                                  *
 * LED controller main loop file    *
 ************************************/

#include "main.h"

#include "led.h"
#include "timeout.h"
#include "tlc.h"
#include "uart.h"
#include "dbgled.h"
#include "eeprom.h"

volatile uint8_t uart_rxbuf[UART_RX_BUFSZ];
volatile uint8_t *uart_rxbuf_iptr = uart_rxbuf;
volatile uint8_t *uart_rxbuf_optr = uart_rxbuf;
volatile uint8_t uart_rxbuf_count = 0;
volatile uint8_t rxen = 0;

uint8_t instaddr = 0;

volatile uint8_t tlc[3][24];

uint8_t action;          // current action
uint8_t numargs;         // number of arguments to expect
uint8_t args[15];        // array to store arguments XXX: the array size
                         // needs to be changed if we ever expect more
                         // than 12 args
uint8_t* argptr = args;  //   associated pointer

/* COMMAND PROCESSOR STATE MACHINE */
#define CST_IDLE    0
#define CST_SYNC    1
#define CST_ARGS    2
static uint8_t cmdstate;

int main(void) {
    // get the address of the device
    get_addr();

    // initialize TLC
    tlc_init();

    // initialize UART
    uart_init();

    // show address of the device on the debug LEDs
    dbg_set(0xFF);
    _delay_ms(500);
    show_addr();
    _delay_ms(500);

    // enable interrupts
    sei();
    rxen = 1;

    while (1) {
        if ( rxen == 0 && uart_rxbuf_count < UART_RX_BUFSZ/2 ) {
            // buffer has been partially depleted, so we can start accepting
            // data again
            rxen = 1;
            sei();
        }

        if ( uart_data_rdy() ) receive_data();
    }

	return 0;
}

void receive_data(void) {
    unsigned char inbyte;

    inbyte = uart_rx();

    /* process for adding new commands:
     * 1. update this state machine (the cmdstate switch)
     *      to add args, set numargs and set cmdstate = CST_ARGS
     *      otherwise, go to CST_IDLE if it doesn't apply to you
     *      or, if there are no args, set cmdstate = CST_IDLE and call
     *      led_action()
     * 2. update led_action() in led.c with the function that should be called
     *    given a command.  led_action() is just a wrapper function, but it
     *    makes the code a bit cleaner
     * 3. create your action function, prefix with led_ and name it the name of
     *    the 5-character action keyword
     */

    if ( inbyte == CMD_SYNC )  {
        cmdstate = CST_SYNC;
    } else {
        switch (cmdstate) {
            case CST_IDLE:
                cmdstate = CST_IDLE;
                break;
            case CST_SYNC:
                // save command for later processing
                action = inbyte;
                argptr = args;

                switch (inbyte) {
                    case CMD_DOALL:
                        numargs = 12;
                        cmdstate = CST_ARGS;

                        led_action();
                        break;

                    default:
                        // 0xF0-0xFE are reserved to describe blocks of 16
                        // addresses
                        if ( inbyte >= 0xF0 && inbyte <= 0xFE ) {
                            if ( instaddr >= (inbyte&0x0F)*16 && 
                                    instaddr <= (inbyte&0x0F)*16+15 ) {
                                numargs = 15;
                                cmdstate = CST_ARGS;
                            } else {
                                cmdstate = CST_IDLE;
                            }
                        } else if ( inbyte == instaddr ) {
                            numargs = 15;
                            cmdstate = CST_ARGS;
                        }
                        break;
                }
                break;

            case CST_ARGS:
                *argptr++ = inbyte;     // isn't that so beautiful?  I love C.

                if ( argptr - args == numargs ) {
                    cmdstate = CST_IDLE;
                    led_action();
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
