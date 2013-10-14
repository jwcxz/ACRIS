/*
 * EEPROM access functions
 * jwc :: jwcxz.com
 */

#include <avr/eeprom.h>

#include "config.h"
#include "eeprom.h"

void eeprom_get_addr(uint8_t *buf) {
    uint8_t i;

    for ( i=0 ; i<COM_AD_SIZE ; i++ ) {
        eeprom_busy_wait();
        buf[i] = eeprom_read_byte(EEPROM_INST_ADDR);
    }
}


void eeprom_get_chan(uint8_t *buf) {
    eeprom_busy_wait();
    buf[0] = eeprom_read_byte(EEPROM_INST_CHAN);
}


void eeprom_read(uint8_t *offset, uint8_t len, uint8_t *buf) {
    uint8_t i = 0;

    while (len--) {
        eeprom_busy_wait();

        buf[i] = eeprom_read_byte(offset);
        offset = &(offset[1]);
        i++;
    }
}


void eeprom_write(uint8_t *offset, uint8_t len, uint8_t *buf) {
    uint8_t i = 0;

    while (len--) {
        eeprom_busy_wait();

        eeprom_write_byte(offset, buf[i]);
        offset = &(offset[1]);
        i++;
    }
}
