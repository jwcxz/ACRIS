#ifndef __PINS_H_
#define __PINS_H_


#ifdef NRF_TG_BB
// UART communication
#define UART_TX_PIN    PD1
#define UART_TX_PRT    PORTD
#define UART_TX_DDR    DDRD

#define UART_RX_PIN    PD0
#define UART_RX_PRT    PORTD
#define UART_RX_DDR    DDRD
#endif


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

#ifdef NRF_TG_BB

// MISO
#define NRF_MISO_PIN PB4
#define NRF_MISO_PRT PORTB
#define NRF_MISO_DDR DDRB

// MOSI
#define NRF_MOSI_PIN PB3
#define NRF_MOSI_PRT PORTB
#define NRF_MOSI_DDR DDRB

// SCLK
#define NRF_SCLK_PIN PD5
#define NRF_SCLK_PRT PORTB
#define NRF_SCLK_DDR DDRB

#elif defined(NRF_TG_LC)

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

#endif

// SS
#define NRF_CSEL_PIN PB2
#define NRF_CSEL_PRT PORTB
#define NRF_CSEL_DDR DDRB


// debug
#define DBGLED_MSK  0x0F
#define DBGLED_PRT  PORTC
#define DBGLED_DDR  DDRC


#endif
