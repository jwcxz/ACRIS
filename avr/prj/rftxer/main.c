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
uint8_t tx_addr[COM_AD_SIZE] = RX_MASK;

// payload buffers
uint8_t txbuf[COM_PL_SIZE];
uint8_t rxbuf[COM_PL_SIZE];


int main(void) {
    dbg_init();
    dbg_set(0xA);

    uart_rb_init();
    uart_printf_init();

    nrf_init(rxbuf);
    nrf_set_channel(115);
    nrf_set_power(NRF_CFG_RF_GAIN_M12);
    nrf_enable_pipe(0, tx_addr);

    sei();

    while (1) {
        transmitter_loop();
    }
}


void transmitter_loop(void) {
    uint8_t data, idx;

    data = uart_rb_rx();

    if ( data == CMD_PSYNC || data == CMD_CSYNC ) {
        idx = 0;
        while ( idx++ < NUM_SYNCS-1 ) {
            if (uart_rb_rx() != data) {
                return;
            }
        }
    }

    if ( data == CMD_PSYNC ) {
        recv_payload();
    } else {
        recv_config();
    }
}


void recv_payload(void) {
    uint8_t idx = 0;

    // get target address
    tx_addr[0] = uart_rb_rx();
    tx_addr[1] = uart_rb_rx();
    tx_addr[2] = uart_rb_rx();

    printf("%c%c%c", tx_addr[0], tx_addr[1], tx_addr[2]);


    // get a full payload's worth of characters
    idx = 0;
    while (idx < COM_PL_SIZE) {
        txbuf[idx++] = uart_rb_rx();
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

    return;
}

void recv_config(void) {
    uint8_t cmd, data;

    cmd = uart_rb_rx();

    switch (cmd) {
        case CMD_CCHAN:
            nrf_set_channel(uart_rb_rx());
            printf("%02x", nrf_regrd(NRF_REG_RF_CH));
            break;

        case CMD_CPWR:
            nrf_set_power(uart_rb_rx() << NRF_BIT_RF_PWR21);
            printf("%02x", (nrf_regrd(NRF_REG_RF_SETUP) >> NRF_BIT_RF_PWR21) & 0x3);
            break;

        default:
            break;
    }

    return;
}
