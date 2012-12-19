#include "led.h"
#include "tlc.h"

#define LEFT 0
#define RGHT 1

// figure out if a given address mask matches the address of the device
__inline__ uint8_t addr_match(uint8_t addr) {
    return ( 
        ( (addr < 0xF0) && (my_addr == addr) ) ||
        ( (my_addr >> 4) == (addr & 0x0F) )
    );
}

// set a single RGB LED by setting the appropriate bank of outputs
__inline__ void set_led(uint8_t driver, uint8_t led, uint16_t value) {
    uint8_t i;

    for (i=0 ; i<3 ; i++) {
        set(tlc[driver], 3*led+i, value);
    }
}

// convert 8-bit serial input data into a 12-bit output for the TLC
// and try to preserve the full range of the TLC's control
__inline__ uint16_t ser2led(uint8_t ser) {
    return (((uint16_t) ser) << 4) | (ser >> 4);
}

void led_action(uint8_t action, uint8_t args[]) {
    // interpret the controller command and arguments
    /*
        TLC          0                     1                     2
        ADR 012 345 678 9AB CDE   012 345 678 9AB CDE   012 345 678 9AB CDE
        LED R0R G0G B0B R1R G1G   B1B R2R G2G B2B R3R   G3G B3B R4R G4G B4B
        */
    
    uint8_t color, idx;
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
                // XXX: wrong
                for ( color = 0 ; color < 3 ; color++ ) {
                    for (idx=0 ; idx<15 ; idx+=3) {
                        set_led((color+idx)/5,
                                (color+idx)%5,
                                ser2led(args[color+idx]));
                    }
                }
                
                break;

            case CMD_HDSET:
                /*
                 * 00/R0 R0/R0 G0/G0 G0/B0 B0/B0
                 * R1/R1 R1/G1 G1/G1 B1/B1 B1/R2
                 * R2/R2 G2/G2 G2/B2 B2/B2 R3/R3
                 * R3/G3 G3/G3 B3/B3 B3/R4 R4/R4
                 * G4/G4 G4/B4 B4/B4
                 */
                
                red = mkword(args[0], args[1], LEFT);
                grn = mkword(args[2], args[3], RGHT);
                
                
                break;

            case CMD_LDALL:
                // R G B
                // XXX: wrong
                for ( color = 0 ; color < 3 ; color++ ) {
                    for (idx=0 ; idx<15 ; idx+=3) {
                        set_led((color+idx)/5,
                                (color+idx)%5,
                                ser2led(args[color]));
                    }
                }

                break;

            case CMD_HDALL:
                // 0/R R/R G/G G/B B/B
                red = ((args[0]&0xF) << 4) | args[1];
                grn = (args[2] << 8) | ((args[3]&0xF0) >> 4);
                blu = (args[2] << 8) | ((args[3]&0xF0) >> 4);
                
                for ( idx=0 ; idx<3 ; i++ ) {
                    // red
                    set_led(0, 3*0+idx, red);
                    set_led(0, 3*3+idx, red);
                    set_led(1, 3*1+idx, red);
                    set_led(1, 3*4+idx, red);
                    set_led(2, 3*2+idx, red);
                    
                    // grn
                    set_led(0, 3*1+idx, grn);
                    set_led(0, 3*4+idx, grn);
                    set_led(1, 3*2+idx, grn);
                    set_led(2, 3*0+idx, grn);
                    set_led(2, 3*3+idx, grn);
                    
                    // blu
                    set_led(0, 3*2+idx, blu);
                    set_led(1, 3*0+idx, blu);
                    set_led(1, 3*3+idx, blu);
                    set_led(2, 3*1+idx, blu);
                    set_led(2, 3*4+idx, blu);
                }
                
                break;
                
            default:
                return;
                break;
        }
        
        tlc_drive();
    }
}
