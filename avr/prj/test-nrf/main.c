/*
 * Wireless TX/RX Test
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "dbg.h"
#include "nrf.h"

#ifdef NRF_TG_BB
#include "uart.h"
#include "uart_rb.h"
#include "uart_printf.h"
#endif

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
    j = 0;

    dbg_init();
    dbg_set(0x6);

#ifdef NRF_TG_BB
    uart_rb_init();
    uart_printf_init();
#endif

    nrf_init(rxbuf);
    nrf_set_channel(115);
#ifdef NRF_FN_TX
    nrf_enable_pipe(0, tx_addr);
#else
    //nrf_enable_pipe(0, my_addr);
    nrf_enable_pipe(1, my_addr);
#endif

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
        _delay_ms(50);
    }
#else
    nrf_start_receiver();

    while(1) {
        nrf_wait_for_rxpacket();

#ifdef NRF_TG_BB
        for ( i=0 ; i<COM_PL_SIZE ; i++ ) {
            printf("%x ", rxbuf[i]);
        }

        printf("\n");
#endif

        nrf_accept_packet();
        dbg_set(j++);
    }
#endif
}
