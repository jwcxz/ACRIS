/*
 * flash memory access functions
 * jwc :: jwcxz.com
 */

#include <avr/boot.h>

#include "config.h"
#include "flash.h"

void flash_write_page(uint16_t addr, uint8_t *buf) {
    uint16_t i,w;
    uint8_t sreg;

    // disable interrupts
    sreg = SREG;
    cli();

    boot_page_erase_safe(addr);
    boot_spm_busy_wait();

    for ( i=0 ; i<PAGESIZE ; i+=2 ) {
        // make word
        w = *buf++;
        w |= (*buf++)<<8;

        boot_page_fill_safe(addr+i, w);
    }

    boot_page_write_safe(addr);
    boot_spm_busy_wait();

    // re-enable interrupts
    SREG = sreg;
}
