#ifndef _EEPROM_H_
#define _EEPROM_H_

#define EEPROM_INST_ADDR (uint8_t*)  1
#define EEPROM_BAUD_DBLE (uint8_t*)  2
#define EEPROM_BAUD_RATE (uint16_t*) 3

uint8_t get_addr(void);
uint16_t get_baud(void);
uint8_t get_baud_dbl(void);

#endif
