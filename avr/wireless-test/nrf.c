/*
 * SPI Mode USART i/f for NRF24L01+
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "nrfspi.h"
#include "nrf.h"

uint8_t *tx_packet_buffer;
uint8_t *rx_packet_buffer;

uint8_t packet_ready = 0;

// initialization
void nrf_init(uint8_t channel, uint8_t *addr, uint8_t *txpbuf, uint8_t *rxpbuf) {
    // initialize nrfspi
    nrfspi_init();

    // register buffer addresses
    tx_packet_buffer = txpbuf;
    rx_packet_buffer = rxpbuf;

    // turn off wireless communication
    nrf_ce_off();

    // set up chip enable
    _ON(NRF_CE_DDR, NRF_CE_PIN);

    // set up interrupt with pull-up for falling edge
    _OFF(NRF_IRQ_DDR, NRF_IRQ_PIN);
    _ON(NRF_IRQ_PRT, NRF_IRQ_PIN);
    EICRA = _BV(ISC01);

    // perform system configuration
    nrf_regwr(NRF_REG_CONFIG,
            ( _BV(NRF_BIT_MASK_TX_DS)   |
              _BV(NRF_BIT_MASK_MAX_RT)  |
              _BV(NRF_BIT_EN_CRC)       |
              _BV(NRF_BIT_PWR_UP)       |
              _BV(NRF_BIT_PRIM_RX) ));

    nrf_regwr(NRF_REG_EN_AA,
            ( _BV(NRF_BIT_ENAA_P0) ));

    nrf_regwr(NRF_REG_EN_RXADDR,
            ( _BV(NRF_BIT_ERX_P0) ));

    nrf_regwr(NRF_REG_SETUP_AW,
            ( 0x1 << NRF_BIT_AW10 ));

    nrf_regwr(NRF_REG_SETUP_RETR,
            ( ( 0x0 << NRF_BIT_ARD74 )  |
              ( 0x0 << NRF_BIT_ARC30 ) ));

    nrf_regwr(NRF_REG_RF_CH,
            ( ( channel << NRF_BIT_RF_CH60 ) );

    nrf_regwr(NRF_REG_RF_SETUP,
            ( _BV(NRF_BIT_CONT_WAVE)    |
              _BV(NRF_BIT_RF_DR_LOW)    |
              ( COM_AD_SIZE << NRF_BIT_RF_PWR21 ) ));

    nrf_regwr(NRF_REG_RX_PW_P0,
            ( ( COM_PL_SIZE << NRF_BIT_RX_PW_Px50 ) ));

    nrf_regwr_long(NRF_REG_RX_ADDR_P0, 5, addr);
    nrf_regwr_long(NRF_REG_TX_ADDR, 5, addr);
}


// application-level commands
void nrf_enable_irq(void) {
    _ON(EIMSK, INT0);
}


void nrf_disable_irq(void) {
    _OFF(EIMSK, INT0);
    packet_ready = 0;
}


void nrf_start_receiver(void) {
    packet_ready = 0;

    nrf_flushrx();
    nrf_enable_irq();
    nrf_ce_on();
}


void nrf_stop_receiver(void) {
    nrf_ce_off();
    nrf_flushrx();
    nrf_disable_irq();
}


void nrf_wait_for_packet(void) {
    while (!packet_ready);
    return;
}


// nrf24l01+ interrupt handler
ISR(INT0_vect) {
    // when configured as a receiver, indicates that a packet was received by
    // the device and we must read it out

    // TODO: do we have to wait for autoack before disabling the chip?

    // shut off receiver
    nrf_ce_off();
    
    // read out data into buffer
    nrf_rxpayload(packet_buffer);

    // report that the packet is ready
    packet_ready = 1;

    // re-enable receiver
    nrf_ce_on();
}


// chip commands
void nrf_ce_on(void) {
    _ON(NRF_CE_PRT, NRF_CE_PIN);
}


void nrf_ce_off(void) {
    _OFF(NRF_CE_PRT, NRF_CE_PIN);
}


uint8_t nrf_txpayload(uint8_t *buf) {
    uint8_t status;

    status = nrfspi_txrx_byte(NRF_CMD_TXPLW);
    nrfspi_txrx(COM_PL_SIZE, buf, 0);
    return status;
}


uint8_t nrf_rxpayload(uint8_t *buf) {
    uint8_t status;

    status = nrfspi_txrx_byte(NRF_CMD_RXPLR);
    nrfspi_txrx(COM_PL_SIZE, buf, 0);
    return status;
}


uint8_t nrf_wr_long(uint8_t reg, uint8_t len, uint8_t *buf) {
    uint8_t status;

    status = nrfspi_txrx_byte(reg);
    nrfspi_txrx(len, buf, 0);
    return status;
}


uint8_t nrf_rd_long(uint8_t reg, uint8_t len, uint8_t *buf) {
    uint8_t status;

    status = nrfspi_txrx_byte(reg);
    nrfspi_txrx(len, buf, buf);
    return status;
}


uint8_t nrf_regwr(uint8_t reg, uint8_t data) {
    uint8_t status;

    reg = NRF_CMD_REGWR | reg;

    status = nrfspi_txrx_byte(reg);
    nrfspi_txrx_byte(data);

    return status;
}


uint8_t nrf_regrd(uint8_t reg) {
    reg = NRF_CMD_REGRD | reg;

    nrfspi_txrx_byte(reg);
    return nrfspi_txrx_byte(0);
}


uint8_t nrf_flushtx(void) {
    return nrfspi_txrx_byte(NRF_CMD_FLSHT);
}


uint8_t nrf_flushrx(void) {
    return nrfspi_txrx_byte(NRF_CMD_FLSHR);
}


uint8_t nrf_reusetx(void) {
    return nrfspi_txrx_byte(NRF_CMD_REUSE);
}


uint8_t nrf_rxplwidth(void) {
    nrfspi_txrx_byte(NRF_CMD_RXPLW);
    return nrfspi_txrx_byte(0);
}


uint8_t nrf_ackpl(uint8_t pipe, uint8_t len, uint8_t *buf) {
    uint8_t status;
    
    status = nrfspi_txrx_byte(NRF_CMD_RXPLW | pipe);
    nrfspi_txrx(len, buf, 0);
    return status;
}


uint8_t nrf_txnoack(uint8_t len, uint8_t *buf) {
    uint8_t status;

    status = nrfspi_txrx_byte(NRF_CMD_NOACK | pipe);
    nrfspi_txrx(len, buf, 0);
    return status;
}


uint8_t nrf_status(void) {
    return nrfspi_txrx_byte(NRF_CMD_XXNOP | pipe);
}
