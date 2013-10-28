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

    nrf_init(0x05, my_addr, txbuf, rxbuf);

    sei();

    while (1) {
        transmitter_loop();
    }
}


void transmitter_loop(void) {
    uint8_t data;
    uint8_t idx = 0;

    // get sync header, fail if necessary
    while (idx < NUM_SYNCS) {
        data = uart_rb_rx();
        if (data != CMD_SYNC) {
            return;
        }
        idx++;
    }

    idx = 0;


    // get target address
    tx_addr[0] = uart_rb_rx();

    printf("%c%c%c", tx_addr[0], tx_addr[1], tx_addr[2]);


    // get a full payload's worth of characters
    while (idx < COM_PL_SIZE) {
        txbuf[idx] = uart_rb_rx();
        idx++;
    }


    // send payload, wait until done
    idx = nrf_transmit_packet(tx_addr, txbuf);

    // print result
    if (idx) {
        uart_rb_tx('.');
    } else {
        uart_rb_tx('X');
    }


    // happy blinky lights
    dbg_set(txbuf[0]);
}
