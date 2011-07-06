/* A C R I S   P R O J E C T ********
 * LED Controller                   *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo -- http://jwcxz.com/ *
 *                                  *
 * TLC array modification, control  *
 ************************************/

#include "tlc.h"

void tlc_init(void) {
    XLAT_DDR  |= _BV(XLAT_PIN);
    XLAT_PRT  &= ~_BV(XLAT_PIN);

    BLANK_DDR |= _BV(BLANK_PIN);
    GSCLK_DDR |= _BV(GSCLK_PIN);

    BLANK_PRT |= _BV(BLANK_PIN);

    // SPI initialization
    SDAT_DDR |=  _BV(SDAT_PIN);
    SCLK_DDR |=  _BV(SCLK_PIN);
    SDSS_DDR |=  _BV(SDSS_PIN);
    SCLK_PRT &= ~_BV(SCLK_PIN);

    //SPSR = _BV(SPI2X);            // double speed SPI
    SPCR = _BV(SPE) | _BV(MSTR);    // enable spi in master
    SPCR |= _BV(SPR1);              // speed register (don't set this too fast)

    // BLANK counter hits every 4096 GSCLK cycles
    TCCR1A = _BV(COM1B1);
    TCCR1B = _BV(WGM13);
    TCCR1B |= _BV(CS10);
    OCR1A = 1;
    OCR1B = 2;
    ICR1 = 18432; // = (GSCLKPD+1)*4096/2

    // GSCLK
    TCCR2A = (_BV(COM2B1) | _BV(WGM21) | _BV(WGM20));
    TCCR2B = _BV(WGM22);
    TCCR2B |= _BV(CS20);
    OCR2A = 9;
    OCR2B = 0;
}

void tlc_drive(void) {
    uint8_t chip, chip1, out;

    for ( chip1=3 ; chip1>0 ; chip1-- ) {
        chip = chip1 - 1;

        for ( out=0 ; out<24 ; out++ ) {
            SPDR = tlc[chip][out];
            while ( !(SPSR & _BV(SPIF)) );

            // this is bitbang mode...  I wouldn't recommend it
            /*
            for ( val1=8 ; val1>0 ; val1-- ) {
                val = val1 - 1;

                _OFF(SCLK_PRT, SCLK_PIN);
                _delay_us(SCLKHPD);
                if ( ( tlc[chip][out] >> val ) & 1 ) _ON(SDAT_PRT, SDAT_PIN); else _OFF(SDAT_PRT, SDAT_PIN);
                _delay_us(SCLKHPD);
                _ON(SCLK_PRT, SCLK_PIN);
                _delay_us(SCLKPD);
            }
            // */
        }
    }

    // pulse the latch
    _ON(XLAT_PRT, XLAT_PIN);
    _delay_us(XLATPD);
    _OFF(XLAT_PRT, XLAT_PIN);
    _delay_us(XLATPD);
}

/* HELPER FUNCTIONS */
void set(volatile uint8_t driver[], uint8_t posn, uint16_t value) {
    // store data to the packed driver byte array
    uint8_t idx;

    if ( posn%2 ) {
        // for an odd position number, the base index (index of the full byte)
        // is (23 - 3*odd/2 - 1)
        idx = 22 - ((3*posn)>>1);
        driver[idx] = value >> 4;
        driver[idx+1] = ( (value & 0x00F) << 4 ) | ( driver[idx+1] & 0x0F );
    } else {
        // for an even position number, the base index is (23 - 3*even/2)
        idx = 23 - ((3*posn)>>1);
        driver[idx-1] = ( driver[idx-1] & 0xF0 ) | ( (value >> 8) & 0x00F );
        driver[idx] = value;
    }
}

uint16_t get(volatile uint8_t driver[], uint8_t posn) {
    // get the value of a driver from the byte array
    uint8_t idx;

    if ( posn%2 ) {
        idx = 22 - ((3*posn)>>1);
        return ( ((uint16_t) driver[idx]) << 4 ) | (driver[idx+1] >> 4);
    } else {
        idx = 23 - ((3*posn)>>1);
        return ( ( (uint16_t) (driver[idx-1]) & 0x0F ) << 8 ) | driver[idx];
    }

}

void set_output(uint8_t chan, uint8_t led, uint16_t val) {
    // stupid wrapper function to set LEDs
    uint8_t i;

    for ( i=(led+1) ; i<=3*(led+1) ; i++ ) set(tlc[chan], i, val);
}

// convert 8-bit serial input data into a 12-bit output for the TLC
// and try to preserve the full range of the TLC's control
uint16_t ser2led(uint8_t ser) {
    return (((uint16_t) ser) << 4) | (ser >> 4);
}
