#ifndef __MAIN_H
#define __MAIN_H

#define AM_ALL 255

typedef enum {
    CMD_NOP         = 'N',
    CMD_SYNC        = 0xAA,
    CMD_ADDR        = 'A',
    CMD_BAUD        = 'B',
    CMD_BOOT        = 'R',
    CMD_DISP_ADDR_H = 'D',
    CMD_DISP_ADDR_L = 'E',
    CMD_MASK        = 'M',
    CMD_PROG        = 'P',
    CMD_FNSH        = 'F'
} cmd_type_t;

typedef enum {
    CST_IDLE     = 0,
    CST_SYNC     = 1,
    CST_MASK     = 2,
    CST_ADDR     = 3,
    CST_BAUD_H   = 4,
    CST_BAUD_L   = 5,
    CST_BAUD_D   = 6,
    CST_PROG_A_H = 7,
    CST_PROG_A_L = 8,
    CST_PROG_D   = 9,
    CST_PROG_V   = 10
} cst_type_t;


int main(void);
void receive_data(void);
void process_rx(void);
void give_up(uint8_t);
void addr_set(uint8_t);
uint8_t addr_get(void);
uint8_t applies_to_me(void);

#endif
