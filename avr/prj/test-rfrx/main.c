#include "config.h"

#include "dbgled.h"
#include "nrf.h"

uint8_t instrument_addr[COM_ADSIZE];

uint8_t volatile txbuf[COM_PL_SIZE];
uint8_t volatile rxbuf[COM_PL_SIZE];

/* Main Loop */
int main(void) {
    uint8_t i;

    dbg_init();
    dbg_set(0x9);

    nrf_init(0x05, instrument_addr, txbuf, rxbuf);
    nrf_enable_irq();

    nrf_start_receiver();

    while(1) {
        nrf_wait_for_rxpacket();
        for ( i=0 ; i<10 ; i++ ) {
            dbg_set(rxbuf[i]);
            delay_ms(200);
        }
    }
}
