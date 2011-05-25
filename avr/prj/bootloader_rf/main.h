#ifndef __MAIN_H
#define __MAIN_H

#define AM_ALL 255

typedef enum {
    CMD_HOLD_SEQ0 = 0xAA,
    CMD_HOLD_SEQ1 = 0x55,

    CMD_BOOT      = 'R',

    CMD_ADDR_SET  = 'D',
    CMD_ADDR_DISP = 'd',

    CMD_PROG_STRT = 'P',
    CMD_PROG_CONT = 'p',

    CMD_FNSH      = 'F'
} cmd_type_t;

typedef enum {
    CST_IDLE     = 0,
    CST_PROG_RECV,
    CST_PROG_VRFY
} cst_type_t;


int main(void);
void receive_data(void);
void process_packet(void);

#endif
