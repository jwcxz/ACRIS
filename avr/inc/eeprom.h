#ifndef __EEPROM_H_
#define __EEPROM_H_


uint8_t eeprom_get_addr(uint8_t *);
uint8_t eeprom_get_chan(uint8_t *);

void eeprom_read(uint8_t *, uint8_t, uint8_t *);
void eeprom_write(uint8_t *, uint8_t, uint8_t *);

uint8_t eeprom_check(uint8_t *, uint8_t);
void eeprom_validate(uint8_t *, uint8_t);

#endif
