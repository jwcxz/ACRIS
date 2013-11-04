#ifndef __NRF_REGMAP_H
#define __NRF_REGMAP_H


// maximum buffer sizes
#define NRF_AD_SIZE_MX   5
#define NRF_PL_SIZE_MX  32


// commands
#define NRF_CMD_REGRD   0x00
#define NRF_CMD_REGWR   0x20

#define NRF_CMD_RXPLR   0x61
#define NRF_CMD_TXPLW   0xA0

#define NRF_CMD_FLSHT   0xE1
#define NRF_CMD_FLSHR   0xE2

#define NRF_CMD_REUSE   0xE3

#define NRF_CMD_RXPLW   0x60

#define NRF_CMD_ACKPL   0xA8

#define NRF_CMD_NOACK   0xB0
#define NRF_CMD_XXNOP   0xFF


// registers and bits
#define NRF_REG_CONFIG          0x00
    #define NRF_BIT_MASK_RX_DR  6
    #define NRF_BIT_MASK_TX_DS  5
    #define NRF_BIT_MASK_MAX_RT 4
    #define NRF_BIT_EN_CRC      3
    #define NRF_BIT_CRCO        2
    #define NRF_BIT_PWR_UP      1
    #define NRF_BIT_PRIM_RX     0

#define NRF_REG_EN_AA       0x01
    #define NRF_BIT_ENAA_P5 5
    #define NRF_BIT_ENAA_P4 4
    #define NRF_BIT_ENAA_P3 3
    #define NRF_BIT_ENAA_P2 2
    #define NRF_BIT_ENAA_P1 1
    #define NRF_BIT_ENAA_P0 0

#define NRF_REG_EN_RXADDR   0x02
    #define NRF_BIT_ERX_P5  5
    #define NRF_BIT_ERX_P4  4
    #define NRF_BIT_ERX_P3  3
    #define NRF_BIT_ERX_P2  2
    #define NRF_BIT_ERX_P1  1
    #define NRF_BIT_ERX_P0  0

#define NRF_REG_SETUP_AW    0x03
    #define NRF_BIT_AW10    0

#define NRF_REG_SETUP_RETR  0x04
    #define NRF_BIT_ARD74   4
    #define NRF_BIT_ARC30   0

#define NRF_REG_RF_CH       0x05
    #define NRF_BIT_RF_CH60 0

#define NRF_REG_RF_SETUP        0x06
    #define NRF_BIT_CONT_WAVE   7
    #define NRF_BIT_REF_DR_LOW  5
    #define NRF_BIT_PLL_LOCK    4
    #define NRF_BIT_RF_DR_HIGH  3
    #define NRF_BIT_RF_PWR21    1

    #define NRF_CFG_RF_GAIN_M18 (0x0 << NRF_BIT_RF_PWR21)
    #define NRF_CFG_RF_GAIN_M12 (0x1 << NRF_BIT_RF_PWR21)
    #define NRF_CFG_RF_GAIN_M6  (0x2 << NRF_BIT_RF_PWR21)
    #define NRF_CFG_RF_GAIN_0   (0x3 << NRF_BIT_RF_PWR21)


#define NRF_REG_STATUS          0x07
    #define NRF_BIT_RX_DR       6
    #define NRF_BIT_TX_DS       5
    #define NRF_BIT_MAX_RT      4
    #define NRF_BIT_RX_P_NO31   1
    #define NRF_BIT_TX_FULL     0

#define NRF_REG_OBSERVE_TX      0x08
    #define NRF_BIT_PLOS_CNT74  4
    #define NRF_BIT_ARC_CNT     0

#define NRF_REG_RPD             0x09
    #define NRF_BIT_RPD         0

#define NRF_REG_RX_ADDR_P0      0x0A
#define NRF_REG_RX_ADDR_P1      0x0B
#define NRF_REG_RX_ADDR_P2      0x0C
#define NRF_REG_RX_ADDR_P3      0x0D
#define NRF_REG_RX_ADDR_P4      0x0E
#define NRF_REG_RX_ADDR_P5      0x0F

#define NRF_REG_TX_ADDR         0x10

#define NRF_REG_RX_PW_P0        0x11
#define NRF_REG_RX_PW_P1        0x12
#define NRF_REG_RX_PW_P2        0x13
#define NRF_REG_RX_PW_P3        0x14
#define NRF_REG_RX_PW_P4        0x15
#define NRF_REG_RX_PW_P5        0x16
    #define NRF_BIT_RX_PW_Px50  0

#define NRF_REG_FIFO_STATUS     0x17
    #define NRF_BIT_FS_TX_REUSE 6
    #define NRF_BIT_FS_TX_FULL  5
    #define NRF_BIT_FS_TX_EMPTY 4
    #define NRF_BIT_FS_RX_FULL  1
    #define NRF_BIT_FS_RX_EMPTY 0

#define NRF_REG_DYNPD           0x1C
    #define NRF_BIT_DPL5        5
    #define NRF_BIT_DPL4        4
    #define NRF_BIT_DPL3        3
    #define NRF_BIT_DPL2        2
    #define NRF_BIT_DPL1        1
    #define NRF_BIT_DPL0        0

#define NRF_REG_FEATURE         0x1D
    #define NRF_BIT_EN_DPL      2
    #define NRF_BIT_EN_ACK_PAY  1
    #define NRF_BIT_EN_DYN_ACK  0


// initial settings
#define NRF_INI_CONFIG      ( _BV(NRF_BIT_MASK_TX_DS)  | \
                              _BV(NRF_BIT_MASK_MAX_RT) | \
                              _BV(NRF_BIT_EN_CRC)      | \
                              _BV(NRF_BIT_PWR_UP) )

#define NRF_INI_SETUP_AW    ( 0x1 << NRF_BIT_AW10 )

#define NRF_INI_SETUP_RETR  ( ( 0xF << NRF_BIT_ARD74 ) | \
                              ( 0x0 << NRF_BIT_ARC30 ) )

//#define NRF_INI_RF_SETUP    ( _BV(NRF_BIT_CONT_WAVE) |

#define NRF_INI_RF_SETUP    ( NRF_CFG_RF_GAIN_0 )

#endif
