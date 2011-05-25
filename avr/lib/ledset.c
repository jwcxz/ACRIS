/*
 * TLC LED setup functions
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "main.h"
#include "ledset.h"
#include "tlc.h"

// set a single RGB LED by setting the appropriate bank of outputs
// ledno is 0-4, channel is 0-2 (R,G,B)
void ledset_set(uint8_t ledno, uint8_t channel, uint16_t value) {
    uint8_t i;

#if (BRDREV == 1)
    /*
     * TLC          0                     1                     2
     * ADR 012 345 678 9AB CDE   012 345 678 9AB CDE   012 345 678 9AB CDE
     * LED R0R R1R R2R R3R R4R   G0G G1G G2G G3G G4G   B0B B1B B2B B3B B4B
     */

    for (i=1 ; i<=3 ; i++) {
        set(tlc[channel], 3*ledno + i, value);
    }
#elif (BRDREV == 2)
    /*
     * TLC          0                     1                     2
     * ADR 012 345 678 9AB CDE   012 345 678 9AB CDE   012 345 678 9AB CDE
     * LED R0R G0G B0B R1R G1G   B1B R2R G2G B2B R3R   G3G B3B R4R G4G B4B
     */

    switch (ledno) {
        case 0:
            for (i=1 ; i<=3 ; i++) {
                tlc_set(tlc[0], 3*channel+i, value);
            }

            break;

        case 1:
            if (channel <= 1) {
                // R, G
                for (i=1 ; i<=3 ; i++) {
                    tlc_set(tlc[0], 3*3+3*channel+i, value);
                }
            } else {
                // B

                for (i=1 ; i<=3 ; i++) {
                    tlc_set(tlc[1], i, value);
                }
            }

            break;

        case 2:
            for (i=1 ; i<=3 ; i++) {
                tlc_set(tlc[1], 3*1+3*channel+i, value);
            }

            break;

        case 3:
            if ( channel == 0 ) {
                // R
                for (i=1 ; i<=3 ; i++) {
                    tlc_set(tlc[1], 3*4+i, value);
                }
            } else {
                // G, B
                for (i=1 ; i<=3 ; i++) {
                    tlc_set(tlc[2], 3*(channel-1)+i, value);
                }
            }

            break;

        case 4:
            for (i=1 ; i<=3 ; i++) {
                tlc_set(tlc[2], 3*2+3*channel+i, value);
            }

            break;

        default:
            break;
    }
#endif
}
