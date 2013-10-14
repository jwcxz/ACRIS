#ifndef __LED_H_
#define __LED_H_

#include "led_cmds.h"

void led_action(uint8_t, uint8_t *);

__inline__ uint16_t led_ld_upconv(uint8_t ser);
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second);
__inline__ uint16_t led_hd_rword(uint8_t first, uint8_t second);


#endif
