/*
 * Wireless TX/RX Test
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "dbg.h"
#include "nrf.h"

#include "uart.h"
#include "uart_rb.h"
#include "uart_printf.h"

#include "stdio.h"


#ifdef NRF_FN_TX
uint8_t my_addr[COM_AD_SIZE] = TX_ADDR;
uint8_t tx_addr[COM_AD_SIZE] = RX_ADDR;
#else
uint8_t my_addr[COM_AD_SIZE] = RX_ADDR;
#endif

uint8_t txbuf[COM_PL_SIZE];
uint8_t rxbuf[COM_PL_SIZE];

int main(void) {
    uint8_t i, j;

    dbg_init();
    dbg_set(0x6);

    uart_rb_init();
    uart_printf_init();

    // wait more than the maximum startup time before trying to start the
    // NRF interface up
    _delay_ms(120);
    nrf_init(0x05, my_addr, txbuf, rxbuf);

    sei();

#ifdef NRF_FN_TX
    for ( i=0 ; i<COM_PL_SIZE ; i++ ) {
        txbuf[i] = i;
    }

    while(1) {
        nrf_transmit_packet(tx_addr, txbuf);

        for ( i=0 ; i<COM_PL_SIZE ; i++ ) {
            txbuf[i] = txbuf[i] + 1;
        }

        dbg_set(j++);
        _delay_ms(20);
    }
#else
    nrf_start_receiver();

    while(1) {
        nrf_wait_for_rxpacket();

        for ( i=0 ; i<COM_PL_SIZE ; i++ ) {
            printf("%x ", rxbuf[i]);
        }

        printf("\n");

        nrf_accept_packet();
        dbg_set(j++);
    }
#endif
}
