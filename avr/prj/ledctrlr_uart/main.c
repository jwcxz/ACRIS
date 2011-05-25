/* A C R I S   P R O J E C T
 * LED Controller Firmware
 * http://jwcxz.com/projects/acris
 * jwc :: jwcxz.com
 */

#include "config.h"

#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include <avr/boot.h>
#include <avr/eeprom.h>

#include "main.h"

#include "dbg.h"
#include "eeprom.h"
#include "led.h"
#include "tlc.h"
#include "uart.h"
#include "uart_rb.h"

uint8_t my_addr_full[3];
uint8_t my_addr;

// TODO: un-extern this
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
    eeprom_get_addr(my_addr_full);
    my_addr = my_addr_full[0];

    // initialize UART
    uart_rb_init();

    // enable interrupts
    sei();

    while (1) {
        if ( uart_rb_data_rdy() ) {
            receive_data();
        }
    }

	return 0;
}

void receive_data(void) {
    unsigned char inbyte;

    inbyte = uart_rb_rx();

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

#if 1
                    led_action(action, args);
#else
                    if (action == CMD_STATS) {
                        // send back system status
                        if (my_addr == args[0]) {
                            uart_tx(tlc_read_xerr());
                        }
                    } else {
                        led_action(action, args);
                    }
#endif

                    cmdstate = CST_IDLE;
                } else {
                    cmdstate = CST_ARGS;
                }
                break;

            default:
                cmdstate = CST_IDLE;
                break;
        }
    }
}
