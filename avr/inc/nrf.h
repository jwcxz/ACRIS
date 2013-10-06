#ifndef __NRF_H
#define __NRF_H

#include "nrf_regmap.h"

typedef enum {
    NRF_FN_TX = 0,
    NRF_FN_RX
} nrf_fn_t

typedef enum {
    NRF_MODE_TX = 0,
    NRF_MODE_RX
} NRF_mode_t;


// initialization
void nrf_init(uint8_t channel, uint8_t *addr, uint8_t volatile *txpbuf, uint8_t volatile *rxpbuf);

// application-level commands
void nrf_enable_irq(void);
void nrf_disable_irq(void);
uint8_t nrf_transmit_packet(uint8_t *, uint8_t *);
void nrf_start_receiver(void);
void nrf_stop_receiver(void);
void nrf_wait_for_packet(void);

// chip commands
void nrf_ce_on(void);
void nrf_ce_off(void);
void nrf_setmode(nrf_mode_t mode);

uint8_t nrf_txpayload(uint8_t *);
uint8_t nrf_rxpayload(uint8_t *);

uint8_t nrf_regwr_long(uint8_t, uint8_t, uint8_t);
uint8_t nrf_regrd_long(uint8_t, uint8_t, uint8_t);

uint8_t nrf_regwr(uint8_t, uint8_t);
uint8_t nrf_regrd(uint8_t);

uint8_t nrf_flushtx(void);
uint8_t nrf_flushrx(void);

uint8_t nrf_reuserx(void);

uint8_t nrf_rxplwidth(void);

uint8_t nrf_ackpl(uint8_t, uint8_t, uint8_t *);

uint8_t nrf_txnoack(uint8_t, uint8_t, uint8_t *);

uint8_t nrf_status(void);

#endif
