#ifndef _PINS_H_
#define _PINS_H_

    // UART control
#define WEN_PRT  PORTD
#define WEN_PIN  PD2
#define WEN_DDR  DDRD

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
#define GSCLK_PIN   PB0
#define XLAT_PIN    PB1
#define BLANK_PIN   PB2
#define TLCTRL_PRT  PORTB
#define TLCTRL_DDR  DDRB

    // TLC error
#define XERR1_PIN   PD5
#define XERR2_PIN   PD6
#define XERR3_PIN   PD7
#define XERR_PRT    PORTD
#define XERR_DDR    DDRD

    // remaining pins: PB4, PC4, PC5, PD3, PD4

#endif
