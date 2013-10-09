/*
 * uart ring buffer layer
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "dbgled.h"
#include "uart.h"
#include "uart_rb.h"

volatile uint8_t uart_rxbuf[UART_RX_BUFSZ];
volatile uint8_t uart_txbuf[UART_TX_BUFSZ];

volatile uint8_t *uart_rxbuf_iptr = uart_rxbuf;
volatile uint8_t *uart_rxbuf_optr = uart_rxbuf;
volatile uint8_t uart_rxbuf_count = 0;
volatile uint8_t uart_rxen = 0;

volatile uint8_t *uart_txbuf_iptr = uart_txbuf;
volatile uint8_t *uart_txbuf_optr = uart_txbuf;
volatile uint8_t uart_txbuf_count = 0;


void uart_rb_init(void) {
    uart_init(&uart_rb_txh, &uart_rb_rxh);
    uart_enable();

	uart_rxbuf_iptr = uart_rxbuf;
	uart_rxbuf_optr = uart_rxbuf;
    uart_rxbuf_count = 0;
    uart_rxen = 0;

	uart_txbuf_iptr = uart_txbuf;
	uart_txbuf_optr = uart_txbuf;
    uart_txbuf_count = 0;
}

uint8_t uart_rb_data_rdy(void) {
	return ( uart_rxbuf_count );
}

uint8_t uart_rb_rx(void) {
	unsigned char tmp;
    cli();
    
    // check for framing errors, overrun errors, and parity errors
    // reset the uart if necessary
    if ( UCSR0A & (_BV(FE0) | _BV(DOR0) | _BV(UPE0)) ) {
        UCSR0B = 0;
        UCSR0B = _BV(RXCIE0) | _BV(RXEN0);
    }

    // blocking call -- wait until we receive data
	while ( uart_rxbuf_count == 0 );

	tmp = *uart_rxbuf_optr;
	uart_rxbuf_count--;

    // increment pointer
	uart_rxbuf_optr++;
	if ( uart_rxbuf_optr >= uart_rxbuf + UART_RX_BUFSZ )
		uart_rxbuf_optr = uart_rxbuf;

    if ( uart_rxen ) {
        // receive is enabled, so enable interrupts
        sei();
    } else if ( uart_rxbuf_count < UART_RX_BUFSZ/2 ) {
        // receive interrupt was disabled, but the buffer has been partially
        // depleted, so we can start accepting data again
        uart_rxen = 1;
        sei();
    }
    
	return tmp;
}

void uart_rb_tx(void) {
}


void uart_rb_rxh(uint8_t data) {
    if ( uart_rxbuf_count <= UART_RX_BUFSZ ) {
        *uart_rxbuf_iptr = data;
        uart_rxbuf_count++;

        uart_rxbuf_iptr++;
        if ( uart_rxbuf_iptr >= uart_rxbuf + UART_RX_BUFSZ )
            uart_rxbuf_iptr = uart_rxbuf;
    } else {
        // buffer overflow!
        // shut interrupts off until we can deplete the buffer a bit
        cli();
        uart_rxen = 0;
    }
}

void uart_rb_txh(void) {
}
