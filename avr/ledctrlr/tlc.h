#ifndef _TLC_H_
#define _TLC_H_

#include "main.h"

// latch pulse speed
#define XLATPD 1

__inline__ void pulse_xlat(void);

void tlc_init(void);
void tlc_drive(void);

void     set(volatile uint8_t driver[], uint8_t posn, uint16_t value);
uint16_t get(volatile uint8_t driver[], uint8_t posn);

#endif
