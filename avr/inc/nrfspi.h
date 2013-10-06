#ifndef __USART_H
#define __USART_H

void usart_init(void);
void usart_enable(void);
void usart_disable(void);
uint8_t usart_txrx(uint8_t, uint8_t *, uint8_t *);

#endif
