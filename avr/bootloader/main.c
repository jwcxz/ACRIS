/* A C R I S   P R O J E C T        *
 * LED Controller Bootloader        *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo - http://jwcxz.com/  *
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
                    curstate = SM_BAUD;
                    break;
                case CMD_PROG:
                    curstate = SM_PROG;
                    break;
                default:
                    curstate = SM_IDLE;
            }
        case SM_ADDR:
            addr_set(data);
            curstate = SM_IDLE;
            break;
        case SM_BAUD:
            baud_h = data;
            curstate = SM_BAUD2;
            break;
        case SM_BAUD2
            baud_l = data;
            curstate = SM_BAUD3;
            break;
        case SM_BAUD3:
            baud_d = data;
            curstate = SM_IDLE;
            break;
        case SM_PROG:
            // TODO
            *pagebuf++ = data;
            break;
        default:
            curstate = SM_IDLE;
            break;
    }
}

/* Reached an unrecoverable error, so:
 *  - Light up the LEDs in the pattern "1001" indicating an error
 *  - If corrupted, then write 0xFF to the first page in order to prevent the
 *    bootloader from trying to run the application at the beginning.
 *  - Go back and wait for new data.
 */
void give_up(uint8_t corrupted) {
    // set LED's to "shit hit the fan"
    led_set(0x9);

    // if application data was corrupted, fill the first page with 0xFF
    if (corrupted) {
    }

    // return to waiting for data
    receive_data();
}
