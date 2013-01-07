#include "tlc.h"

__inline__ void pulse_xlat(void) {
    _ON(TLCTRL_PRT, XLAT_PIN);
    _delay_us(XLATPD);
    _OFF(TLCTRL_PRT, XLAT_PIN);
    _delay_us(XLATPD);
}

void tlc_init(void) {
    uint8_t i;

    TLCTRL_DDR |= _BV(XLAT_PIN) | _BV(BLANK_PIN);
    _ON(TLCTRL_PRT, BLANK_PIN);
    _OFF(TLCTRL_PRT, XLAT_PIN);
    
    GSCLK_DDR |= _BV(GSCLK_PIN);

    // SPI initialization
    TLCDATA_DDR |= _BV(MOSI_PIN) | _BV(SCLK_PIN) | _BV(SDSS_PIN);
    _OFF(TLCDATA_PRT, SCLK_PIN);

    //SPSR = _BV(SPI2X);            // double speed SPI
    SPCR = _BV(SPE) | _BV(MSTR);    // enable spi in master
    SPCR |= _BV(SPR1);              // speed register (don't set this too fast)

    // initialize the shift register with all 0s
    for ( i=0 ; i<24*3 ; i++ ) {
        SPDR = 0;
        while ( !(SPSR & _BV(SPIF)) );
    }

    // pulse the latch
    pulse_xlat();

    // BLANK counter hits every 4096 GSCLK cycles
    // mode 8: PWM phase and frequency correct
    TCCR1A = _BV(COM1B1);   // clear 0C1B on compare match when upcounting, set when downcounting
    TCCR1B = _BV(WGM13);    // mode 8
    TCCR1B |= _BV(CS10);    // start timer, clk/1
    OCR1A = 1;              // blank fires 
    OCR1B = 2;
    ICR1 = 18432; // = (GSCLKPD+1)*4096/2

    // GSCLK
    TCCR2A = (_BV(COM2B1) | _BV(WGM21) | _BV(WGM20));
    TCCR2B = _BV(WGM22);
    TCCR2B |= _BV(CS20);
    OCR2A = 9;
    OCR2B = 0;
    
    // if we're on the new board revision, prepare the XERR pins
#if (BRDREV == 2)
    XERR_DDR &= ~(XERRS_MSK);
    // enable pull-up
    XERR_PRT |= XERRS_MSK;
#endif
}

void tlc_drive(void) {
    uint8_t chip, chip1, out;

    for ( chip1=3 ; chip1>0 ; chip1-- ) {
        chip = chip1 - 1;

        for ( out=0 ; out<24 ; out++ ) {
            SPDR = tlc[chip][out];
            while ( !(SPSR & _BV(SPIF)) );
        }
    }

    // pulse the latch
    pulse_xlat();
}

// read error flags
uint8_t tlc_read_xerr(void) {
    // currently will only read thermal overflow
    uint8_t xerr;

#if (BRDREV == 2)
    // TODO: this is dumb and probably won't work
    while (TLCTRL_PRT & _BV(BLANK_PIN));
    
    xerr = XERR_PIN;
    xerr = (xerr & XERRS_MSK) >> XERR1_PIN;
#endif

    return xerr;
}


/* LED ARRAY PACKING FUNCTIONS */
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
