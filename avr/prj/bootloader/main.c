#include "config.h"

#include <avr/boot.h>
#include <string.h>

#include "main.h"
#include "flash.h"
#include "eeprom.h"
#include "dbg.h"
#include "nrf.h"

// current command state
static cst_type_t curstate = CST_IDLE;

// page buffer
static uint8_t page_buf[PAGESIZE];
static uint8_t *page_buf_ptr;
static uint16_t page_addr;

// NRF configuration
uint8_t addr[COM_AD_SIZE];
uint8_t chan[1];

uint8_t txbuf[COM_PL_SIZE];
uint8_t rxbuf[COM_PL_SIZE];

// application start function
void (*app_start)(void) = 0x0000;

/* Main Loop */
int main(void) {
    MCUCR = (1<<IVCE);
    MCUCR = (1<<IVSEL);

    dbg_init();
    dbg_set(0x9);

    eeprom_get_addr(addr);
    eeprom_get_chan(chan);

    nrf_init(*chan, addr, txbuf, rxbuf);

    sei();

    nrf_start_receiver();

    // wait just a bit to get some data
    _delay_ms(500);

    // check if a packet has been received.  if not, start the app
    // if the packet is not the bootloader hold sequence, go to the app as well
    if ( !(nrf_isready_packet()) ) {
        cli();
        MCUCR = (1<<IVCE);
        MCUCR = 0;
        app_start();
    } else if ( rxbuf[0] == CMD_HOLD_SEQ0 && rxbuf[1] == CMD_HOLD_SEQ1 ) {
        // otherwise, go into receive data loop
        receive_data();
    } else {
        // didn't receive the hold sequence -- go to app
        cli();
        nrf_accept_packet();
        MCUCR = (1<<IVCE);
        MCUCR = 0;
        app_start();
    }

    return 0;
}

/* Loop, waiting for data */
void receive_data(void) {
    while (1) {
        nrf_accept_packet();

        nrf_wait_for_rxpacket();

        process_packet();
    }
}

/* Processed a received byte */
void process_packet(void) {
    uint8_t i;
    //uint8_t csum = 0;
    uint16_t page_buf_len = 0;

    uint8_t cmd = rxbuf[0];
    uint8_t *args = &(rxbuf[1]);

    switch (curstate) {
        case CST_IDLE:
            switch (cmd) {
                case CMD_BOOT:
                    cli();
                    nrf_accept_packet();
                    boot_rww_enable_safe();
                    MCUCR = (1<<IVCE);
                    MCUCR = 0;
                    app_start();
                    curstate = CST_IDLE;
                    break;

                case CMD_ADDR_SET:
                    for ( i=0 ; i<COM_AD_SIZE; i++ ) {
                        addr[i] = args[i];
                    }

                    eeprom_write(EEPROM_INST_ADDR, 3, addr);
                    // TODO: reset the receiver to handle new address
                    //nrf_set_rxaddr(addr);
                    
                case CMD_ADDR_DISP:
                    if (args[0] == 1) {
                        dbg_set(addr[args[0]]>>4);
                    } else {
                        dbg_set(addr[args[0]]&0xF);
                    }
                    curstate = CST_IDLE;
                    break;

                case CMD_PROG_STRT:
                    page_addr = (((uint16_t) args[0]) << 8) | (args[1]);
                    page_buf_ptr = page_buf;
                    curstate = CST_PROG_RECV;
                    break;

                case CMD_FNSH:
                    boot_rww_enable_safe();
                    curstate = CST_IDLE;
                    break;

                case CMD_PROG_CONT:

                default:
                    curstate = CST_IDLE;
                    break;
            }
            break;

        case CST_PROG_RECV:
            if (cmd != CMD_PROG_CONT) {
                // received a wrong command... probably meaning corrupted firmware
                give_up(1);
            }

            page_buf_len = page_buf_ptr - page_buf;

            if ( page_buf_len + (COM_PL_SIZE-1) <= PAGESIZE ) {
                // buffer is full of programming info
                memcpy(page_buf_ptr, args, COM_PL_SIZE-1);
                // increment the pointer
                page_buf_ptr = &(page_buf_ptr[COM_PL_SIZE-1]);
                page_buf_len += COM_PL_SIZE-1;
            } else {
                // received the rest of the packet
                memcpy(page_buf_ptr, rxbuf, PAGESIZE - page_buf_len);
                page_buf_ptr = &(page_buf_ptr[PAGESIZE - page_buf_len]);
                page_buf_len += PAGESIZE - page_buf_len;
            }

            if ( page_buf_len == PAGESIZE ) {
                // proceed to read checksum
                curstate = CST_PROG_VRFY;
            } else {
                curstate = CST_PROG_RECV;
            }

            break;

        case CST_PROG_VRFY:
            // TODO: write a checksumming algo, maybe a COM_PL_SIZE-xored stream?
            if ( 1 ) {
                // checksum verifies, so write the page
                flash_write_page(page_addr, page_buf);
            } else {
                // damnit...
                // TODO: we can be slightly smarter (if it's the first address,
                // we technically haven't corrupted anything yet)
                give_up(1);
            }

            curstate = CST_IDLE;
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
