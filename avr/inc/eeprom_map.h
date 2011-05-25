#ifndef __EEPROM_MAP_H
#define __EEPROM_MAP_H

// the validity bank indicates which settings are currently set
#define EEPROM_VMAP_0   ((uint8_t*) 0xF0)


// each configuration consists of the eeprom address, unprogrammed default, and
// pointer to bit that determines its validity


// ACRIS EEPROM address mapping

// unique instrument address
#define EEPROM_INST_ADDR        ((uint8_t*) 0x00)
#define EEPROM_INST_ADDR_V      EEPROM_VMAP_0
#define EEPROM_INST_ADDR_B      0
#define EEPROM_INST_ADDR_D(i)   (i==0) ? 0xAA : (i==1) ? 0xAA : (i==2) ? 0x00 : 0xFF


// rf channel
#define EEPROM_INST_CHAN        ((uint8_t*) 0x04)
#define EEPROM_INST_CHAN_V      EEPROM_VMAP_0
#define EEPROM_INST_CHAN_B      1
#define EEPROM_INST_CHAN_D(i)   (i==0) ? 0x07 : 0xFF


#endif
