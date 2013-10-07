#ifndef __NRFSPI_H
#define __NRFSPI_H


void nrfspi_init(void);
void nrfspi_enable(void);
void nrfspi_disable(void);

uint8_t nrfspi_txrx(uint8_t, uint8_t *, uint8_t *);
uint8_t nrfspi_txrx_byte(uint8_t);

__inline void nrfspi_cs_en(void);
__inline void nrfspi_cs_ds(void);

#endif
