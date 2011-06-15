/* A C R I S   P R O J E C T ********
 * LED Controller Bootloader        *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo -- http://jwcxz.com/ *
 *                                  *
 * Main bootloader source file      *
 ************************************/

/*
 * This bootloader provides the following features:
 *  1. fast startup time (i.e. bootloader->application time)
 *  2. downloading of program to device
 *  3. set address of instrument
 *  4. set the transmission baud rate (via the divisor)
 *  5. program verification
 *
 *  Transmission is done through a serial protocol:
 *  Fn  Args    Description
 *  ___ _______ ____________________________________________________
 *  N   0       NOP -- sent to wake bootloader up
 *  170 0       NOP -- alias for 'N' (send a lot of these to aid in clock recovery)
 *
 *  A   1       Set 1-byte address of the device in EEPROM
 *
 *  B   2       [High][Low][Double?] -- set divisor and U2XN of the UART in EEPROM
 *
 *  P   2       [Addr][Page...] - Send program one page at a time
 *                  To simplify the bootloader, it does NOT take an Intel HEX
 *                  file as an input.  Rather, a special "program" script reads
 *                  the HEX file and outputs the following format:
 *                      [Starting Address][Page][Checksum]
 *                  The checksum is the one's complement of the sum of the
 *                  page stream.
 *
 *                  Note: this means that the stream length depends on the page
 *                  size (whereas Intel HEX files have known lengths).
 *                  Furthermore, it requires that unused bytes be 0-filled or
 *                  something.  I'd rather make the programmer
 *
 *  V   1       [Checksum] Verify whole program against checksum.  If
 *              verification fails, write 0xFF to the program start to prevent
 *              the bootloader from loading the application.
 */

#include "main.h"

// page buffer (gets filled when 
static uint8_t page_buf[PAGESIZE];
static uint8_t* page_buf_ptr;

// baud rate divisor
static uint16_t baud;

/* Main Loop */
int main(void) {

    // set up uart for 9600 baud communication with no parity

    // set up timer to go to application mode if no data has been received

    // go into receive data loop
    receive_data();
}

/* Loop, waiting for data */
void receive_data(void) {
    while (1) {
        if ( uart_data_rdy() ) { process_rx(); }
    }
}

/* Processed a received byte */
void process_rx(void) {
    uint8_t data;
    data = uart_rx();

    switch (curstate) {
        case SM_IDLE:
            switch (data) {
                case CMD_NOP1:
                case CMD_NOP2:
                default:
                    curstate = SM_IDLE;
                    break;
                case CMD_ADDR:
                    curstate = SM_ADDR;
                    break;
                case CMD_BAUD:
                    curstate = SM_BAUD_H;
                    break;
                case CMD_PROG:
                    curstate = SM_PROG_A;
                    break;
                default:
                    curstate = SM_IDLE;
            }
            break;

        case SM_ADDR:
            addr_set(data);
            curstate = SM_IDLE;
            break;

        case SM_BAUD_H:
            baud = (data << 8);   // high byte of baud rate
            curstate = SM_BAUD_L;
            break;
        case SM_BAUD_L:
            baud |= data;         // low byte of baud rate
            curstate = SM_BAUD_D;
            break;
        case SM_BAUD_D:
            // TODO: save some space by always setting double to 1
            baud_set(data);
            curstate = SM_IDLE;
            break;

        case SM_PROG_A:
            page_addr = data;
            // reset page buffer pointer
            page_buf_ptr = page_buf;
            curstate = SM_PROG_D;
        case SM_PROG_D:
            *page_buf_ptr++ = data;
            if ( page_buf_ptr - page_buf == PAGESIZE ) {
                // we hit the last byte of the page, so the next byte is the
                // checksum
                curstate = SM_PROG_V;
            } else {
                curstate = SM_PROG_D;
            }
            break;
        case SM_PROG_V:
            curstate = SM_IDLE;

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

        default:
            curstate = SM_IDLE;
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
    // if application data was corrupted, fill the first page with 0xFF
    if (corrupted) {
        // set LEDs to "shit really hit the fan"
        led_set(0xA);
        // TODO: fill the first page with 0xFF
    } else {
        // set LEDs to "shit slightly hit the fan"
        led_set(0x9);
    }

    // return to waiting for data
    curstate = SM_IDLE;     // reset state machine
    receive_data();
}

/* Set the instrument address */
void addr_set(uint8_t address) {
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
    
}
