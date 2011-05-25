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

    // the chip select line, regardless of whether it's used, must be
    // configured as output or a h->l transition will spuriously set SPIF
    _ON(NRF_CSEL_DDR, NRF_CSEL_PIN);

    // enable spi in master
    SPCR = _BV(MSTR) | _BV(SPR0);

    // set clock rate (currently fixed at fosc/8)
    //SPSR = _BV(SPI2X);
}


void nrfspi_enable(void) {
    _ON(SPCR, SPE);
}

void nrfspi_disable(void) {
    _OFF(SPCR, SPE);
}


uint8_t nrfspi_txrx(uint8_t len, uint8_t *txbuf, uint8_t *rxbuf) {
    uint8_t count = 0;
    uint8_t tmp;

    if (rxbuf) {
        // transmit and read
        while (len--) {
            SPDR = *(txbuf++);
            while ((SPSR & _BV(SPIF)) == 0);
            *(rxbuf++) = SPDR;

            count++;
        }
    } else {
        // just transmit
        while (len--) {
            SPDR = *(txbuf++);
            while ((SPSR & _BV(SPIF)) == 0);
            tmp = SPDR;

            count++;
        }
        tmp=tmp;
    }

    return count;
}


uint8_t nrfspi_txrx_byte(uint8_t data) {
    uint8_t ret;

    SPDR = data;
    while ((SPSR & _BV(SPIF)) == 0);
    ret = SPDR;

    return ret;
}


__inline void nrfspi_cs_en(void) {
    _OFF(NRF_CSN_PRT, NRF_CSN_PIN);
}

__inline void nrfspi_cs_ds(void) {
    _ON(NRF_CSN_PRT, NRF_CSN_PIN);
}
