/*
 * NRF24L01+ driver targeted at single-transmitter operations
 * jwc :: jwcxz.com
 */

#include "config.h"
#include "nrf.h"
#include "nrfspi.h"

uint8_t *tx_packet_buffer;
uint8_t *rx_packet_buffer;

uint8_t volatile packet_ready = 0;

// initialization
void nrf_init(uint8_t *rxpbuf) {
    // turn off wireless communication
    nrf_ce_off();
    // set up nrf chip enable
    _ON(NRF_CE_DDR, NRF_CE_PIN);

    // initialize SPI layer
    nrfspi_init();
    nrfspi_enable();

    // register buffer addresses
    rx_packet_buffer = rxpbuf;

    // set up interrupt with pull-up for falling edge
    _OFF(NRF_IRQ_DDR, NRF_IRQ_PIN);
    _ON(NRF_IRQ_PRT, NRF_IRQ_PIN);
    EICRA = _BV(ISC01);

    // wait for NRF_REG_CONFIG register to have some of its initial bits set
    // XXX: the datasheet notes that the NRF_BIT_CRC_EN bit is set at power-up
    // and because it's also set in NRF_INI_CONFIG, this will work for both the
    // case when the entire system is powered up from off and when just the
    // microcontroller is reset.
    //
    // This is a cheap hack, but AFAICT there's no way to get surefire
    // information when the chip is ready for initialization.  I wish it would
    // bring MISO low or something when it's ready.  Reading preset addresses
    // doesn't work since they might be changed, the status register can be
    // different depending on whether the system is powering up or the micro is
    // reset, and most of the others are initialized to all 0 or change a lot
    // from the default settings.  The other candidate for this is
    // NRF_REG_RF_SETUP, whose default is 0x7 and initialization is 0x3
    // (diference is NRF_BIT_RF_DR_HIGH)
    while ( !(nrf_regrd(NRF_REG_CONFIG) & _BV(NRF_BIT_EN_CRC)) );

    // perform system configuration
    nrf_regwr(NRF_REG_CONFIG, NRF_INI_CONFIG);
    nrf_regwr(NRF_REG_SETUP_AW, NRF_INI_SETUP_AW);
    nrf_regwr(NRF_REG_SETUP_RETR, NRF_INI_SETUP_RETR);
    nrf_regwr(NRF_REG_RF_SETUP, NRF_INI_RF_SETUP);

    //nrf_regwr(NRF_REG_RX_PW_P0, NRF_INI_RX_PW_P0);
    //nrf_regwr(NRF_REG_RX_PW_P1, NRF_INI_RX_PW_P1);
    //nrf_regwr(NRF_REG_RX_PW_P2, NRF_INI_RX_PW_P2);
    //nrf_regwr(NRF_REG_RX_PW_P3, NRF_INI_RX_PW_P3);
    //nrf_regwr(NRF_REG_RX_PW_P4, NRF_INI_RX_PW_P4);
    //nrf_regwr(NRF_REG_RX_PW_P5, NRF_INI_RX_PW_P5);
}


// application-level commands
void nrf_enable_irq(void) {
    _ON(EIFR, INTF0);
    _ON(EIMSK, INT0);
}

void nrf_disable_irq(void) {
    _OFF(EIMSK, INT0);
    packet_ready = 0;
}


void nrf_set_channel(uint8_t channel) {
    nrf_regwr(NRF_REG_RF_CH, ( (channel & 0x7F) << NRF_BIT_RF_CH60 ) );
}

void nrf_set_power(uint8_t pwr) {
    uint8_t v = nrf_regrd(NRF_REG_RF_SETUP);
    v &= ~(0x3 << NRF_BIT_RF_PWR21);
    v |= pwr & (0x3 << NRF_BIT_RF_PWR21);
    nrf_regwr(NRF_REG_RF_SETUP, v);
}

void nrf_enable_pipe(uint8_t pipe, uint8_t *addr) {
    uint8_t v;

    // set payload width for that pipe
    nrf_regwr(NRF_REG_RX_PW_P0 + pipe, COM_PL_SIZE);

    // enable auto-ack on pipe
    v = nrf_regrd(NRF_REG_EN_AA);
    nrf_regwr(NRF_REG_EN_AA, v | _BV(pipe));

    // enable reception on the selected pipe
    v = nrf_regrd(NRF_REG_EN_RXADDR);
    nrf_regwr(NRF_REG_EN_RXADDR, v | _BV(pipe));

    // set address
    if (pipe <= 1) {
        // use full pipe address
        nrf_regwr_long(NRF_REG_RX_ADDR_P0 + pipe, COM_AD_SIZE, addr);
    } else {
        // use short pipe address
        nrf_regwr(NRF_REG_RX_ADDR_P0 + pipe, addr[0]);
    }
}

void nrf_disable_pipe(uint8_t pipe) {
    uint8_t v = nrf_regrd(NRF_REG_EN_RXADDR);
    nrf_regwr(NRF_REG_EN_RXADDR, v & ~_BV(pipe));
}


uint8_t nrf_transmit_packet(uint8_t *addr, uint8_t *buf) {
    uint8_t ack;

    // switch to transmit mode
    nrf_ce_off();
    nrf_setmode(NRF_MODE_TX);

    // set transmit address
    nrf_regwr_long(NRF_REG_RX_ADDR_P0, COM_AD_SIZE, addr);
    nrf_regwr_long(NRF_REG_TX_ADDR, COM_AD_SIZE, addr);


    // load up the FIFO
    nrf_txpayload(buf);

    // pulse CE to perform transmit
    nrf_ce_on();
    _delay_us(NRF_TX_PULSE_MIN_US);
    nrf_ce_off();

    // wait until transmit complete
    while ( !(nrf_status() & (_BV(NRF_BIT_TX_DS)|_BV(NRF_BIT_MAX_RT))) );

    if ( nrf_status() & _BV(NRF_BIT_TX_DS) ) {
        ack = 1;
    } else {
        ack = 0;
    }

    // clear bits
    nrf_regwr(NRF_REG_STATUS, nrf_status() | _BV(NRF_BIT_TX_DS) | _BV(NRF_BIT_MAX_RT));

    // switch back to receive mode
    nrf_setmode(NRF_MODE_RX);
    nrf_ce_on();

    // return 1 for successful transmission, 0 otherwise
    return ack;
}


void nrf_start_receiver(void) {
    packet_ready = 0;

    nrf_setmode(NRF_MODE_RX);
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
}

uint8_t nrf_isready_packet(void) {
    return packet_ready;
}

void nrf_accept_packet(void) {
    packet_ready = 0;
    nrf_enable_irq();
}


// nrf24l01+ interrupt handler
ISR(INT0_vect) {
    uint8_t status;

    // when configured as a receiver, indicates that a packet was received by
    // the device and we must read it out

    // shut off receiver
    nrf_ce_off();

    // shut off interrupt
    nrf_disable_irq();

    // read out data into buffer
    status = nrf_rxpayload(rx_packet_buffer);
    dbg_set(status & 0xF);

    // clear RX flag
    nrf_regwr(NRF_REG_STATUS, status | _BV(NRF_BIT_RX_DR));

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
        nrf_flushtx();

        nrf_regwr(NRF_REG_STATUS, _BV(NRF_BIT_RX_DR) | _BV(NRF_BIT_TX_DS) |
                                  _BV(NRF_BIT_MAX_RT));

        nrf_regwr(NRF_REG_CONFIG, (NRF_INI_CONFIG & ~(_BV(NRF_BIT_PRIM_RX))) |
                                  _BV(NRF_BIT_PWR_UP));
    } else if (mode == NRF_MODE_RX ) {
        nrf_flushrx();

        nrf_regwr(NRF_REG_STATUS, _BV(NRF_BIT_RX_DR) | _BV(NRF_BIT_TX_DS)
                                  | _BV(NRF_BIT_MAX_RT));

        nrf_regwr(NRF_REG_CONFIG, NRF_INI_CONFIG | _BV(NRF_BIT_PWR_UP) |
                                  _BV(NRF_BIT_PRIM_RX));
    } else {
        nrf_ce_off();
        nrf_regwr(NRF_REG_CONFIG, NRF_INI_CONFIG & ~(_BV(NRF_BIT_PWR_UP)));
    }
}


uint8_t nrf_txpayload(uint8_t *buf) {
    uint8_t status;

    nrfspi_cs_en();
    status = nrfspi_txrx_byte(NRF_CMD_TXPLW);
    nrfspi_txrx(COM_PL_SIZE, buf, 0);
    nrfspi_cs_ds();

    return status;
}


uint8_t nrf_rxpayload(uint8_t *buf) {
    uint8_t status;

    nrfspi_cs_en();
    status = nrfspi_txrx_byte(NRF_CMD_RXPLR);
    nrfspi_txrx(COM_PL_SIZE, buf, buf);
    nrfspi_cs_ds();

    return status;
}


uint8_t nrf_regwr_long(uint8_t reg, uint8_t len, uint8_t *buf) {
    uint8_t status;

    nrfspi_cs_en();
    status = nrfspi_txrx_byte(reg);
    nrfspi_txrx(len, buf, 0);
    nrfspi_cs_ds();

    return status;
}


uint8_t nrf_regrd_long(uint8_t reg, uint8_t len, uint8_t *buf) {
    uint8_t status;

    nrfspi_cs_en();
    status = nrfspi_txrx_byte(reg);
    nrfspi_txrx(len, buf, buf);
    nrfspi_cs_ds();

    return status;
}


uint8_t nrf_regwr(uint8_t reg, uint8_t data) {
    uint8_t status;
    reg = NRF_CMD_REGWR | reg;

    nrfspi_cs_en();
    status = nrfspi_txrx_byte(reg);
    nrfspi_txrx_byte(data);
    nrfspi_cs_ds();

    return status;
}


uint8_t nrf_regrd(uint8_t reg) {
    uint8_t data;
    reg = NRF_CMD_REGRD | reg;

    nrfspi_cs_en();
    nrfspi_txrx_byte(reg);
    data = nrfspi_txrx_byte(0);
    nrfspi_cs_ds();

    return data;
}


uint8_t nrf_flushtx(void) {
    uint8_t status;

    nrfspi_cs_en();
    status = nrfspi_txrx_byte(NRF_CMD_FLSHT);
    nrfspi_cs_ds();

    return status;
}


uint8_t nrf_flushrx(void) {
    uint8_t status;

    nrfspi_cs_en();
    status = nrfspi_txrx_byte(NRF_CMD_FLSHR);
    nrfspi_cs_ds();

    return status;
}


uint8_t nrf_reusetx(void) {
    uint8_t status;

    nrfspi_cs_en();
    status = nrfspi_txrx_byte(NRF_CMD_REUSE);
    nrfspi_cs_ds();

    return status;
}


uint8_t nrf_rxplwidth(void) {
    uint8_t ret;

    nrfspi_cs_en();
    nrfspi_txrx_byte(NRF_CMD_RXPLW);
    ret = nrfspi_txrx_byte(0);
    nrfspi_cs_ds();

    return ret;
}


uint8_t nrf_ackpl(uint8_t pipe, uint8_t len, uint8_t *buf) {
    uint8_t status;

    nrfspi_cs_en();
    status = nrfspi_txrx_byte(NRF_CMD_RXPLW | pipe);
    nrfspi_txrx(len, buf, 0);
    nrfspi_cs_ds();

    return status;
}


uint8_t nrf_txnoack(uint8_t pipe, uint8_t len, uint8_t *buf) {
    uint8_t status;

    nrfspi_cs_en();
    status = nrfspi_txrx_byte(NRF_CMD_NOACK | pipe);
    nrfspi_txrx(len, buf, 0);
    nrfspi_cs_ds();

    return status;
}


uint8_t nrf_status(void) {
    uint8_t status;

    nrfspi_cs_en();
    status = nrfspi_txrx_byte(NRF_CMD_XXNOP);
    nrfspi_cs_ds();

    return status;
}
