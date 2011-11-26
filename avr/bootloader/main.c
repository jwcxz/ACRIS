/* A C R I S   P R O J E C T ********
 * LED Controller Bootloader        *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo -- http://jwcxz.com/ *
 *                                  *
 * Main bootloader source file      *
 ************************************/

#include "main.h"
#include "eeprom.h"
#include "dbgled.h"
#include "uart.h"

// uart buffer
volatile uint8_t uart_rxbuf[UART_RX_BUFSZ];
volatile uint8_t *uart_rxbuf_iptr = uart_rxbuf;
volatile uint8_t *uart_rxbuf_optr = uart_rxbuf;
volatile uint8_t uart_rxbuf_count = 0;
volatile uint8_t rxen = 1;

// current command state
static uint8_t curstate = CST_IDLE;

// page buffer
static uint8_t page_buf[PAGESIZE];
static uint8_t *page_buf_ptr;
static uint16_t page_addr;

// instrument address
uint8_t instaddr;

// baud rate divisor
static uint16_t baud;

// device address mask
static uint8_t mask = AM_ALL;

/* Main Loop */
int main(void) {
    MCUCR = (1<<IVCE);
    MCUCR = (1<<IVSEL);

    dbg_init();
    dbg_set(0x9);

    instaddr = get_addr();

    // set rs485 tristate to "read"
    UARTWR_DDR |= _BV(UARTWR_PIN);
    _OFF(UARTWR_PRT, UARTWR_PIN);
    // set up uart for 9600 baud communication with no parity
	UBRR0H = (uint8_t) (DEF_BAUD_PRESCALE_SLOW>>8);
	UBRR0L = (uint8_t) DEF_BAUD_PRESCALE_SLOW;
    UCSR0A = ( DEF_BAUD_DOUBLE_SLOW<<U2X0 );
	UCSR0B = ( _BV(RXCIE0) | _BV(RXEN0) );
	UCSR0C = ( _BV(UCSZ01) | _BV(UCSZ00) );

    // reset the pointers and buffer count
	uart_rxbuf_iptr = uart_rxbuf;
	uart_rxbuf_optr = uart_rxbuf;
    uart_rxbuf_count = 0;

    sei();

    // wait just a bit to get some data
    _delay_ms(500);

    // switch to application mode if there's no data on the UART
    if ( !uart_data_rdy() ) {
        cli();
        MCUCR = (1<<IVCE);
        MCUCR = 0;
        asm("jmp 0000");
    } else if ( uart_rx() != CMD_NOP ) {
        cli();
        MCUCR = (1<<IVCE);
        MCUCR = 0;
        asm("jmp 0000");
    } else {
        // otherwise, go into receive data loop
        receive_data();
    }

    return 0;
}

/* Loop, waiting for data */
void receive_data(void) {
    while (1) {
        if ( uart_data_rdy() ) process_rx();
    }
}

/* Processed a received byte */
void process_rx(void) {
    uint8_t data, i;
    uint8_t csum = 0;
    data = uart_rx();

    switch (curstate) {
        case CST_IDLE:
            if ( data == CMD_SYNC ) curstate = CST_SYNC;
            else curstate = CST_IDLE;
            break;
        case CST_SYNC:
            if ( data == CMD_NOP ) curstate = CST_IDLE;
            else if ( data == CMD_SYNC ) curstate = CST_SYNC;
                // if we get a mask request, then always honor it
            else if ( data == CMD_MASK ) curstate = CST_MASK;
            else if ( applies_to_me() ) {
                switch (data) {
                    case CMD_BOOT:
                        cli();
                        boot_rww_enable_safe();
                        MCUCR = (1<<IVCE);
                        MCUCR = 0;
                        asm("jmp 0000");
                        curstate = CST_IDLE;
                        break;
                        
                    case CMD_DISP_ADDR_H:
                        dbg_set(instaddr>>4);
                        curstate = CST_IDLE;
                        break;
                    case CMD_DISP_ADDR_L:
                        dbg_set(instaddr&0x0F);
                        curstate = CST_IDLE;
                        break;

                    case CMD_ADDR:
                        curstate = CST_ADDR;
                        break;

                    case CMD_BAUD:
                        curstate = CST_BAUD_H;
                        break;

                    case CMD_PROG:
                        curstate = CST_PROG_A_H;
                        break;

                    case CMD_FNSH:
                        boot_rww_enable_safe();
                        curstate = CST_IDLE;
                        break;

                    default:
                        curstate = CST_IDLE;
                        break;
                }
            } 
            // otherwise, no action applied to me, so wait for the next
            // packet (maybe it'll be a new mask)
            else curstate = CST_IDLE;
            break;

        case CST_MASK:
            mask = data;
            curstate = CST_IDLE;
            break;

        case CST_ADDR:
            addr_set(data);
            curstate = CST_IDLE;
            instaddr = get_addr();
            break;

        case CST_BAUD_H:
            baud = (data << 8);   // high byte of baud rate
            curstate = CST_BAUD_L;
            break;
        case CST_BAUD_L:
            baud |= data;         // low byte of baud rate
            curstate = CST_BAUD_D;
            break;
        case CST_BAUD_D:
            // TODO: save some space by always setting double to 1
            baud_set(data);
            curstate = CST_IDLE;
            break;

        case CST_PROG_A_H:
            dbg_set(data);
            page_addr = data << 8;
            // reset page buffer pointer
            page_buf_ptr = page_buf;
            curstate = CST_PROG_A_L;
            break;
        case CST_PROG_A_L:
            //dbg_set(data);    // not useful
            page_addr |= data;
            curstate = CST_PROG_D;
            break;
        case CST_PROG_D:
            *(page_buf_ptr++) = data;
            if ( page_buf_ptr - page_buf == PAGESIZE ) {
                // we hit the last byte of the page, so the next byte is the
                // checksum
                curstate = CST_PROG_V;
            } else {
                curstate = CST_PROG_D;
            }
            break;
        case CST_PROG_V:
            curstate = CST_IDLE;

            for ( i=0 ; i<PAGESIZE ; i++ ) {
                csum += page_buf[i];
            }
            csum = ~csum;

            if ( csum == data ) {
                // checksum verifies, so write the page
                write_page();
            } else {
                // damnit...
                // TODO: we can be slightly smarter (if it's the first address,
                // we technically haven't corrupted anything yet)
                give_up(1);
            }
            dbg_on(0x3);
            break;

        default:
            curstate = CST_IDLE;
            break;
    }
}

/* Reached an unrecoverable error, so:
 *  - Light up the LEDs indicating an error
 *  - If corrupted, then write 0xFF to the first page in order to prevent the
 *    bootloader from trying to run the application at the beginning.
 *  - Go back and wait for new data.
 */
void give_up(uint8_t corrupted) {
    uint16_t i;
    if (corrupted) {
        // set LEDs to "shit really hit the fan"
        dbg_set(0xA);

        // fill the first page with 0xFF
        for ( i=0 ; i<PAGESIZE ; i+=2 ) {
            boot_page_fill_safe(i, 0xFFFF);
        }
        boot_page_write_safe(0);
        boot_spm_busy_wait();

        // halt
        while(1);
    } else {
        // set LEDs to "shit slightly hit the fan"
        dbg_set(0x9);
    }

    // return to waiting for data
    curstate = CST_IDLE;    // reset state machine
    receive_data();
}

/* Set the instrument address */
void addr_set(uint8_t address) {
    // TODO: maybe move this to the generic eeprom.h file?  I didn't because
    // the main code doesn't use it (yet?), so it's just wasted space (or does
    // it get optimized out?).

    // wait for eeprom to become ready
    eeprom_busy_wait();

    // write address to the address byte
    eeprom_write_byte(EEPROM_INST_ADDR, address);
}

/* Set the application communication baud rate */
void baud_set(uint8_t dbl) {
    eeprom_busy_wait();
    eeprom_write_word(EEPROM_BAUD_RATE, baud);
    eeprom_busy_wait();
    eeprom_write_byte(EEPROM_BAUD_DBLE, dbl);
}

/* Write a page of data from the page buffer */
void write_page(void) {
    uint16_t i,w;
    uint8_t sreg;

    // disable interrupts
    sreg = SREG;
    cli();

    boot_page_erase_safe(page_addr);
    boot_spm_busy_wait();

    page_buf_ptr = page_buf;
    for ( i=0 ; i<PAGESIZE ; i+=2 ) {
        // make word
        w = *page_buf_ptr++;
        w |= (*page_buf_ptr++)<<8;

        boot_page_fill_safe(page_addr+i, w);
    }

    boot_page_write_safe(page_addr);
    boot_spm_busy_wait();

    // re-enable interrupts
    SREG = sreg;
}

/* Check to see if the mask applies to this instrument */
uint8_t applies_to_me(void) {
    if ( instaddr == 0xFF ) {
        // eeprom address hasn't been set yet, so listen to everything
        return 1;
    } else if ( mask == AM_ALL ) {
        // 0xFF = all addresses
        return 1;
    } else if ( instaddr == mask ) {
        // we specifically targeted this device
        return 1;
    } else if ( mask >= 0xF0 && ( instaddr >= (mask&0x0F)*16 && 
                instaddr <= (mask&0x0F)*16+15 ) ) {
        // the devices matches in block mode
        return 1;
    } else {
        return 0;
    }
}
