/*
 * SPI Mode USART i/f for NRF24L01+
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "nrfspi.h"
#include "nrf.h"

uint8_t volatile *tx_packet_buffer;
uint8_t volatile *rx_packet_buffer;

uint8_t volatile packet_ready = 0;

// initialization
void nrf_init(uint8_t channel, uint8_t *addr, uint8_t volatile *txpbuf, uint8_t volatile *rxpbuf) {
    // initialize SPI layer
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
    nrf_regwr(NRF_REG_CONFIG, NRF_INI_CONFIG);
    nrf_regwr(NRF_REG_EN_AA, NRF_INI_EN_AA);
    nrf_regwr(NRF_REG_EN_RXADDR, NRF_INI_EN_RXADDR);
    nrf_regwr(NRF_REG_SETUP_AW, NRF_INI_SETUP_AW);
    nrf_regwr(NRF_REG_SETUP_RETR, NRF_INI_SETUP_RETR);
    nrf_regwr(NRF_REG_RF_SETUP, NRF_INI_RF_SETUP);
    nrf_regwr(NRF_REG_RX_PW_P0, NRF_INI_RX_PW_P0);

    nrf_regwr(NRF_REG_RF_CH, ( channel << NRF_BIT_RF_CH60 ) );
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


uint8_t nrf_transmit_packet(uint8_t *addr, uint8_t *buf) {
    uint8_t ack;

    // switch to transmit mode
    nrf_ce_off();
    nrf_setmode(NRF_MODE_TX);

    // set transmit address
    nrf_regwr_long(NRF_REG_RX_ADDR_P0, 5, addr);
    nrf_regwr_long(NRF_REG_TX_ADDR, 5, addr);

    // load up the FIFO
    nrf_txpayload(buf);

    // pulse CE to perform transmit
    nrf_ce_on();
    delay_us(15);
    nrf_ce_off();

    // wait until transmit complete
    while (!( nrf_status() & _BV(NRF_BIT_TX_DS) ));

    // switch back to receive mode
    nrf_setmode(NRF_MODE_RX);
    nrf_cs_on();
}


void nrf_start_receiver(void) {
    packet_ready = 0;

    nrf_setmode(NRF_MODE_RX);
    nrf_flushrx();
    nrf_enable_irq();
    nrf_ce_on();
}


void nrf_stop_receiver(void) {
    nrf_ce_off();
    nrf_flushrx();
    nrf_disable_irq();
}


void nrf_wait_for_rxpacket(void) {
    while (!packet_ready);
    return;
}


// nrf24l01+ interrupt handler
ISR(INT0_vect) {
    uint8_t status;

    // when configured as a receiver, indicates that a packet was received by
    // the device and we must read it out

    // TODO: do we have to wait for autoack before disabling the chip?

    // shut off receiver
    nrf_ce_off();
    
    // read out data into buffer
    status = nrf_rxpayload(rx_packet_buffer);

    // clear RX flag
    nrf_regwr(NRF_REG_STATUS, status & ~(_BV(NRF_BIT_RX_DR)));

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


void nrf_setmode(nrf_mode_t mode) {
    if (mode == NRF_MODE_TX) {
        nrf_regwr(NRF_REG_CONFIG, NRF_INI_CONFIG & ~(_BV(NRF_BIT_PRIM_RX)));
    } else {
        nrf_regwr(NRF_REG_CONFIG, NRF_INI_CONFIG | _BV(NRF_BIT_PRIM_RX));
    }
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


uint8_t nrf_regwr_long(uint8_t reg, uint8_t len, uint8_t *buf) {
    uint8_t status;

    status = nrfspi_txrx_byte(reg);
    nrfspi_txrx(len, buf, 0);
    return status;
}


uint8_t nrf_regrd_long(uint8_t reg, uint8_t len, uint8_t *buf) {
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
