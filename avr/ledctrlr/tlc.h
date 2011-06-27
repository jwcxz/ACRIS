/* A C R I S   P R O J E C T ********
 * LED Controller                   *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo -- http://jwcxz.com/ *
 *                                  *
 * TLC array modification, control  *
 ************************************/

#include "main.h"

void tlc_init(void);
void tlc_drive(void);

void     set(volatile uint8_t driver[], uint8_t posn, uint16_t value);
uint16_t get(volatile uint8_t driver[], uint8_t posn);
void     set_output(uint8_t chan, uint8_t led, uint16_t val);
uint16_t ser2led(uint8_t ser);
