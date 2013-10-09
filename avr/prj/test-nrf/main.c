/*
 * Wireless RX Test
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "dbg.h"
#include "nrf.h"

#ifdef NRF_FN_TX
uint8_t my_addr[COM_AD_SIZE] = TX_ADDR;
uint8_t tx_addr[COM_AD_SIZE] = RX_ADDR;
#else
uint8_t my_addr[COM_AD_SIZE] = RX_ADDR;
#endif

uint8_t txbuf[COM_PL_SIZE];
uint8_t rxbuf[COM_PL_SIZE];

int main(void) {
    uint8_t i;

    dbg_init();

    dbg_set( 0x4 );
    nrf_init(0x05, my_addr, txbuf, rxbuf);

#ifdef NRF_FN_TX
    for ( i=0 ; i<COM_PL_SIZE ; i++ ) {
        txbuf[i] = i & 0xF;
    }

    while(1) {
        nrf_transmit_packet(tx_addr, txbuf);

        for ( i=0 ; i<COM_PL_SIZE ; i++ ) {
            txbuf[i] = (txbuf[i] + 1) & 0xF;
        }

        for ( i=0 ; i<10 ; i++ ) {
            dbg_set(txbuf[i]);
            _delay_ms(200);
        }
    }
#else
    nrf_start_receiver();

    while(1) {
        nrf_wait_for_rxpacket();

        for ( i=0 ; i<10 ; i++ ) {
            dbg_set(rxbuf[i]);
            _delay_ms(50);
        }

        nrf_accept_packet();
    }
#endif
}
