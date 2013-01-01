/* A C R I S   P R O J E C T ********
 * LED Controller                   *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo -- http://jwcxz.com/ *
 *                                  *
 * constants configuration          *
 ************************************/

#define SYSCLK 20000000UL
#define F_CPU 20000000UL

#define EEPROM_INST_ADDR (uint8_t*)  1
#define EEPROM_BAUD_DBLE (uint8_t*)  2
#define EEPROM_BAUD_RATE (uint16_t*) 3

// uart baud rate prescale (if nothing found on the EEPROM)
#define DEF_BAUD_PRESCALE 64    // 38400
#define DEF_BAUD_DOUBLE 1
#define DEF_BAUD_PRESCALE_SLOW 129    // 9600
#define DEF_BAUD_DOUBLE_SLOW 0

// set the speed of the latch pulse
#define XLATPD      1

/* PINS */                  // AVR  TLC
#define SDAT_PIN    PB3     //  17   26
#define SDAT_PRT    PORTB
#define SDAT_DDR    DDRB

#define SCLK_PIN    PB5     //  19   25
#define SCLK_PRT    PORTB
#define SCLK_DDR    DDRB

// SS isn't used, but needs to be configured as an output
#define SDSS_PIN    PB2     //  16
#define SDSS_PRT    PORTB
#define SDSS_DDR    DDRB

#define XLAT_PIN    PB1     //  15   24
#define XLAT_PRT    PORTB
#define XLAT_DDR    DDRB

#define BLANK_PIN   PB2     //  16   23
#define BLANK_PRT   PORTB
#define BLANK_DDR   DDRB

#define GSCLK_PIN   PD3     //   5   18
#define GSCLK_PRT   PORTD
#define GSCLK_DDR   DDRD

#define UARTWR_PRT  PORTD
#define UARTWR_PIN  PD2     // 4
#define UARTWR_DDR  DDRD

#define DBGLED_PRT  PORTC
#define DBGLED_DDR  DDRC

/* UART BUFFER DATA */
#define UART_RX_BUFSZ   128
//#define UART_TX_BUFSZ   128

/* SERIAL COMMANDS */
#define CMD_SYNC    0xAA
#define CMD_DOALL   255

/* DEBUG LIGHTING */
#define DBG_PRTYERR     0x1
#define DBG_OVFLWERR    0x2

// for strobing
//#define STB_PULSE       500UL
