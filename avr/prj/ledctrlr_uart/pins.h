#ifndef __PINS_H_
#define __PINS_H_


// UART communication
#define UART_TX_PIN    PD1
#define UART_TX_PRT    PORTD
#define UART_TX_DDR    DDRD

#define UART_RX_PIN    PD0
#define UART_RX_PRT    PORTD
#define UART_RX_DDR    DDRD


// NRF24L01+ control and data
// IRQ
#define NRF_IRQ_PIN  PD2
#define NRF_IRQ_PRT  PORTD
#define NRF_IRQ_DDR  DDRD

// chip enable
#define NRF_CE_PIN   PB0
#define NRF_CE_PRT   PORTB
#define NRF_CE_DDR   DDRB

// SPI CS_L
#define NRF_CSN_PIN  PC4
#define NRF_CSN_PRT  PORTC
#define NRF_CSN_DDR  DDRC

// MISO
#define NRF_MISO_PIN PD0
#define NRF_MISO_PRT PORTD
#define NRF_MISO_DDR DDRD

// MOSI
#define NRF_MOSI_PIN PD1
#define NRF_MOSI_PRT PORTD
#define NRF_MOSI_DDR DDRD

// SCLK
#define NRF_SCLK_PIN PD4
#define NRF_SCLK_PRT PORTD
#define NRF_SCLK_DDR DDRD


// debug
#define DBGLED_MSK  0x0F
#define DBGLED_PRT  PORTC
#define DBGLED_DDR  DDRC


// TLC data
#define TLC_MOSI_PIN    PB3
#define TLC_SCLK_PIN    PB5
#define TLC_SDSS_PIN    PB2
#define TLC_DATA_PRT    PORTB
#define TLC_DATA_DDR    DDRB


// TLC control
#define TLC_GSCLK_PIN   PD3
#define TLC_GSCLK_PRT   PORTD
#define TLC_GSCLK_DDR   DDRD

#define TLC_XLAT_PIN    PB1
#define TLC_BLANK_PIN   PB2
#define TLC_CTRL_PRT    PORTB
#define TLC_CTRL_DDR    DDRB


// TLC error
#define TLC_XERR1_PIN   PD5
#define TLC_XERR2_PIN   PD6
#define TLC_XERR3_PIN   PD7
#define TLC_XERRS_MSK   (_BV(TLC_XERR1_PIN) | _BV(TLC_XERR2_PIN) | _BV(TLC_XERR3_PIN))
#define TLC_XERR_PIN    PIND
#define TLC_XERR_PRT    PORTD
#define TLC_XERR_DDR    DDRD


#endif
