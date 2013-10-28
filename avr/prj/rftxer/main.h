#ifndef __MAIN_H_
#define __MAIN_H_

typedef enum {
    CMD_SYNC = 0xAA,
} cmd_t;


int main(void);

void transmitter_loop(void);

#endif
