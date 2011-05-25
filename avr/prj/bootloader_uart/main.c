#include "config.h"

#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include <avr/boot.h>
#include <avr/eeprom.h>

#include "main.h"
#include "flash.h"
#include "eeprom.h"
#include "dbg.h"
#include "uart.h"

#include "uart_rb.h"

// current command state
static cst_type_t curstate = CST_IDLE;

// page buffer
static uint8_t page_buf[PAGESIZE];
static uint8_t *page_buf_ptr;
static uint16_t page_addr;

// instrument address
uint8_t my_addr;

// application start function
void (*app_start)(void) = 0x0000;

/* Main Loop */
int main(void) {
    MCUCR = (1<<IVCE);
    MCUCR = (1<<IVSEL);

    dbg_init();
    dbg_set(0x9);

    my_addr = addr_get();

    uart_rb_init();

    sei();

    // wait just a bit to get some data
    _delay_ms(500);

    // switch to application mode if there's no data on the UART
    if ( !uart_rb_data_rdy() ) {
        cli();
        MCUCR = (1<<IVCE);
        MCUCR = 0;
        app_start();
    } else if ( uart_rb_rx() != CMD_NOP ) {
        cli();
        MCUCR = (1<<IVCE);
        MCUCR = 0;
        app_start();
    } else {
        // otherwise, go into receive data loop
        receive_data();
    }

    return 0;
}

/* Loop, waiting for data */
void receive_data(void) {
    while (1) {
        if ( uart_rb_data_rdy() ) process_rx();
    }
}

/* Processed a received byte */
void process_rx(void) {
    uint8_t data, i;
    uint8_t csum = 0;
    data = uart_rb_rx();

    switch (curstate) {
        case CST_IDLE:
            if ( data == CMD_SYNC ) curstate = CST_SYNC;
            else curstate = CST_IDLE;
            break;
        case CST_SYNC:
            if ( data == CMD_NOP ) curstate = CST_IDLE;
            else if ( data == CMD_SYNC ) curstate = CST_SYNC;
            else {
                switch (data) {
                    case CMD_BOOT:
                        cli();
                        boot_rww_enable_safe();
                        MCUCR = (1<<IVCE);
                        MCUCR = 0;
                        app_start();
                        curstate = CST_IDLE;
                        break;

                    case CMD_DISP_ADDR_H:
                        dbg_set(my_addr>>4);
                        curstate = CST_IDLE;
                        break;
                    case CMD_DISP_ADDR_L:
                        dbg_set(my_addr&0x0F);
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
            break;

        case CST_ADDR:
            addr_set(data);
            curstate = CST_IDLE;
            my_addr = addr_get();
            break;

        case CST_BAUD_H:
            curstate = CST_BAUD_L;
            break;
        case CST_BAUD_L:
            curstate = CST_BAUD_D;
            break;
        case CST_BAUD_D:
            // TODO: save some space by always setting double to 1
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
                flash_write_page(page_addr, page_buf);
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
        // set LEDs to "very bad"
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
        // set LEDs to "slightly bad"
        dbg_set(0x9);
    }

    // return to waiting for data
    curstate = CST_IDLE;    // reset state machine
    receive_data();
}

/* Get and set the single-byte instrument address */
uint8_t addr_get(void) {
    eeprom_busy_wait();
    return eeprom_read_byte(EEPROM_INST_ADDR);

}
void addr_set(uint8_t address) {
    eeprom_busy_wait();
    eeprom_write_byte(EEPROM_INST_ADDR, address);
}
