#ifndef __MAIN_H_
#define __MAIN_H_

#include <inttypes.h>
#include <util/delay.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>

extern uint8_t tlc[3][24];

int main(void);
void receive_data(void);

#define MAXARGS 24

// state machine states
#define CST_IDLE 0
#define CST_SYNC 1
#define CST_ARGS 2


// commands
#define CMD_SYNC 0x55

#endif
