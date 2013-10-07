/*
 * Wireless RX Test
 * jwc :: jwcxz.com
 */

#include "config.h"

#include "main.h"

#include "dbgled.h"
#include "nrf.h"
#include "uart.h"

uint8_t tx_addr[COM_AD_SIZE] = TX_ADDR;

uint8_t txbuf[COM_AD_SIZE+COM_PL_SIZE];
volatile uint8_t txbuf_count;
volatile uart_state_t uart_state;

// TODO: get rid of rxbuf until it's needed again
uint8_t rxbuf[COM_PL_SIZE];


int main(void) {
    txbuf_count = 0;

    dbg_init();

    dbg_set( 0xA );
    nrf_init(COM_CHANNEL, tx_addr, &(txbuf[COM_AD_SIZE]), rxbuf);

    uart_init(NULL, &uart_rx_handler);
    
    uart_enable();
    sei();

    while(1);
}


// TODO: this should really be replaced with a ring buffer or something
void uart_rx_handler(uint8_t byte) {
    switch (uart_state) {
        case UART_ST_IDLE:
            if (byte == CMD_SYNC) {

                uart_state = UART_ST_IDL2;
            } else {
                uart_state = UART_ST_IDLE;
            }

            break;

        case UART_ST_IDL2:
            if (byte == CMD_SYNC) {
                uart_state = UART_ST_ADDR;
            } else {
                uart_state = UART_ST_IDLE;
            }

            break;


        case UART_ST_ADDR:
            txbuf[0] = byte;
            txbuf[1] = RX_MASK1;
            txbuf[2] = RX_MASK2;
            txbuf_count = 3;
            uart_state = UART_ST_PYLD;
            break;

        case UART_ST_PYLD:
            txbuf[txbuf_count++] = byte;

            if ( txbuf_count == sizeof(txbuf) ) {
                nrf_transmit_packet(txbuf, &(txbuf[COM_AD_SIZE]));
                uart_state = UART_ST_IDLE;
            } else {
                uart_state = UART_ST_PYLD;
            }

            break;

        default:
            uart_state = UART_ST_IDLE;
    }
}
