#ifndef __MAIN_H_
#define __MAIN_H_

typedef enum {
    UART_ST_IDLE = 0,
    UART_ST_IDL2,
    UART_ST_ADDR,
    UART_ST_PYLD
} uart_state_t;

typedef enum {
    CMD_SYNC = 0xAA,
} cmd_t;


int main(void);

void uart_rx_handler(uint8_t);

#endif
