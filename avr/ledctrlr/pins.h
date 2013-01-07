#ifndef _PINS_H_
#define _PINS_H_

    // UART control
#define TXEN_PRT  PORTD
#define TXEN_PIN  PD2
#define TXEN_DDR  DDRD

    // debug
#define DBGLED_MSK  0x0F
#define DBGLED_PRT  PORTC
#define DBGLED_DDR  DDRC

    // TLC data
#define MOSI_PIN    PB3
#define SCLK_PIN    PB5
#define SDSS_PIN    PB2
#define TLCDATA_PRT PORTB
#define TLCDATA_DDR DDRB

    // TLC control
#define GSCLK_PIN   PD3
#define GSCLK_PRT   PORTD
#define GSCLK_DDR   DDRD

#define XLAT_PIN    PB1
#define BLANK_PIN   PB2
#define TLCTRL_PRT  PORTB
#define TLCTRL_DDR  DDRB

    // TLC error
#define XERR1_PIN   PD5
#define XERR2_PIN   PD6
#define XERR3_PIN   PD7
#define XERRS_MSK   (_BV(XERR1_PIN) | _BV(XERR2_PIN) | _BV(XERR3_PIN))
#define XERR_PIN    PIND
#define XERR_PRT    PORTD
#define XERR_DDR    DDRD

    // remaining pins: PB0, PB4, PC4, PC5, PD4

#endif
