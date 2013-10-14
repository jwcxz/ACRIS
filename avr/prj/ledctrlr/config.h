#ifndef __CONFIG_H_
#define __CONFIG_H_


#include "config_top.h"
#include "pins.h"


// commands
#define CMD_LDSET_LEGACY 0xAA
#define CMD_LDSET 0x00
#define CMD_HDSET 0x01
#define CMD_LDALL 0x10
#define CMD_HDALL 0x11

#define CMD_STATS 0x20


// this project is run in receiver mode
#define NRF_FN_RX


#endif
