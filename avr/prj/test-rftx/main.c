/*
 * Wireless TX Test
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "dbgled.h"
#include "nrf.h"

uint8_t instrument_addr[COM_ADSIZE] = INST_ADDR;

uint8_t target_addr[COM_ADSIZE] = {0xAA, 0xAA, 0x01};

uint8_t volatile txbuf[COM_PL_SIZE];
uint8_t volatile rxbuf[COM_PL_SIZE];

/* Main Loop */
int main(void) {
    uint8_t i;

    dbg_init();
    dbg_set(0x9);

    nrf_init(0x05, instrument_addr, txbuf, rxbuf);
    //nrf_enable_irq();

    for ( i=0 ; i<COM_PL_SIZE ; i++ ) {
        txbuf[i] = i & 0xF;
    }

    while(1) {
        nrf_transmit_packet(target_addr, txbuf);

        for ( i=0 ; i<COM_PL_SIZE ; i++ ) {
            txbuf[i] = (txbuf[i] + 1) & 0xF;
        }

        for ( i=0 ; i<10 ; i++ ) {
            delay_ms(200);
        }
    }
}
