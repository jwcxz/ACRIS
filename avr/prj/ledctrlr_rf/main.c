/* A C R I S   P R O J E C T
 * LED Controller Firmware
 * http://jwcxz.com/projects/acris
 * jwc :: jwcxz.com
 */

#include "config.h"

#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include <avr/boot.h>
#include <avr/eeprom.h>

#include "main.h"

#include "nrf.h"

#include "dbg.h"
#include "eeprom.h"
#include "led.h"
#include "tlc.h"

uint8_t addr[COM_AD_SIZE];
uint8_t chan[1];

// TODO: un-extern this
uint8_t tlc[3][24];

uint8_t txbuf[COM_PL_SIZE];
uint8_t rxbuf[COM_PL_SIZE];


int main(void) {
    // initialize debug LEDs
    dbg_init();
    dbg_set(0x6);

    // initialize TLC
    tlc_init();

    // get the address of the device
    eeprom_get_addr(addr);
    eeprom_get_chan(chan);

    // NRF24L01+ driver
    nrf_init(rxbuf);
    nrf_set_channel(*chan);
    nrf_enable_pipe(1, addr);

    // enable interrupts
    sei();

    // start receiving
    nrf_start_receiver();

    while (1) {
        nrf_wait_for_rxpacket();
        process_packet();
        nrf_accept_packet();
    }

	return 0;
}

void process_packet(void) {
    led_action(rxbuf[0], &(rxbuf[1]));
}
