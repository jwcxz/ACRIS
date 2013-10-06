#ifndef __TLC_H_
#define __TLC_H_


// latch pulse speed in us
#define TLC_XLATPD 1


__inline__ void tlc_pulse_xlat(void);

void tlc_init(void);
void tlc_drive(void);

uint8_t tlc_read_xerr(void);

void tlc_set(uint8_t volatile *, uint8_t, uint16_t);
uint16_t tlc_get(uint8_t volatile *, uint8_t);


#endif
