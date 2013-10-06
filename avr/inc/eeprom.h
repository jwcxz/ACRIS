#ifndef __EEPROM_H_
#define __EEPROM_H_


// non-generic: read instrument address
void eeprom_get_addr(uint8_t *);


// generic functions
void eeprom_read(uint8_t *, uint8_t, uint8_t *);
void eeprom_write(uint8_t *, uint8_t, uint8_t *);


#endif
