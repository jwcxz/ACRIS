#include "led.h"
#include "tlc.h"

#define LEFT 0
#define RGHT 1

// figure out if a given address mask matches the address of the device
__inline__ uint8_t addr_match(uint8_t addr) {
    return ( 
        ( (addr < 0xF0) && (my_addr == addr) ) ||
        ( (my_addr >> 4) == (addr & 0x0F) ) ||
        ( addr == 0xFF )
    );
}

// convert 8-bit serial input data into a 12-bit output for the TLC
// and try to preserve the full range of the TLC's control
__inline__ uint16_t ld_upconv(uint8_t ser) {
    return (((uint16_t) ser) << 4) | (ser >> 4);
}

// convert two 8-bit values to a 12-bit value
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
}
__inline__ uint16_t hd_rword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) first) << 4 ) | ( (second & 0xF0) >> 4 );
}

// set a single RGB LED by setting the appropriate bank of outputs
// ledno is 0-4, channel is 0-2 (R,G,B)
void set_led(uint8_t ledno, uint8_t channel, uint16_t value) {
    /*
     * TLC          0                     1                     2
     * ADR 012 345 678 9AB CDE   012 345 678 9AB CDE   012 345 678 9AB CDE
     * LED R0R G0G B0B R1R G1G   B1B R2R G2G B2B R3R   G3G B3B R4R G4G B4B
     */

    uint8_t i;

    switch (ledno) {
        case 0:
            for (i=1 ; i<=3 ; i++) {
                set(tlc[0], 3*channel+i, value);
            }

            break;

        case 1:
            if (channel <= 1) {
                // R, G
                for (i=1 ; i<=3 ; i++) {
                    set(tlc[0], 3*3+3*channel+i, value);
                }
            } else {
                // B

                for (i=1 ; i<=3 ; i++) {
                    set(tlc[1], i, value);
                }
            }
            
            break;

        case 2:
            for (i=1 ; i<=3 ; i++) {
                set(tlc[1], 3*1+3*channel+i, value);
            }

            break;

        case 3:
            if ( channel == 0 ) {
                // R
                for (i=1 ; i<=3 ; i++) {
                    set(tlc[1], 3*4+i, value);
                }
            } else {
                // G, B
                for (i=1 ; i<=3 ; i++) {
                    set(tlc[2], 3*(channel-1)+i, value);
                }
            }
            
            break;

        case 4:
            for (i=1 ; i<=3 ; i++) {
                set(tlc[2], 3*2+3*channel+i, value);
            }

            break;

        default:
            break;
    }
}

void led_action(uint8_t action, uint8_t args[]) {
    // interpret the controller command and arguments
    
    uint8_t led, color;
    uint16_t red, grn, blu;

    if ( addr_match(args[0]) ) {
        // this command applies to this address
        // we're done with the address
        args = &(args[1]);
        
        switch(action) {
            // refer to README in this directory for a description of the
            // commands
            case CMD_LDSET:
                // R0 G0 B0 R1 G1 B1 R2 G2 B2 R3 G3 B3 R4 G4 B4

                for ( led=0 ; led<5 ; led++ ) {
                    for ( color=0 ; color<3 ; color++ ) {
                        set_led(led, color, ld_upconv(args[3*led + color]));
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
                
                red = hd_lword(args[0], args[1]);
                grn = hd_rword(args[2], args[3]);
                blu = hd_lword(args[3], args[4]);

                set_led(0, 0, red);
                set_led(0, 1, grn);
                set_led(0, 2, blu);


                red = hd_rword(args[5], args[6]);
                grn = hd_lword(args[6], args[7]);
                blu = hd_rword(args[8], args[9]);

                set_led(1, 0, red);
                set_led(1, 1, grn);
                set_led(1, 2, blu);


                red = hd_lword(args[9],  args[10]);
                grn = hd_rword(args[11], args[12]);
                blu = hd_lword(args[12], args[13]);

                set_led(2, 0, red);
                set_led(2, 1, grn);
                set_led(2, 2, blu);


                red = hd_rword(args[14], args[15]);
                grn = hd_lword(args[15], args[16]);
                blu = hd_rword(args[17], args[18]);

                set_led(3, 0, red);
                set_led(3, 1, grn);
                set_led(3, 2, blu);


                red = hd_lword(args[18], args[19]);
                grn = hd_rword(args[20], args[21]);
                blu = hd_lword(args[21], args[22]);

                set_led(4, 0, red);
                set_led(4, 1, grn);
                set_led(4, 2, blu);
                
                break;

            case CMD_LDALL:
                // R G B

                red = ld_upconv(args[0]);
                grn = ld_upconv(args[1]);
                blu = ld_upconv(args[2]);

                for ( led=0 ; led<5 ; led++ ) {
                    set_led(led, 0, red);
                    set_led(led, 1, grn);
                    set_led(led, 2, blu);
                }

                break;

            case CMD_HDALL:
                // 0/R R/R G/G G/B B/B
                red = hd_lword(args[0], args[1]);
                grn = hd_rword(args[2], args[3]);
                blu = hd_lword(args[3], args[4]);

                for ( led=0 ; led<5 ; led++ ) {
                    set_led(led, 0, red);
                    set_led(led, 1, grn);
                    set_led(led, 2, blu);
                }
                
                break;
                
            default:
                return;
                break;
        }
        
        tlc_drive();
    }
}
