/*
 * UART -> Wireless Transmitter
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "main.h"

#include "dbg.h"
#include "nrf.h"

#include "uart.h"
#include "uart_rb.h"
#include "uart_printf.h"

#include "stdio.h"


// transmitter's own address
uint8_t my_addr[COM_AD_SIZE] = MY_ADDR;

// buffer for address to transmit to
uint8_t tx_addr[COM_AD_SIZE] = {0, RX_MASK1, RX_MASK2};

// payload buffers
uint8_t txbuf[COM_PL_SIZE];
uint8_t rxbuf[COM_PL_SIZE];


int main(void) {
    dbg_init();
    dbg_set(0xA);

    uart_rb_init();
    uart_printf_init();

    printf("\n\nserial -> RF\n");

    nrf_init(0x05, my_addr, txbuf, rxbuf);

    while (1) {
        transmitter_loop();
    }
}


void transmitter_loop(void) {
    uint8_t idx = 0;

    // get sync header
    while (idx < NUM_SYNCS) {
        if (uart_rb_rx() != CMD_SYNC) {
            return;
        }
        idx++;
    }

    // get target address
    tx_addr[2] = uart_rb_rx();

    // get a full payload's worth of characters
    while (idx < COM_PL_SIZE) {
        txbuf[idx] = uart_rb_rx();
        idx++;
    }

    // send payload, wait until done
    idx = nrf_transmit_packet(tx_addr, txbuf);

    // print packet result
    if (!idx) {
        printf(".");
    } else {
        printf("X");
    }
}
