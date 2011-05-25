#ifndef __NRF_H
#define __NRF_H


#include "nrf_regmap.h"

// minimum time to pulse CE to initiate a transmit
#define NRF_TX_PULSE_MIN_US 15

typedef enum {
    NRF_MODE_OFF = 0,
    NRF_MODE_TX,
    NRF_MODE_RX
} nrf_mode_t;


// initialization
void nrf_init(uint8_t *);

// application-level commands
void nrf_enable_irq(void);
void nrf_disable_irq(void);

void nrf_set_channel(uint8_t);

void nrf_set_power(uint8_t);

void nrf_enable_pipe(uint8_t, uint8_t *);
void nrf_disable_pipe(uint8_t);

uint8_t nrf_transmit_packet(uint8_t *, uint8_t *);

void nrf_start_receiver(void);
void nrf_stop_receiver(void);

void nrf_wait_for_rxpacket(void);
uint8_t nrf_isready_packet(void);
void nrf_accept_packet(void);


// chip commands
void nrf_ce_on(void);
void nrf_ce_off(void);
void nrf_setmode(nrf_mode_t mode);

uint8_t nrf_txpayload(uint8_t *);
uint8_t nrf_rxpayload(uint8_t *);

uint8_t nrf_regwr_long(uint8_t, uint8_t, uint8_t *);
uint8_t nrf_regrd_long(uint8_t, uint8_t, uint8_t *);

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
