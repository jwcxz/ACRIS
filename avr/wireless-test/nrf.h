#ifndef __NRF_H
#define __NRF_H

#include "nrf_regmap.h"

// initialization
void nrf_init(void);

// application-level commands
void nrf_enable_irq(void);
void nrf_disable_irq(void);
void nrf_start_receiver(void);
void nrf_stop_receiver(void);

// chip commands
uint8_t nrf_regwr(uint8_t, uint8_t);
uint8_t nrf_regrd(uint8_t);

uint8_t nrf_regwr_long(uint8_t, uint8_t, uint8_t);
uint8_t nrf_regrd_long(uint8_t, uint8_t, uint8_t);

uint8_t nrf_flushtx(void);
uint8_t nrf_flushrx(void);

uint8_t nrf_reuserx(void);

uint8_t nrf_rxplwidth(void);

uint8_t nrf_ackpl(uint8_t, uint8_t, uint8_t *);

uint8_t nrf_txnoack(uint8_t, uint8_t, uint8_t *);

uint8_t nrf_status(void);

#endif
