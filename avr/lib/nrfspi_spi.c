/*
 * SPI i/f for NRF24L01+
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "nrfspi.h"


void nrfspi_init(void) {
    // NRF24L01+ accepts a maximum baud rate of 10mbps and is mode '00' with MSB first

    // set up the pins
    _ON(NRF_CSN_DDR, NRF_CSN_PIN);
    _ON(NRF_SCLK_DDR, NRF_SCLK_PIN);
    _ON(NRF_MOSI_DDR, NRF_MOSI_PIN);
    _OFF(NRF_MISO_DDR, NRF_MISO_PIN);

    // enable spi in master
    SPCR = _BV(MSTR);
}


void nrfspi_enable(void) {
    _ON(SPCR, SPE);
}


void nrfspi_disable(void) {
    _OFF(SPCR, SPE);
}


uint8_t nrfspi_txrx(uint8_t len, uint8_t *txbuf, uint8_t *rxbuf) {
    uint8_t count, tmp;

    _OFF(NRF_CSN_PRT, NRF_CSN_PIN);

    if (rxbuf) {
        // transmit and read
        while (len--) {
            SPDR = *(txbuf++);
            while (SPSR & _BV(SPIF));
            *(rxbuf++) = SPDR;

            count++;
        }
    } else {
        // just transmit
        // TODO: for real SPI, there's no buffer, so reading the byte probably
        // isn't necessary
        while (len--) {
            SPDR = *(txbuf++);
            while (SPSR & _BV(SPIF));
            tmp = SPDR;

            count++;
        }
    }

    _ON(NRF_CSN_PRT, NRF_CSN_PIN);

    return count;
}


uint8_t nrfspi_txrx_byte(uint8_t data) {
    uint8_t ret;

    _OFF(NRF_CSN_PRT, NRF_CSN_PIN);

    SPDR = data;
    while (SPSR & _BV(SPIF));
    ret = SPDR;

    _ON(NRF_CSN_PRT, NRF_CSN_PIN);

    return ret;
}
