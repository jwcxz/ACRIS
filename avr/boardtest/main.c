/* A C R I S   P R O J E C T ********
 * LED Controller                   *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo -- http://jwcxz.com/ *
 *                                  *
 * LED board test main loop         *
 ************************************/

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

uint8_t instaddr = 0;

volatile uint8_t tlc[3][24];

uint8_t action;         // current action
uint8_t numargs;        // number of arguments to expect
uint8_t args[15];       // array to store arguments
uint8_t* argptr = args; //   ... associated pointer

/* COMMAND PROCESSOR STATE MACHINE */
#define CST_IDLE    0
#define CST_SYNC    1
#define CST_ARGS    2
static uint8_t cmdstate;

int main(void) {
    // initialize debug LEDs
    dbg_init();

    // get the address of the device
    instaddr = get_addr();

    // set up uart for 9600 baud communication with no parity
	UBRR0H = (uint8_t) (DEF_BAUD_PRESCALE_SLOW>>8);
	UBRR0L = (uint8_t) DEF_BAUD_PRESCALE_SLOW;
    UCSR0A = ( DEF_BAUD_DOUBLE_SLOW<<U2X0 );
	UCSR0B = ( _BV(RXCIE0) | _BV(RXEN0) );
	UCSR0C = ( _BV(UCSZ01) | _BV(UCSZ00) );

    // reset the pointers and buffer count
	uart_rxbuf_iptr = uart_rxbuf;
	uart_rxbuf_optr = uart_rxbuf;
    uart_rxbuf_count = 0;

    // make the debug leds display a pattern 0110
    dbg_set(0x7);

    // enable interrupts
    sei();
    rxen = 1;

    while (1) {
        if ( uart_data_rdy() ) receive_data();
    }

	return 0;
}

void receive_data(void) {
    unsigned char inbyte;

    inbyte = uart_rx();

    //*
    switch (inbyte) {
        case 'a':
        case 'A':
            // address, high nibble
            instaddr = get_addr();
            dbg_set(instaddr>>4);
            break;
        case 'b':
        case 'B':
            // address, low nibble
            instaddr = get_addr();
            dbg_set(instaddr&0x0F);
            break;
        case 'r':
        case 'R':
            // baud rate 15:12
            dbg_set(get_baud()>>12);
            break;
        case 's':
        case 'S':
            // baud rate 11:8
            dbg_set(get_baud()>>8&0x0F);
            break;
        case 't':
        case 'T':
            // baud rate 7:4
            dbg_set(get_baud()>>4&0x0F);
            break;
        case 'u':
        case 'U':
            // baud rate 3:0
            dbg_set(get_baud()&0x0F);
            break;
        case 'v':
        case 'V':
            // baud double
            dbg_set(get_baud_dbl());
            break;

        case 'p':
        case 'P':
            // 0110
            dbg_set(0x6);
            break;
        case 'q':
        case 'Q':
            // 1010
            dbg_set(0xA);
            break;

        case 'x':
        case 'X':
            dbg_set(inbyte);
            // set address to 0x3
            eeprom_busy_wait();
            eeprom_write_byte(EEPROM_INST_ADDR, 0x5);
            break;
        case 'y':
        case 'Y':
            dbg_set(inbyte);
            // set baud rate to 0xA5 and double to 1
            eeprom_busy_wait();
            eeprom_write_byte(EEPROM_BAUD_DBLE, 0x1);
            eeprom_busy_wait();
            eeprom_write_word(EEPROM_BAUD_RATE, 0x69A5);
            break;

        default:
            dbg_set(0x3);
            break;
    }
    // */
}
