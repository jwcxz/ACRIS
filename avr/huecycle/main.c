/* Test project for old board setup that cycles through hues */

#include "main.h"

#include "led.h"
#include "timeout.h"
#include "tlc.h"
#include "uart.h"
#include "color.h"

volatile uint8_t uart_rxbuf[UART_RX_BUFSZ];
volatile uint8_t *uart_rxbuf_iptr = uart_rxbuf;
volatile uint8_t *uart_rxbuf_optr = uart_rxbuf;
volatile uint8_t uart_rxbuf_count = 0;
volatile uint8_t rxen = 0;

uint8_t instaddr = 0;

#if (CTRLR_TYPE == CTRLR_RGB)
volatile uint8_t tlc[3][24];
#elif (CTRLR_TYPE == CTRLR_UVS)
volatile uint8_t tlc[2][24];
#endif /* CTRLR_TYPE */

uint8_t action;          // current action
uint8_t numargs;         // number of arguments to expect
uint8_t args[12];        // array to store arguments XXX: the array size
                         // needs to be changed if we ever expect more
                         // than 12 args
uint8_t* argptr = args;  //   associated pointer

uint8_t timed_out;               // 1 when we're in timeout mode
uint8_t to_direc = 1;            // 0 when shifting outward, FF when
                                 // shifting inward

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

    /*
    // initialize UART
    uart_init();

    // initialize timeout counter
    uint32_t to_count = 0;
    timeoutctr_init();
    */

    // device display initialization
    /*
    uint8_t i;
#if (CTRLR_TYPE == CTRLR_RGB)
    // set red startup sequence
    for ( i=1 ; i<=3   ; i++ ) set(tlc[0], i, 0x00F);
    for ( i=4 ; i<=9   ; i++ ) set(tlc[0], i, 0x0F0);
    for ( i=10 ; i<=12 ; i++ ) set(tlc[0], i, 0x00F);
    tlc_drive();
    _delay_ms(100);

    // clear everything
    for ( i=1 ; i<=12  ; i++ ) set(tlc[0], i, 0);
    for ( i=1 ; i<=12  ; i++ ) set(tlc[1], i, 0);
    for ( i=1 ; i<=12  ; i++ ) set(tlc[2], i, 0);

    // set the high bit to be dim green
    for ( i=1 ; i<=3 ; i++ ) set(tlc[1], i, 0xFF);
    
    // display address
    if ( _VAL(instaddr, 0) ) for ( i=10 ; i<=12 ; i++ ) set(tlc[2], i, 0xFF);
    if ( _VAL(instaddr, 1) ) for ( i=7  ; i<=9  ; i++ ) set(tlc[2], i, 0xFF);
    if ( _VAL(instaddr, 2) ) for ( i=4  ; i<=6  ; i++ ) set(tlc[2], i, 0xFF);
    if ( _VAL(instaddr, 3) ) for ( i=1  ; i<=3  ; i++ ) set(tlc[2], i, 0xFF);

    tlc_drive();
#elif (CTRLR_TYPE == CTRLR_UVS)
    // set whites and UVs on
    for ( i=1 ; i<=14  ; i++ ) set(tlc[0], i, 0x007);
    for ( i=1 ; i<=7   ; i++ ) set(tlc[1], i, 0xFFF);
    tlc_drive();
    _delay_ms(100);

    // set everything off
    for ( i=1 ; i<=14  ; i++ ) set(tlc[0], i, 0x000);
    for ( i=1 ; i<=7   ; i++ ) set(tlc[1], i, 0x000);

    // finally, set address
    // display mode: msb makes everything bright, then 3 lsbs are just the
    // three columns
    if ( _VAL(instaddr, 2) ) 
        for ( i=1 ; i<=7   ; i++ ) set(tlc[0], i, 0x7 << _VAL(instaddr, 3));

    if ( _VAL(instaddr, 1) ) 
        for ( i=1 ; i<=7   ; i++ ) set(tlc[1], i, 0xFF << _VAL(instaddr, 3));

    if ( _VAL(instaddr, 0) ) 
        for ( i=8 ; i<=14  ; i++ ) set(tlc[1], i, 0x7 << _VAL(instaddr, 3));

    tlc_drive();
#endif / * CTRLR_TYPE * /
    */

    // enable interrupts
    sei();
    /*
    rxen = 1;
    */

    // hues
    uint8_t hues[4];

    rgb_t rgb;

    hsv_t hsv;
    hsv.s = 0xFF;
    hsv.v = 80;

    uint8_t i;
    // set red startup sequence
    for ( i=1 ; i<=3   ; i++ ) set(tlc[0], i, 0x00F);
    for ( i=4 ; i<=9   ; i++ ) set(tlc[0], i, 0x0F0);
    for ( i=10 ; i<=12 ; i++ ) set(tlc[0], i, 0x00F);
    tlc_drive();
    _delay_ms(100);

    // clear everything
    for ( i=1 ; i<=12  ; i++ ) set(tlc[0], i, 0);
    for ( i=1 ; i<=12  ; i++ ) set(tlc[1], i, 0);
    for ( i=1 ; i<=12  ; i++ ) set(tlc[2], i, 0);
    tlc_drive();

    get_addr();
    while (1) {
        // update hsv values for each light
        for ( i=0 ; i<4 ; i++ ) {
            hues[i] += 1;
        }

        // convert hsv -> rgb and store to the led array
        for ( i=0 ; i<4 ; i++ ) {
            if ( _BV(i) & instaddr ) {
                hsv.h = hues[i];

                hsv2rgb(hsv, &(rgb.r), &(rgb.g), &(rgb.b));

                set(tlc[0], 3*i+0, rgb.r); set(tlc[0], 3*i+1, rgb.r); set(tlc[0], 3*i+2, rgb.r);
                set(tlc[1], 3*i+0, rgb.g); set(tlc[1], 3*i+1, rgb.g); set(tlc[1], 3*i+2, rgb.g);
                set(tlc[2], 3*i+0, rgb.b); set(tlc[2], 3*i+1, rgb.b); set(tlc[2], 3*i+2, rgb.b);
            }
        }

        // drive tlcs
        tlc_drive();

        // wait a bit
        _delay_ms(200);

        /*
        if ( rxen == 0 && uart_rxbuf_count < UART_RX_BUFSZ/2 ) {
            // buffer has been partially depleted, so we can start accepting
            // data again
            rxen = 1;
            sei();
        }
        */

        /*
        if ( uart_data_rdy() ) {
            receive_data();
            
            // reset timeout stuff
            // XXX: put this in the state machine instead so that only valid
            // bytes will actually cancel the timeout counter
            to_count = 0;
            timed_out = 0;
            TCNT0 = 0;
        } else if (timed_out || to_count >= TIMEOUT_MAX) {
            // once timeout mode has been enabled, we switch to using it to
            // keep track of when to shift the pixels down the display and when
            // to reverse the direction of the shift
            // in order to do that, we need one more bit of information telling
            // us that we're in timeout mode
            
            // there is an ongoing problem where the serial dies entirely...
            // I'm working on it, but right now, the idea is that if we reset
            // the uart, that's the most we can do

            // timed_out is a latch to enter the timeout state
            if ( !timed_out ) {
                timed_out = 1; // latch timed_out
                to_count = 0;

                // reset UART
                cli();
                _ON(UARTWR_PRT, UARTWR_PIN);    // maybe this will reset the SN75176B
                                                // this really shouldn't be the
                                                // problem, though
                UCSR0B = 0;                     // also shut the UART off

                _delay_ms(1);

                // start 'er up again
                uart_init();
                sei();

                // finally, initialize the display pattern
                timeout_disp_init();
            }
            
            if (to_count >= TIMEOUT_PIXCYCLE) {
                to_count = 0;
                to_direc = ( to_direc + 1 ) % TIMEOUT_REVDIREC;
                timeout_disp_pixcycle();
            } else {
                to_count++;
            }

            tlc_drive();
        } else if (TCNT0 == 255 && to_count < TIMEOUT_MAX) {
            to_count++;
        }
        */
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
    }else {
        switch (cmdstate) {
            case CST_IDLE:
                cmdstate = CST_IDLE;
                break;
            case CST_SYNC:
                // save command for later processing
                action = inbyte;
                argptr = args;

                switch (inbyte) {
                    case CMD_EMGCY:
                        numargs = 0;
                        cmdstate = CST_IDLE;

                        led_action();
                        break;
                        
                    case CMD_EVOFF:
                        numargs = 0;
                        cmdstate = CST_IDLE;

                        led_action();
                        break;

#if (CTRLR_TYPE == CTRLR_RGB)
                    case CMD_FPANL:
                        if (instaddr < REAR_MIN) {
                            numargs = 3;
                            cmdstate = CST_ARGS;
                        } else {
                            // we're not a front panel, so just go back to the
                            // idle state and wait for a sync
                            cmdstate = CST_IDLE;
                        }
                        break;

                    case CMD_RPANL:
                        if (instaddr >= REAR_MIN) {
                            numargs = 3;
                            cmdstate = CST_ARGS;
                        } else {
                            // we're not a rear panel, so just go back to the
                            // idle state and wait for a sync
                            cmdstate = CST_IDLE;
                        }
                        break;

                    case CMD_FDISP:
                        if (instaddr < REAR_MIN) {
                            numargs = 12;
                            cmdstate = CST_ARGS;
                        } else {
                            // we're not a front panel, so just go back to the
                            // idle state and wait for a sync
                            cmdstate = CST_IDLE;
                        }
                        break;
                        
                    case CMD_RDISP:
                        if (instaddr >= REAR_MIN) {
                            numargs = 12;
                            cmdstate = CST_ARGS;
                        } else {
                            // we're not a rear panel, so just go back to the
                            // idle state and wait for a sync
                            cmdstate = CST_IDLE;
                        }
                        break;
#elif (CTRLR_TYPE == CTRLR_UVS)
                    case CMD_UVSET:
                        numargs = 1;
                        cmdstate = CST_ARGS;
                        break;

                    case CMD_WHSET:
                        numargs = 1;
                        cmdstate = CST_ARGS;
                        break;
#endif /* CTRLR_TYPE */

                    case CMD_STRBE:
                        numargs = 0;
                        cmdstate = CST_IDLE;

                        led_action();
                        break;

                    case CMD_UVSTB:
                        numargs = 0;
                        cmdstate = CST_IDLE;

                        led_action();
                        break;

                    default:
#if (CTRLR_TYPE == CTRLR_RGB)
                        if (inbyte == instaddr) {
                            numargs = 12;
                            cmdstate = CST_ARGS;
                        }
#elif (CTRLR_TYPE == CTRLR_UVS)
                        if (inbyte == UVST_MIN + instaddr) {
                            numargs = 2;
                            cmdstate = CST_ARGS;
                        }
#endif /* CTRLR_TYPE */
                        else {
                            // got some address or action that we don't care
                            // about, so return to the idle state to wait for
                            // another sync
                            cmdstate = CST_IDLE;
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

void get_addr(void) {
    // cheating a little bit -- requires that the dip switches be connected to
    // consecutive port pins
    DIP_DDR &= ~DIP_MSK;
    DIP_PRT |=  DIP_MSK;
    // XXX: wtf...
    _delay_ms(100);
    instaddr = (~(DIP_PIN) & DIP_MSK) >> DIP_SHFT;
}
