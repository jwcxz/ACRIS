#ifndef __MAIN_H_
#define __MAIN_H_

typedef enum {
    CMD_SYNC = 0xAA,
} cmd_t;

#define NUM_SYNCS 3


int main(void);

void transmitter_loop(void);

#endif
