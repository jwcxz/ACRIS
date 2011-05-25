/*
 * LED command processor
 * jwc :: jwcxz.com
 */

#include "config.h"

#include "led.h"
#include "ledset.h"
#include "tlc.h"


void led_action(uint8_t action, uint8_t args[]) {
    // interpret the controller command and arguments

    uint8_t led, color;
    uint16_t red, grn, blu;

    switch(action) {
        // refer to README in this directory for a description of the
        // commands
        case CMD_LDSET:
            // R0 G0 B0 R1 G1 B1 R2 G2 B2 R3 G3 B3 R4 G4 B4

            for ( led=0 ; led<5 ; led++ ) {
                for ( color=0 ; color<3 ; color++ ) {
                    ledset_set(led, color, led_ld_upconv(args[3*led + color]));
                }
            }

            break;

        case CMD_HDSET:
            /*
                *     0     1     2     3     4
                * 1  00/R0 R0/R0 G0/G0 G0/B0 B0/B0
                * 5  R1/R1 R1/G1 G1/G1 B1/B1 B1/R2
                * 10 R2/R2 G2/G2 G2/B2 B2/B2 R3/R3
                * 15 R3/G3 G3/G3 B3/B3 B3/R4 R4/R4
                * 20 G4/G4 G4/B4 B4/B4
                */

            red = led_hd_lword(args[0], args[1]);
            grn = led_hd_rword(args[2], args[3]);
            blu = led_hd_lword(args[3], args[4]);

            ledset_set(0, 0, red);
            ledset_set(0, 1, grn);
            ledset_set(0, 2, blu);


            red = led_hd_rword(args[5], args[6]);
            grn = led_hd_lword(args[6], args[7]);
            blu = led_hd_rword(args[8], args[9]);

            ledset_set(1, 0, red);
            ledset_set(1, 1, grn);
            ledset_set(1, 2, blu);


            red = led_hd_lword(args[9],  args[10]);
            grn = led_hd_rword(args[11], args[12]);
            blu = led_hd_lword(args[12], args[13]);

            ledset_set(2, 0, red);
            ledset_set(2, 1, grn);
            ledset_set(2, 2, blu);


            red = led_hd_rword(args[14], args[15]);
            grn = led_hd_lword(args[15], args[16]);
            blu = led_hd_rword(args[17], args[18]);

            ledset_set(3, 0, red);
            ledset_set(3, 1, grn);
            ledset_set(3, 2, blu);


            red = led_hd_lword(args[18], args[19]);
            grn = led_hd_rword(args[20], args[21]);
            blu = led_hd_lword(args[21], args[22]);

            ledset_set(4, 0, red);
            ledset_set(4, 1, grn);
            ledset_set(4, 2, blu);

            break;

        case CMD_LDALL:
            // R G B

            red = led_ld_upconv(args[0]);
            grn = led_ld_upconv(args[1]);
            blu = led_ld_upconv(args[2]);

            for ( led=0 ; led<5 ; led++ ) {
                ledset_set(led, 0, red);
                ledset_set(led, 1, grn);
                ledset_set(led, 2, blu);
            }

            break;

        case CMD_HDALL:
            // 0/R R/R G/G G/B B/B
            red = led_hd_lword(args[0], args[1]);
            grn = led_hd_rword(args[2], args[3]);
            blu = led_hd_lword(args[3], args[4]);

            for ( led=0 ; led<5 ; led++ ) {
                ledset_set(led, 0, red);
                ledset_set(led, 1, grn);
                ledset_set(led, 2, blu);
            }

            break;

        default:
            return;
            break;
    }

    tlc_drive();
}

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
