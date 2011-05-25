#ifndef __UART_H_
#define __UART_H_

void uart_init(void (*)(void), void (*)(uint8_t));
void uart_enable(void);
void uart_disable(void);

#endif
