/*
 * super simple interface for setting up interrupt-based UART interactions
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "uart.h"


void (*tx_handler)(void) = 0;
void (*rx_handler)(uint8_t) = 0;


void uart_init(void (*txh)(void), void (*rxh)(uint8_t)) {
	UBRR0 = UART_PRESCALER;

    UCSR0A = ( UART_DBL << U2X0 );
	UCSR0C = ( _BV(UCSZ01) | _BV(UCSZ00) );

    UCSR0C |= UART_PARITY;

    UCSR0B = 0;

    tx_handler = txh;
    rx_handler = rxh;

    if (tx_handler) {
        UART_TX_DDR |= 1<<UART_TX_PIN;
    }
}


void uart_enable(void) {
    if (tx_handler) {
        UCSR0B |= ( _BV(UDRIE0) | _BV(TXEN0) );
    }

    if (rx_handler) {
        UCSR0B |= ( _BV(RXCIE0) | _BV(RXEN0) );
    }
}


void uart_disable(void) {
    UCSR0B &= ~( _BV(UDRIE0) | _BV(TXEN0) | _BV(RXCIE0) | _BV(RXEN0) );
}


ISR(USART_RX_vect) {
	uint8_t byte;

    // check for framing errors, overrun errors, and parity errors
    // reset the uart if necessary
    if ( UCSR0A & (_BV(FE0) | _BV(DOR0) | _BV(UPE0)) ) {
        UCSR0B &= ~(_BV(RXCIE0) | _BV(RXEN0));
        UCSR0B |=  (_BV(RXCIE0) | _BV(RXEN0));
    } else {
        byte = UDR0;
        rx_handler(byte);
    }
}

ISR(USART_UDRE_vect) {
    tx_handler();
}
