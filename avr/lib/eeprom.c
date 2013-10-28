/*
 * EEPROM access functions
 * jwc :: jwcxz.com
 */

#include <avr/eeprom.h>

#include "config.h"
#include "eeprom.h"


// acris-specific configuration bits
// these functions check the validity of the eeprom data before reading
//  if valid
//      - fill return buffer with read value
//      - return 1
//  if invalid (i.e. unprogrammed):
//      - fill return buffer with default value
//      - write default value to eeprom
//      - mark setting as valid
//      - return 0

uint8_t eeprom_get_addr(uint8_t *buf) {
    uint8_t i, ret;

    if (eeprom_check(EEPROM_INST_ADDR_V, EEPROM_INST_ADDR_B)) {
        ret = 1;

        for ( i=0 ; i<COM_AD_SIZE ; i++ ) {
            eeprom_busy_wait();
            buf[i] = eeprom_read_byte(&(EEPROM_INST_ADDR[i]));
        }
    } else {
        ret = 0;

        for ( i=0 ; i<COM_AD_SIZE ; i++ ) {
            buf[i] = EEPROM_INST_ADDR_D(i);

            eeprom_busy_wait();
            eeprom_write_byte(&(EEPROM_INST_ADDR[i]), EEPROM_INST_ADDR_D(i));

            eeprom_validate(EEPROM_INST_ADDR_V, EEPROM_INST_ADDR_B);
        }
    }

    return ret;
}


uint8_t eeprom_get_chan(uint8_t *buf) {
    uint8_t ret;

    if (eeprom_check(EEPROM_INST_CHAN_V, EEPROM_INST_CHAN_B)) {
        ret = 1;

        eeprom_busy_wait();
        buf[0] = eeprom_read_byte(EEPROM_INST_CHAN);
    } else {
        ret = 0;

        buf[0] = EEPROM_INST_CHAN_D(0);

        eeprom_busy_wait();
        eeprom_write_byte(EEPROM_INST_CHAN, EEPROM_INST_CHAN_D(0));

        eeprom_validate(EEPROM_INST_CHAN_V, EEPROM_INST_CHAN_B);
    }

    return ret;
}


// generic functions for processing EEPROM transfers on buffers

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


// functions for determining data validity

uint8_t eeprom_check(uint8_t *bank, uint8_t idx) {
    eeprom_busy_wait();

    return !(eeprom_read_byte(bank) & _BV(idx));
}


void eeprom_validate(uint8_t *bank, uint8_t idx) {
    uint8_t v;

    eeprom_busy_wait();
    v = eeprom_read_byte(bank) & ~(_BV(idx));

    eeprom_busy_wait();
    eeprom_write_byte(bank, v);
}
