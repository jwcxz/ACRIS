/* A C R I S   P R O J E C T ********
 * LED Controller                   *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo -- http://jwcxz.com/ *
 *                                  *
 * debug LED control                *
 ************************************/

#include "dbgled.h"

void show_addr(void) {
    dbg_set(instaddr >> 4);
    _delay_ms(500);
    dbg_set(instaddr & 0x0F);
    _delay_ms(500);
}

void dbg_set(uint8_t val) {
    uint8_t tmp = val & 0xF;
    DBGLED_PRT |= tmp;
    DBGLED_PRT &= 0xF0 | tmp;
}

void dbg_on(uint8_t val) {
    _ON(DBGLED_PRT, val);
}

void dbg_off(uint8_t val) {
    _OFF(DBGLED_PRT, val);
}

void dbg_init(void) {
    // this requires the debug bank to be the bottom 4 bits of a bank
    // TODO: make it more advanced
    DBGLED_DDR |= 0x0F;
    DBGLED_PRT &= 0xF0; // clear leds
}
