/* LED OUTPUT CALCULATIONS */

#include "led.h"
#include "tlc.h"

void led_action(void) {
    // this is just a wrapper function that decides what to do based on the
    // current command
    
    switch (action) {
        case CMD_EMGCY:
            led_emgcy();
            break;
        case CMD_EVOFF:
            led_evoff();
            break;
        case CMD_FPANL:
            led_fpanl_rpanl();
            break;
        case CMD_RPANL:
            led_fpanl_rpanl();
            break;
        case CMD_FDISP:
            led_set();
            break;
        case CMD_RDISP:
            led_set();
            break;
        case CMD_UVSET:
            led_uvset_whset();
            break;
        case CMD_WHSET:
            led_uvset_whset();
            break;
        case CMD_STRBE:
            led_strbe_uvstb();
            break;
        case CMD_UVSTB:
            led_strbe_uvstb();
            break;
        default:
            led_set();
            break;
    }

    tlc_drive();
}

void led_emgcy(void) {
    uint8_t i;

#if (CTRLR_TYPE == CTRLR_RGB)
    // set red
    for ( i=1 ; i<=12 ; i++ ) { set(tlc[0], i, 0x800); }

    // set grn
    for ( i=1 ; i<=12 ; i++ ) { set(tlc[1], i, 0x780); }
        
    // set blu
    for ( i=1 ; i<=12 ; i++ ) { set(tlc[2], i, 0x800); }
#elif (CTRLR_TYPE == CTRLR_UVS)
    // set whites
    for ( i=1 ; i<=14 ; i++ ) { set(tlc[0], i, 0x800); }
    
    // shut off UVs
    for ( i=0 ; i<16 ; i++ ) { set(tlc[1], i, 0); }
#endif /* CTRLR_TYPE */
}

void led_evoff(void) {
    uint8_t i, j;
    for ( i=0 ; i<3  ; i++ ) {
        for ( j=0 ; j<16 ; j++ ) { set(tlc[i], j, 0); }
    }
}

void led_fpanl_rpanl(void) {
    uint8_t i;
    uint16_t red, grn, blu;

    // set red
    red = ser2led(args[0]);
    for ( i=1 ; i<=12 ; i++ ) { set(tlc[0], i, red); }

    // set grn
    grn = ser2led(args[1]);
    for ( i=1 ; i<=12 ; i++ ) { set(tlc[1], i, grn); }

    // set grn
    blu = ser2led(args[2]);
    for ( i=1 ; i<=12 ; i++ ) { set(tlc[2], i, blu); }
}

void led_uvset_whset(void) {
    uint8_t i;
    uint16_t val;

    val = ser2led(args[0]);
    if (action == CMD_UVSET) {
        for ( i=1 ; i<=7 ; i++ ) { set(tlc[1], i, val); }
    } else if (action == CMD_WHSET) {
        for ( i=1 ; i<=14 ; i++ ) { set(tlc[0], i, val); }
    }
}

void led_strbe_uvstb(void) {
#if (CTRLR_TYPE == CTRLR_RGB)
    led_evoff();
    tlc_drive();
#elif (CTRLR_TYPE == CTRLR_UVS)
    uint8_t i;

    if ( action == CMD_STRBE ) {
        // set whites to full brightness
        // XXX: use blanking instead
        for ( i=1 ; i<=14 ; i++ ) { set(tlc[0], i, 0xFFF); }
        
        // shut off UVs
        for ( i=0 ; i<16 ; i++ ) { set(tlc[1], i, 0); }
    } else { // action = CMD_UVSTB
        // set UVs to full brightness
        for ( i=1 ; i<=7 ; i++ ) { set(tlc[1], i, 0xFFF); }
        
        // shut off whites
        for ( i=1 ; i<=14 ; i++ ) { set(tlc[0], i, 0x0); }
    }

    // this kind of breaks our general format for processing data, but the
    // other option is to use a timer, which we've run out of
    tlc_drive();
    _delay_us(STB_PULSE);
    led_evoff();
    tlc_drive();
#endif /* CTRLR_TYPE */
}

void led_set(void) {
    uint8_t i;

#if (CTRLR_TYPE == CTRLR_RGB)
    uint8_t j;
    uint16_t red, grn, blu;

    for ( i=0 ; i<4 ; i++ ) {
        red = ser2led(args[3*i]);
        grn = ser2led(args[3*i+1]);
        blu = ser2led(args[3*i+2]);

        for ( j=1 ; j<=3 ; j++ ) { set(tlc[0], 3*i + j, red); }
        for ( j=1 ; j<=3 ; j++ ) { set(tlc[1], 3*i + j, grn); }
        for ( j=1 ; j<=3 ; j++ ) { set(tlc[2], 3*i + j, blu); }

    }
#elif (CTRLR_TYPE == CTRLR_UVS)
    uint16_t uv = ser2led(args[0]);
    uint16_t wh = ser2led(args[1]);

    for ( i=1 ; i<=7 ; i++ ) { set(tlc[1], i, uv); }
    for ( i=1 ; i<=14 ; i++ ) { set(tlc[0], i, wh); }
#endif /* CTRLR_TYPE */
}

