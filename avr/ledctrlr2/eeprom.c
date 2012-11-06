/* A C R I S   P R O J E C T ********
 * LED Controller                   *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo -- http://jwcxz.com/ *
 *                                  *
 * EEPROM writing and reading       *
 ************************************/

#include "eeprom.h"
#include <avr/eeprom.h>

uint8_t get_addr(void) {
    uint8_t tmp;
    eeprom_busy_wait();
    tmp = eeprom_read_byte(EEPROM_INST_ADDR);
    return tmp;
}

uint16_t get_baud(void) {
    uint16_t tmp;
    eeprom_busy_wait();
    tmp = eeprom_read_word(EEPROM_BAUD_RATE);

                        // v return default prescale if not set
    if ( tmp == 0xFFFF ) return DEF_BAUD_PRESCALE;
    else return tmp;
}

uint8_t get_baud_dbl(void) {
    uint8_t tmp;
    eeprom_busy_wait();
    tmp = eeprom_read_byte(EEPROM_BAUD_DBLE);

                        // v return default double if not set
    if ( tmp == 0xFF ) return DEF_BAUD_DOUBLE;
    else return tmp&1;
}
