#ifndef __LED_H_
#define __LED_H_


void led_action(uint8_t, uint8_t *);


// convert 8-bit serial input data into a 12-bit output for the TLC
// and try to preserve the full range of the TLC's control
__inline__ uint16_t led_ld_upconv(uint8_t ser) {
    return (((uint16_t) ser) << 4) | (ser >> 4);
}

// convert two 8-bit values to a 12-bit value
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
}
__inline__ uint16_t led_hd_rword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) first) << 4 ) | ( (second & 0xF0) >> 4 );
}
    

#endif
