/*
 * SPI Mode USART i/f for NRF24L01+
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "nrfspi.h"


void nrfspi_init(void) {
    // NRF24L01+ accepts a maximum baud rate of 10mbps and is mode '00' with MSB first

    // set up the pins
    _ON(NRF_CSN_PRT, NRF_CSN_PIN);
    _ON(NRF_CSN_DDR, NRF_CSN_PIN);
    _ON(NRF_SCLK_DDR, NRF_SCLK_PIN);
    _ON(NRF_MOSI_DDR, NRF_MOSI_PIN);
    _OFF(NRF_MISO_DDR, NRF_MISO_PIN);

    // enable transmit and receive interrupts
    // TODO: enable interrupt mode? [if it turns out that reading a packet
    //       wastes too much time]
    //UCSR0B = ( _BV(RXCIE0) | _BV(TXCIE0) );

    // enable master spi mode, set MSB-first, mode '00'
    UCSR0C = ( _BV(UMSEL01) | _BV(UMSEL00) );
}


void nrfspi_enable(void) {
    // baud rate must be set after transmitter is enabled, but before transmitting
    UBRR0 = 0;

    UCSR0B |= ( _BV(RXEN0) | _BV(TXEN0) );
    _ON(NRF_SCLK_DDR, NRF_SCLK_PIN);

    UBRR0 = NRF_PRESCALER;
}


void nrfspi_disable(void) {
    UCSR0B &= ~( _BV(RXEN0) | _BV(TXEN0) );
}


uint8_t nrfspi_txrx(uint8_t len, uint8_t *txbuf, uint8_t *rxbuf) {
    // UDR must be read for each byte transmitted
    uint8_t count = 0;
    uint8_t tmp;

    if (rxbuf) {
        // transmit and read
        while (len--) {
            while ( !(UCSR0A & _BV(UDRE0)) );
            UDR0 = *(txbuf++);

            while ( !(UCSR0A & _BV(RXC0)) );
            *(rxbuf++) = UDR0;

            count++;
        }
    } else {
        // just transmit
        while (len--) {
            while ( !(UCSR0A & _BV(UDRE0)) );

            UDR0 = *(txbuf++);

            while ( !(UCSR0A & _BV(RXC0)) );
            tmp = UDR0;

            count++;
        }
        tmp = tmp;
    }

    return count;
}


uint8_t nrfspi_txrx_byte(uint8_t data) {
    uint8_t ret;

    while ( !(UCSR0A & _BV(UDRE0)) );
    UDR0 = data;

    while ( !(UCSR0A & _BV(RXC0)) );
    ret = UDR0;

    return ret;
}


__inline void nrfspi_cs_en(void) {
    _OFF(NRF_CSN_PRT, NRF_CSN_PIN);
}

__inline void nrfspi_cs_ds(void) {
    _ON(NRF_CSN_PRT, NRF_CSN_PIN);
}
