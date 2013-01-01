#ifndef _LED_H_
#define _LED_H_

#include "main.h"

__inline__ uint8_t  addr_match(uint8_t);
__inline__ uint16_t ld_upconv(uint8_t);
__inline__ uint16_t hd_lword(uint8_t, uint8_t);
__inline__ uint16_t hd_rword(uint8_t, uint8_t);

void led_action(uint8_t, uint8_t *);
    
#endif
