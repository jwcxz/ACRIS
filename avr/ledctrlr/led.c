/* LED OUTPUT CALCULATIONS */

#include "led.h"
#include "tlc.h"

void led_action(void) {
    // this is just a wrapper function that decides what to do based on the
    // current command
    
    led_set();

    /* 
    // delete the default call to led_set() above and replace it with the
    // following switch statement to support multiple types of actions
    switch (action) {

        default:
            led_set();
            break;
    }
    */

    tlc_drive();
}

void led_set(void) {
    uint8_t i, j;
    uint16_t red, grn, blu;

    for ( i=0 ; i<5 ; i++ ) {
        red = ser2led(args[3*i]);
        grn = ser2led(args[3*i+1]);
        blu = ser2led(args[3*i+2]);

        for ( j=1 ; j<=3 ; j++ ) { set(tlc[0], 3*i + j, red); }
        for ( j=1 ; j<=3 ; j++ ) { set(tlc[1], 3*i + j, grn); }
        for ( j=1 ; j<=3 ; j++ ) { set(tlc[2], 3*i + j, blu); }

    }
}
