/* TIMEOUT FUNCTIONS */

#include "timeout.h"
#include "tlc.h"

void timeoutctr_init(void) {
    // initialize serial timeout timer

    TCCR0B = _BV(CS02) | _BV(CS00);
    TCNT0 = 0;
}

void timeout_disp_init(void) {
    uint8_t i;
#if (CTRLR_TYPE == CTRLR_RGB)
    for ( i=1 ; i<=15 ; i++ ) set(tlc[0], i, 0x000);
    for ( i=1 ; i<=15 ; i++ ) set(tlc[1], i, 0x000);
    for ( i=1 ; i<=15 ; i++ ) set(tlc[2], i, 0x000);

    uint8_t x = ( instaddr % 2 ) ? 1 : 0;

    if ( (instaddr % REAR_MIN) < REAR_MIN/2 ) {
        // left devices
        for ( i=1 ; i<=3 ; i++ ) set(tlc[x+0], i, 0x800);
        for ( i=1 ; i<=3 ; i++ ) set(tlc[x+1], i, 0x100);

        for ( i=4 ; i<=6 ; i++ ) set(tlc[x+0], i, 0x600);
        for ( i=4 ; i<=6 ; i++ ) set(tlc[x+1], i, 0x200);

        for ( i=7 ; i<=9 ; i++ ) set(tlc[x+0], i, 0x400);
        for ( i=7 ; i<=9 ; i++ ) set(tlc[x+1], i, 0x300);

        for ( i=10 ; i<=12 ; i++ ) set(tlc[x+0], i, 0x300);
        for ( i=10 ; i<=12 ; i++ ) set(tlc[x+1], i, 0x300);
    } else {
        // right devices
        for ( i=1 ; i<=3 ; i++ ) set(tlc[x+0], i, 0x300);
        for ( i=1 ; i<=3 ; i++ ) set(tlc[x+1], i, 0x300);

        for ( i=4 ; i<=6 ; i++ ) set(tlc[x+0], i, 0x400);
        for ( i=4 ; i<=6 ; i++ ) set(tlc[x+1], i, 0x300);

        for ( i=7 ; i<=9 ; i++ ) set(tlc[x+0], i, 0x600);
        for ( i=7 ; i<=9 ; i++ ) set(tlc[x+1], i, 0x200);

        for ( i=10 ; i<=12 ; i++ ) set(tlc[x+0], i, 0x800);
        for ( i=10 ; i<=12 ; i++ ) set(tlc[x+1], i, 0x100);
    }
#elif (CTRLR_TYPE == CTRLR_UVS)
    // uv strobes should just be shut off
    for ( i=0 ; i<=15 ; i++ ) set(tlc[0], i, 0);
    for ( i=0 ; i<=15 ; i++ ) set(tlc[1], i, 0);
#endif /* CTRLR_TYPE */
}

void timeout_disp_pixcycle(void) {
#if (CTRLR_TYPE == CTRLR_RGB)
    uint8_t i;
    uint16_t tmp[2];

    uint8_t pside = ( instaddr % REAR_MIN ) < REAR_MIN/2;
    if ( ((to_direc<TIMEOUT_REVDIREC/2) && pside) || (!(to_direc<TIMEOUT_REVDIREC/2) && !pside) ) {
        tmp[0] = get(tlc[0], 1);
        tmp[1] = get(tlc[1], 1);

        for ( i=1 ; i<=3 ; i++ ) set(tlc[0], i, get(tlc[0], 4));
        for ( i=4 ; i<=6 ; i++ ) set(tlc[0], i, get(tlc[0], 7));
        for ( i=7 ; i<=9 ; i++ ) set(tlc[0], i, get(tlc[0], 10));
        for ( i=10 ; i<=12 ; i++ ) set(tlc[0], i, tmp[0]);

        for ( i=1 ; i<=3 ; i++ ) set(tlc[1], i, get(tlc[1], 4));
        for ( i=4 ; i<=6 ; i++ ) set(tlc[1], i, get(tlc[1], 7));
        for ( i=7 ; i<=9 ; i++ ) set(tlc[1], i, get(tlc[1], 10));
        for ( i=10 ; i<=12 ; i++ ) set(tlc[1], i, tmp[1]);
    } else {
        tmp[0] = get(tlc[0], 10);
        tmp[1] = get(tlc[1], 10);

        for ( i=10 ; i<=12 ; i++ ) set(tlc[0], i, get(tlc[0], 7));
        for ( i=7 ; i<=9 ; i++ ) set(tlc[0], i, get(tlc[0], 4));
        for ( i=4 ; i<=6 ; i++ ) set(tlc[0], i, get(tlc[0], 1));
        for ( i=1 ; i<=3 ; i++ ) set(tlc[0], i, tmp[0]);

        for ( i=10 ; i<=12 ; i++ ) set(tlc[1], i, get(tlc[1], 7));
        for ( i=7 ; i<=9 ; i++ ) set(tlc[1], i, get(tlc[1], 4));
        for ( i=4 ; i<=6 ; i++ ) set(tlc[1], i, get(tlc[1], 1));
        for ( i=1 ; i<=3 ; i++ ) set(tlc[1], i, tmp[1]);
    }
#elif (CTRLR_TYPE == CTRLR_UVS)
#endif /* CTRLR_TYPE */
}
