/* COLOR UTILITIES */

#include "color.h"

// RGB/HSV colorspace conversions
// loosely based off of http://en.wikipedia.org/wiki/HSL_and_HSV
// but with some approximations that will improve calculation speeds
void hsv2rgb(hsv_t hsv, uint8_t* r, uint8_t* g, uint8_t* b) {
    uint16_t hi = hsv.h / 42; // (360*60/256)

    uint8_t f = 0;
    if (hi == 6) hi = 0;
    else         f = hsv.h % 42;

    uint8_t p = ( hsv.v * (255-hsv.s) ) >> 8;
    uint8_t q = ( hsv.v * (255-((f*hsv.s)/42)) ) >> 8;
    uint8_t t = ( hsv.v * (255-(((42-f) *hsv.s)/42)) ) >> 8;

    switch (hi) {
        case 0:
            *r = hsv.v;
            *g = t;
            *b = p;
            break;
        case 1:
            *r = q;
            *g = hsv.v;
            *b = p;
            break;
        case 2:
            *r = p;
            *g = hsv.v;
            *b = t;
            break;
        case 3:
            *r = p;
            *g = q;
            *b = hsv.v;
            break;
        case 4:
            *r = t;
            *g = p;
            *b = hsv.v;
            break;
        case 5:
        default:
            *r = hsv.v;
            *g = p;
            *b = q;
            break;
    }
}
