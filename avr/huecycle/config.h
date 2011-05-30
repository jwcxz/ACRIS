#define CTRLR_RGB 0
#define CTRLR_UVS 1
#ifndef CTRLR_TYPE
    #define CTRLR_TYPE CTRLR_RGB
    //#define CTRLR_TYPE CTRLR_UVS
#endif

// board fixes
#define FIX0    0
#define FIX1    1
#define FIX3    3
#define FIX5    5
#define FIX9    9
// leave FIXBOARD undefined if you don't want to apply any per-board fixes
#define FIXBOARD FIX5

#define SYSCLK 20000000UL
#define F_CPU 20000000UL

// uart baud rate prescale
//#define USART_BAUDRATE 115200UL
//#define USART_BAUDRATE 9600UL
//#define BAUD_PRESCALE (((F_CPU / (USART_BAUDRATE * 16UL))) - 1) 
// 57600 baud with doubling enabled: 42
#define BAUD_PRESCALE 64    // 38400
//#define BAUD_PRESCALE 42
// use double rate
#define UARTDBL 1

// set the speed of the latch pulse
#define XLATPD      1

// timeout calculations
// we want roughly a 5 second timeout (the timer is clk/1024)
#define TIMEOUT_MAX 8000
#define TIMEOUT_PIXCYCLE 60
#define TIMEOUT_REVDIREC 79

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

#define DIP_PRT     PORTC   // 23:26 -> 4:1
#define DIP_PIN     PINC    // 23:26 -> 4:1
#define DIP_MSK     0xF
#define DIP_SHFT    0
#define DIP_DDR     DDRC

#define UARTWR_PRT  PORTD
#define UARTWR_PIN  PD2     // 4
#define UARTWR_DDR  DDRD


/* UART BUFFER DATA */
#define UART_RX_BUFSZ   128
#define UART_TX_BUFSZ   128

/* SERIAL COMMANDS */
#define CMD_SYNC        0xAA
#define CMD_EMGCY       254
#define CMD_EVOFF       253
#define CMD_FPANL       252
#define CMD_RPANL       251
#define CMD_UVSET       250
#define CMD_WHSET       249
#define CMD_STRBE       248
#define CMD_FDISP       247
#define CMD_RDISP       246
#define CMD_UVSTB       245

// starting address of the rear panels and uv/strobes (front panels have a
// starting address of 0)
#define REAR_MIN        8
#define UVST_MIN        16

#define STB_PULSE       500UL
