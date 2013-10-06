
#include "config.h"

#include "dbgled.h"
#include "nrf.h"

uint8_t instrument_addr[COM_ADSIZE];

uint8_t txbuf[COM_PL_SIZE];
uint8_t rxbuf[COM_PL_SIZE];

/* Main Loop */
int main(void) {
    dbg_init();
    dbg_set(0x9);

    nrf_init(0x05, instrument_addr, txbuf, rxbuf);

    while(1) {
        nrf_wait_for_packet();
        dbg_set(rxbuf[0]);
    }
}
