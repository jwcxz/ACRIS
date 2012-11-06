#ifndef _TLC_H_
#define _TLC_H_

// latch pulse speed
#define XLATPD 1

void tlc_init(void);
void tlc_drive(void);

void     set(volatile uint8_t driver[], uint8_t posn, uint16_t value);
uint16_t get(volatile uint8_t driver[], uint8_t posn);
void     set_output(uint8_t chan, uint8_t led, uint16_t val);
uint16_t ser2led(uint8_t ser);

#endif
