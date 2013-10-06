#ifndef __MAIN_H_
#define __MAIN_H_

#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>

int main(void);
void receive_data(void);

#define MAXARGS 24

// state machine states
#define CST_IDLE 0
#define CST_SYNC 1
#define CST_ARGS 2


// commands
#define CMD_SYNC 0x55

#define CMD_LDSET_LEGACY 0xAA
#define CMD_LDSET 0x00
#define CMD_HDSET 0x01
#define CMD_LDALL 0x10
#define CMD_HDALL 0x11

#define CMD_STATS 0x20

#endif
