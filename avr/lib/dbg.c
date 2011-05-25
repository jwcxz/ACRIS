/*
 * Debug LED Driver
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "dbg.h"

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
