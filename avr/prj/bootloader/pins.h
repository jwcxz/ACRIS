#ifndef __PINS_H_
#define __PINS_H_


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


#endif
