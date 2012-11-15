#include "led.h"
#include "tlc.h"

__inline__ uint8_t addr_match(uint8_t addr) {
    return ( 
        ( (addr < 0xF0) && (my_addr == addr) ) ||
        ( (my_addr >> 4) == (addr & 0x0F) )
    );
}

void led_action(uint8_t action, uint8_t args[]) {
    // interpret the controller command and arguments
    
    uint8_t color, idx, i;

    if ( addr_match(args[0]) ) {
        // this command applies to this address
        // we're done with the address
        args = &(args[1]);
        
        switch(action) {
            // refer to README in this directory for a description of the
            // commands
            case CMD_LDSET:
                for (color = 0 ; color < 3 ; color++ ) {
                    for (idx=0 ; idx<15 ; idx+=3) {
                        set_led(tlc[(color+idx)/5],
                                (color+idx)%5,
                                ser2led(args[color+idx]));
                    }
                }
                
                break;

            case CMD_HDSET:
                
                break;

            case CMD_LDALL:
                for (color = 0 ; color < 3 ; color++ ) {
                    for (idx=0 ; idx<15 ; idx+=3) {
                        set_led(tlc[(color+idx)/5],
                                (color+idx)%5,
                                ser2led(args[color]));
                    }
                }

                break;

            case CMD_HDALL:
                
                break;
                
            default:
                return;
                break;
        }
        
        tlc_drive();
    }
}

__inline__ void set_led(uint8_t driver, uint8_t led, uint16_t value) {
    uint8_t i;

    for (i=0 ; i<3 ; i++) {
        set(tlc[driver], 3*led+i, value);
    }
}
