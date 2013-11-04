#ifndef __MAIN_H_
#define __MAIN_H_

typedef enum {
    CMD_PSYNC = 0xAA,
    CMD_CSYNC = 0x55,

    CMD_CCHAN = 0xD0,
    CMD_CPWR  = 0xD1,
} cmd_t;


int main(void);

void transmitter_loop(void);
void recv_payload(void);
void recv_config(void);

#endif
