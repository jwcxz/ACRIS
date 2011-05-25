/*
 * uart ring buffer layer
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "uart.h"
#include "uart_rb.h"

volatile uint8_t uart_rxbuf[UART_RX_BUFSZ];
volatile uint8_t uart_txbuf[UART_TX_BUFSZ];

volatile uint8_t *uart_rxbuf_iptr = uart_rxbuf;
volatile uint8_t *uart_rxbuf_optr = uart_rxbuf;
volatile uint8_t uart_rxbuf_count = 0;

volatile uint8_t *uart_txbuf_iptr = uart_txbuf;
volatile uint8_t *uart_txbuf_optr = uart_txbuf;
volatile uint8_t uart_txbuf_count = 0;


void uart_rb_init(void) {
    uart_init(&uart_rb_txh, &uart_rb_rxh);
    uart_enable();

    uart_rxbuf_iptr = uart_rxbuf;
    uart_rxbuf_optr = uart_rxbuf;
    uart_rxbuf_count = 0;

    uart_txbuf_iptr = uart_txbuf;
    uart_txbuf_optr = uart_txbuf;
    uart_txbuf_count = 0;
}

uint8_t uart_rb_data_rdy(void) {
    return ( uart_rxbuf_count );
}

uint8_t uart_rb_rx(void) {
    unsigned char tmp;

    // blocking call -- wait until we receive data
    while ( uart_rxbuf_count == 0 );

    UCSR0B &= ~(_BV(RXCIE0) | _BV(RXEN0));

    tmp = *uart_rxbuf_optr;
    uart_rxbuf_count--;

    // increment pointer
    uart_rxbuf_optr++;
    if ( uart_rxbuf_optr >= uart_rxbuf + UART_RX_BUFSZ )
        uart_rxbuf_optr = uart_rxbuf;

    UCSR0B |= (_BV(RXCIE0) | _BV(RXEN0));

    return tmp;
}

void uart_rb_tx(uint8_t data) {
    UCSR0B &= ~(_BV(UDRIE0));

    // blocking call -- wait until transmit buffer is no longer full
    while ( uart_txbuf_count == UART_TX_BUFSZ );

    *uart_txbuf_iptr = data;
    uart_txbuf_count++;

    // increment pointer
    uart_txbuf_iptr++;
    if ( uart_txbuf_iptr >= uart_txbuf + UART_TX_BUFSZ )
        uart_txbuf_iptr = uart_txbuf;

    // enable interrupts
    UCSR0B |= _BV(UDRIE0);
}


void uart_rb_rxh(uint8_t data) {
    if ( uart_rxbuf_count <= UART_RX_BUFSZ ) {
        *uart_rxbuf_iptr = data;
        uart_rxbuf_count++;

        uart_rxbuf_iptr++;
        if ( uart_rxbuf_iptr >= uart_rxbuf + UART_RX_BUFSZ )
            uart_rxbuf_iptr = uart_rxbuf;
    }
}

void uart_rb_txh(void) {
    uint8_t data;

    data = *uart_txbuf_optr;
    uart_txbuf_count--;

    uart_txbuf_optr++;
    if ( uart_txbuf_optr >= uart_txbuf + UART_TX_BUFSZ )
        uart_txbuf_optr = uart_txbuf;

    UDR0 = data;

    // if we're out of things to send, disable the interrupt until more data is
    // added to the buffer
    if (!uart_txbuf_count) {
        UCSR0B &= ~(_BV(UDRIE0));
    }
}
