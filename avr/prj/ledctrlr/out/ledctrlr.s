
out/ledctrlr.out:     file format elf32-avr


Disassembly of section .text:

00000000 <__vectors>:
   0:	0c 94 34 00 	jmp	0x68	; 0x68 <__ctors_end>
   4:	0c 94 d6 04 	jmp	0x9ac	; 0x9ac <__vector_1>
   8:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
   c:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  10:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  14:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  18:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  1c:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  20:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  24:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  28:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  2c:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  30:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  34:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  38:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  3c:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  40:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  44:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  48:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  4c:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  50:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  54:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  58:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  5c:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  60:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>
  64:	0c 94 46 00 	jmp	0x8c	; 0x8c <__bad_interrupt>

00000068 <__ctors_end>:
  68:	11 24       	eor	r1, r1
  6a:	1f be       	out	0x3f, r1	; 63
  6c:	cf ef       	ldi	r28, 0xFF	; 255
  6e:	d4 e0       	ldi	r29, 0x04	; 4
  70:	de bf       	out	0x3e, r29	; 62
  72:	cd bf       	out	0x3d, r28	; 61

00000074 <__do_clear_bss>:
  74:	11 e0       	ldi	r17, 0x01	; 1
  76:	a0 e0       	ldi	r26, 0x00	; 0
  78:	b1 e0       	ldi	r27, 0x01	; 1
  7a:	01 c0       	rjmp	.+2      	; 0x7e <.do_clear_bss_start>

0000007c <.do_clear_bss_loop>:
  7c:	1d 92       	st	X+, r1

0000007e <.do_clear_bss_start>:
  7e:	a3 38       	cpi	r26, 0x83	; 131
  80:	b1 07       	cpc	r27, r17
  82:	e1 f7       	brne	.-8      	; 0x7c <.do_clear_bss_loop>
  84:	0e 94 83 06 	call	0xd06	; 0xd06 <main>
  88:	0c 94 c0 06 	jmp	0xd80	; 0xd80 <_exit>

0000008c <__bad_interrupt>:
  8c:	0c 94 00 00 	jmp	0	; 0x0 <__vectors>

00000090 <process_packet>:

	return 0;
}

void process_packet(void) {
    led_action(rxbuf[0], &(rxbuf[1]));
  90:	62 e0       	ldi	r22, 0x02	; 2
  92:	71 e0       	ldi	r23, 0x01	; 1
  94:	80 91 01 01 	lds	r24, 0x0101
  98:	0c 94 76 01 	jmp	0x2ec	; 0x2ec <led_action>

0000009c <dbg_set>:

#include "config.h"
#include "dbg.h"

void dbg_set(uint8_t val) {
    uint8_t tmp = val & 0xF;
  9c:	8f 70       	andi	r24, 0x0F	; 15
    DBGLED_PRT |= tmp;
  9e:	98 b1       	in	r25, 0x08	; 8
  a0:	98 2b       	or	r25, r24
  a2:	98 b9       	out	0x08, r25	; 8
    DBGLED_PRT &= 0xF0 | tmp;
  a4:	98 b1       	in	r25, 0x08	; 8
  a6:	80 6f       	ori	r24, 0xF0	; 240
  a8:	89 23       	and	r24, r25
  aa:	88 b9       	out	0x08, r24	; 8
  ac:	08 95       	ret

000000ae <dbg_on>:
}

void dbg_on(uint8_t val) {
    _ON(DBGLED_PRT, val);
  ae:	98 b1       	in	r25, 0x08	; 8
  b0:	21 e0       	ldi	r18, 0x01	; 1
  b2:	30 e0       	ldi	r19, 0x00	; 0
  b4:	08 2e       	mov	r0, r24
  b6:	01 c0       	rjmp	.+2      	; 0xba <dbg_on+0xc>
  b8:	22 0f       	add	r18, r18
  ba:	0a 94       	dec	r0
  bc:	ea f7       	brpl	.-6      	; 0xb8 <dbg_on+0xa>
  be:	92 2b       	or	r25, r18
  c0:	98 b9       	out	0x08, r25	; 8
  c2:	08 95       	ret

000000c4 <dbg_off>:
}

void dbg_off(uint8_t val) {
    _OFF(DBGLED_PRT, val);
  c4:	98 b1       	in	r25, 0x08	; 8
  c6:	21 e0       	ldi	r18, 0x01	; 1
  c8:	30 e0       	ldi	r19, 0x00	; 0
  ca:	08 2e       	mov	r0, r24
  cc:	01 c0       	rjmp	.+2      	; 0xd0 <dbg_off+0xc>
  ce:	22 0f       	add	r18, r18
  d0:	0a 94       	dec	r0
  d2:	ea f7       	brpl	.-6      	; 0xce <dbg_off+0xa>
  d4:	20 95       	com	r18
  d6:	29 23       	and	r18, r25
  d8:	28 b9       	out	0x08, r18	; 8
  da:	08 95       	ret

000000dc <dbg_init>:
}

void dbg_init(void) {
    // this requires the debug bank to be the bottom 4 bits of a bank
    // TODO: make it more advanced
    DBGLED_DDR |= 0x0F;
  dc:	87 b1       	in	r24, 0x07	; 7
  de:	8f 60       	ori	r24, 0x0F	; 15
  e0:	87 b9       	out	0x07, r24	; 7
    DBGLED_PRT &= 0xF0; // clear leds
  e2:	88 b1       	in	r24, 0x08	; 8
  e4:	80 7f       	andi	r24, 0xF0	; 240
  e6:	88 b9       	out	0x08, r24	; 8
  e8:	08 95       	ret

000000ea <eeprom_get_addr>:
 */

#include "config.h"
#include "eeprom.h"

void eeprom_get_addr(uint8_t *buf) {
  ea:	1f 93       	push	r17
  ec:	cf 93       	push	r28
  ee:	df 93       	push	r29
  f0:	ec 01       	movw	r28, r24
    uint8_t i;

    for ( i=0 ; i<COM_AD_SIZE ; i++ ) {
  f2:	10 e0       	ldi	r17, 0x00	; 0
        eeprom_busy_wait();
  f4:	f9 99       	sbic	0x1f, 1	; 31
  f6:	fe cf       	rjmp	.-4      	; 0xf4 <eeprom_get_addr+0xa>
        buf[i] = eeprom_read_byte(EEPROM_INST_ADDR);
  f8:	80 e0       	ldi	r24, 0x00	; 0
  fa:	90 e0       	ldi	r25, 0x00	; 0
  fc:	0e 94 aa 06 	call	0xd54	; 0xd54 <__eerd_byte_m168p>
 100:	89 93       	st	Y+, r24
#include "eeprom.h"

void eeprom_get_addr(uint8_t *buf) {
    uint8_t i;

    for ( i=0 ; i<COM_AD_SIZE ; i++ ) {
 102:	1f 5f       	subi	r17, 0xFF	; 255
 104:	13 30       	cpi	r17, 0x03	; 3
 106:	b1 f7       	brne	.-20     	; 0xf4 <eeprom_get_addr+0xa>
        eeprom_busy_wait();
        buf[i] = eeprom_read_byte(EEPROM_INST_ADDR);
    }
}
 108:	df 91       	pop	r29
 10a:	cf 91       	pop	r28
 10c:	1f 91       	pop	r17
 10e:	08 95       	ret

00000110 <eeprom_get_chan>:


void eeprom_get_chan(uint8_t *buf) {
 110:	cf 93       	push	r28
 112:	df 93       	push	r29
 114:	ec 01       	movw	r28, r24
    eeprom_busy_wait();
 116:	f9 99       	sbic	0x1f, 1	; 31
 118:	fe cf       	rjmp	.-4      	; 0x116 <eeprom_get_chan+0x6>
    buf[0] = eeprom_read_byte(EEPROM_INST_CHAN);
 11a:	84 e0       	ldi	r24, 0x04	; 4
 11c:	90 e0       	ldi	r25, 0x00	; 0
 11e:	0e 94 aa 06 	call	0xd54	; 0xd54 <__eerd_byte_m168p>
 122:	88 83       	st	Y, r24
}
 124:	df 91       	pop	r29
 126:	cf 91       	pop	r28
 128:	08 95       	ret

0000012a <eeprom_read>:


void eeprom_read(uint8_t *offset, uint8_t len, uint8_t *buf) {
 12a:	cf 92       	push	r12
 12c:	df 92       	push	r13
 12e:	ef 92       	push	r14
 130:	ff 92       	push	r15
 132:	0f 93       	push	r16
 134:	1f 93       	push	r17
 136:	cf 93       	push	r28
 138:	df 93       	push	r29
 13a:	ec 01       	movw	r28, r24
 13c:	c6 2e       	mov	r12, r22
 13e:	7a 01       	movw	r14, r20
    uint8_t i = 0;

    while (len--) {
 140:	66 23       	and	r22, r22
 142:	79 f0       	breq	.+30     	; 0x162 <eeprom_read+0x38>
    buf[0] = eeprom_read_byte(EEPROM_INST_CHAN);
}


void eeprom_read(uint8_t *offset, uint8_t len, uint8_t *buf) {
    uint8_t i = 0;
 144:	d1 2c       	mov	r13, r1

    while (len--) {
        eeprom_busy_wait();
 146:	f9 99       	sbic	0x1f, 1	; 31
 148:	fe cf       	rjmp	.-4      	; 0x146 <eeprom_read+0x1c>

        buf[i] = eeprom_read_byte(offset);
 14a:	87 01       	movw	r16, r14
 14c:	0d 0d       	add	r16, r13
 14e:	11 1d       	adc	r17, r1
 150:	ce 01       	movw	r24, r28
 152:	0e 94 aa 06 	call	0xd54	; 0xd54 <__eerd_byte_m168p>
 156:	f8 01       	movw	r30, r16
 158:	80 83       	st	Z, r24
        offset = &(offset[1]);
 15a:	21 96       	adiw	r28, 0x01	; 1
        i++;
 15c:	d3 94       	inc	r13


void eeprom_read(uint8_t *offset, uint8_t len, uint8_t *buf) {
    uint8_t i = 0;

    while (len--) {
 15e:	dc 10       	cpse	r13, r12
 160:	f2 cf       	rjmp	.-28     	; 0x146 <eeprom_read+0x1c>

        buf[i] = eeprom_read_byte(offset);
        offset = &(offset[1]);
        i++;
    }
}
 162:	df 91       	pop	r29
 164:	cf 91       	pop	r28
 166:	1f 91       	pop	r17
 168:	0f 91       	pop	r16
 16a:	ff 90       	pop	r15
 16c:	ef 90       	pop	r14
 16e:	df 90       	pop	r13
 170:	cf 90       	pop	r12
 172:	08 95       	ret

00000174 <eeprom_write>:


void eeprom_write(uint8_t *offset, uint8_t len, uint8_t *buf) {
 174:	ef 92       	push	r14
 176:	ff 92       	push	r15
 178:	0f 93       	push	r16
 17a:	1f 93       	push	r17
 17c:	cf 93       	push	r28
 17e:	df 93       	push	r29
 180:	ec 01       	movw	r28, r24
 182:	e6 2e       	mov	r14, r22
 184:	8a 01       	movw	r16, r20
    uint8_t i = 0;

    while (len--) {
 186:	66 23       	and	r22, r22
 188:	71 f0       	breq	.+28     	; 0x1a6 <eeprom_write+0x32>
    }
}


void eeprom_write(uint8_t *offset, uint8_t len, uint8_t *buf) {
    uint8_t i = 0;
 18a:	f1 2c       	mov	r15, r1

    while (len--) {
        eeprom_busy_wait();
 18c:	f9 99       	sbic	0x1f, 1	; 31
 18e:	fe cf       	rjmp	.-4      	; 0x18c <eeprom_write+0x18>

        eeprom_write_byte(offset, buf[i]);
 190:	f8 01       	movw	r30, r16
 192:	ef 0d       	add	r30, r15
 194:	f1 1d       	adc	r31, r1
 196:	60 81       	ld	r22, Z
 198:	ce 01       	movw	r24, r28
 19a:	0e 94 b2 06 	call	0xd64	; 0xd64 <__eewr_byte_m168p>
        offset = &(offset[1]);
 19e:	21 96       	adiw	r28, 0x01	; 1
        i++;
 1a0:	f3 94       	inc	r15


void eeprom_write(uint8_t *offset, uint8_t len, uint8_t *buf) {
    uint8_t i = 0;

    while (len--) {
 1a2:	ef 10       	cpse	r14, r15
 1a4:	f3 cf       	rjmp	.-26     	; 0x18c <eeprom_write+0x18>

        eeprom_write_byte(offset, buf[i]);
        offset = &(offset[1]);
        i++;
    }
}
 1a6:	df 91       	pop	r29
 1a8:	cf 91       	pop	r28
 1aa:	1f 91       	pop	r17
 1ac:	0f 91       	pop	r16
 1ae:	ff 90       	pop	r15
 1b0:	ef 90       	pop	r14
 1b2:	08 95       	ret

000001b4 <ledset_set>:
#include "ledset.h"
#include "tlc.h"

// set a single RGB LED by setting the appropriate bank of outputs
// ledno is 0-4, channel is 0-2 (R,G,B)
void ledset_set(uint8_t ledno, uint8_t channel, uint16_t value) {
 1b4:	0f 93       	push	r16
 1b6:	1f 93       	push	r17
 1b8:	cf 93       	push	r28
 1ba:	df 93       	push	r29
 1bc:	ea 01       	movw	r28, r20
     * TLC          0                     1                     2
     * ADR 012 345 678 9AB CDE   012 345 678 9AB CDE   012 345 678 9AB CDE
     * LED R0R G0G B0B R1R G1G   B1B R2R G2G B2B R3R   G3G B3B R4R G4G B4B
     */

    switch (ledno) {
 1be:	82 30       	cpi	r24, 0x02	; 2
 1c0:	09 f4       	brne	.+2      	; 0x1c4 <ledset_set+0x10>
 1c2:	5b c0       	rjmp	.+182    	; 0x27a <ledset_set+0xc6>
 1c4:	b8 f4       	brcc	.+46     	; 0x1f4 <ledset_set+0x40>
 1c6:	88 23       	and	r24, r24
 1c8:	09 f4       	brne	.+2      	; 0x1cc <ledset_set+0x18>
 1ca:	44 c0       	rjmp	.+136    	; 0x254 <ledset_set+0xa0>
 1cc:	81 30       	cpi	r24, 0x01	; 1
 1ce:	69 f4       	brne	.+26     	; 0x1ea <ledset_set+0x36>
            }

            break;

        case 1:
            if (channel <= 1) {
 1d0:	62 30       	cpi	r22, 0x02	; 2
 1d2:	08 f4       	brcc	.+2      	; 0x1d6 <ledset_set+0x22>
 1d4:	7a c0       	rjmp	.+244    	; 0x2ca <ledset_set+0x116>
 1d6:	11 e0       	ldi	r17, 0x01	; 1
                }
            } else {
                // B

                for (i=1 ; i<=3 ; i++) {
                    tlc_set(tlc[1], i, value);
 1d8:	ae 01       	movw	r20, r28
 1da:	61 2f       	mov	r22, r17
 1dc:	82 e3       	ldi	r24, 0x32	; 50
 1de:	91 e0       	ldi	r25, 0x01	; 1
 1e0:	0e 94 76 03 	call	0x6ec	; 0x6ec <tlc_set>
                    tlc_set(tlc[0], 3*3+3*channel+i, value);
                }
            } else {
                // B

                for (i=1 ; i<=3 ; i++) {
 1e4:	1f 5f       	subi	r17, 0xFF	; 255
 1e6:	14 30       	cpi	r17, 0x04	; 4
 1e8:	b9 f7       	brne	.-18     	; 0x1d8 <ledset_set+0x24>

        default:
            break;
    }
#endif
}
 1ea:	df 91       	pop	r29
 1ec:	cf 91       	pop	r28
 1ee:	1f 91       	pop	r17
 1f0:	0f 91       	pop	r16
 1f2:	08 95       	ret
     * TLC          0                     1                     2
     * ADR 012 345 678 9AB CDE   012 345 678 9AB CDE   012 345 678 9AB CDE
     * LED R0R G0G B0B R1R G1G   B1B R2R G2G B2B R3R   G3G B3B R4R G4G B4B
     */

    switch (ledno) {
 1f4:	83 30       	cpi	r24, 0x03	; 3
 1f6:	b9 f0       	breq	.+46     	; 0x226 <ledset_set+0x72>
 1f8:	84 30       	cpi	r24, 0x04	; 4
 1fa:	b9 f7       	brne	.-18     	; 0x1ea <ledset_set+0x36>
 1fc:	86 2f       	mov	r24, r22
 1fe:	88 0f       	add	r24, r24
 200:	86 0f       	add	r24, r22
 202:	17 e0       	ldi	r17, 0x07	; 7
 204:	18 0f       	add	r17, r24
 206:	0a e0       	ldi	r16, 0x0A	; 10
 208:	08 0f       	add	r16, r24
            
            break;

        case 4:
            for (i=1 ; i<=3 ; i++) {
                tlc_set(tlc[2], 3*2+3*channel+i, value);
 20a:	ae 01       	movw	r20, r28
 20c:	61 2f       	mov	r22, r17
 20e:	8a e4       	ldi	r24, 0x4A	; 74
 210:	91 e0       	ldi	r25, 0x01	; 1
 212:	0e 94 76 03 	call	0x6ec	; 0x6ec <tlc_set>
 216:	1f 5f       	subi	r17, 0xFF	; 255
            }
            
            break;

        case 4:
            for (i=1 ; i<=3 ; i++) {
 218:	10 13       	cpse	r17, r16
 21a:	f7 cf       	rjmp	.-18     	; 0x20a <ledset_set+0x56>

        default:
            break;
    }
#endif
}
 21c:	df 91       	pop	r29
 21e:	cf 91       	pop	r28
 220:	1f 91       	pop	r17
 222:	0f 91       	pop	r16
 224:	08 95       	ret
            }

            break;

        case 3:
            if ( channel == 0 ) {
 226:	61 11       	cpse	r22, r1
 228:	3e c0       	rjmp	.+124    	; 0x2a6 <ledset_set+0xf2>
                // R
                for (i=1 ; i<=3 ; i++) {
                    tlc_set(tlc[1], 3*4+i, value);
 22a:	6d e0       	ldi	r22, 0x0D	; 13
 22c:	82 e3       	ldi	r24, 0x32	; 50
 22e:	91 e0       	ldi	r25, 0x01	; 1
 230:	0e 94 76 03 	call	0x6ec	; 0x6ec <tlc_set>
 234:	ae 01       	movw	r20, r28
 236:	6e e0       	ldi	r22, 0x0E	; 14
 238:	82 e3       	ldi	r24, 0x32	; 50
 23a:	91 e0       	ldi	r25, 0x01	; 1
 23c:	0e 94 76 03 	call	0x6ec	; 0x6ec <tlc_set>
 240:	ae 01       	movw	r20, r28
 242:	6f e0       	ldi	r22, 0x0F	; 15
 244:	82 e3       	ldi	r24, 0x32	; 50
 246:	91 e0       	ldi	r25, 0x01	; 1

        default:
            break;
    }
#endif
}
 248:	df 91       	pop	r29
 24a:	cf 91       	pop	r28
 24c:	1f 91       	pop	r17
 24e:	0f 91       	pop	r16

        case 3:
            if ( channel == 0 ) {
                // R
                for (i=1 ; i<=3 ; i++) {
                    tlc_set(tlc[1], 3*4+i, value);
 250:	0c 94 76 03 	jmp	0x6ec	; 0x6ec <tlc_set>
 254:	06 2f       	mov	r16, r22
 256:	00 0f       	add	r16, r16
 258:	06 0f       	add	r16, r22
     * TLC          0                     1                     2
     * ADR 012 345 678 9AB CDE   012 345 678 9AB CDE   012 345 678 9AB CDE
     * LED R0R G0G B0B R1R G1G   B1B R2R G2G B2B R3R   G3G B3B R4R G4G B4B
     */

    switch (ledno) {
 25a:	11 e0       	ldi	r17, 0x01	; 1
 25c:	61 2f       	mov	r22, r17
 25e:	60 0f       	add	r22, r16
        case 0:
            for (i=1 ; i<=3 ; i++) {
                tlc_set(tlc[0], 3*channel+i, value);
 260:	ae 01       	movw	r20, r28
 262:	8a e1       	ldi	r24, 0x1A	; 26
 264:	91 e0       	ldi	r25, 0x01	; 1
 266:	0e 94 76 03 	call	0x6ec	; 0x6ec <tlc_set>
     * LED R0R G0G B0B R1R G1G   B1B R2R G2G B2B R3R   G3G B3B R4R G4G B4B
     */

    switch (ledno) {
        case 0:
            for (i=1 ; i<=3 ; i++) {
 26a:	1f 5f       	subi	r17, 0xFF	; 255
 26c:	14 30       	cpi	r17, 0x04	; 4
 26e:	b1 f7       	brne	.-20     	; 0x25c <ledset_set+0xa8>

        default:
            break;
    }
#endif
}
 270:	df 91       	pop	r29
 272:	cf 91       	pop	r28
 274:	1f 91       	pop	r17
 276:	0f 91       	pop	r16
 278:	08 95       	ret
 27a:	70 e0       	ldi	r23, 0x00	; 0
 27c:	6f 5f       	subi	r22, 0xFF	; 255
 27e:	7f 4f       	sbci	r23, 0xFF	; 255
 280:	06 2f       	mov	r16, r22
 282:	00 0f       	add	r16, r16
 284:	06 0f       	add	r16, r22
     * TLC          0                     1                     2
     * ADR 012 345 678 9AB CDE   012 345 678 9AB CDE   012 345 678 9AB CDE
     * LED R0R G0G B0B R1R G1G   B1B R2R G2G B2B R3R   G3G B3B R4R G4G B4B
     */

    switch (ledno) {
 286:	11 e0       	ldi	r17, 0x01	; 1
 288:	61 2f       	mov	r22, r17
 28a:	60 0f       	add	r22, r16
            
            break;

        case 2:
            for (i=1 ; i<=3 ; i++) {
                tlc_set(tlc[1], 3*1+3*channel+i, value);
 28c:	ae 01       	movw	r20, r28
 28e:	82 e3       	ldi	r24, 0x32	; 50
 290:	91 e0       	ldi	r25, 0x01	; 1
 292:	0e 94 76 03 	call	0x6ec	; 0x6ec <tlc_set>
            }
            
            break;

        case 2:
            for (i=1 ; i<=3 ; i++) {
 296:	1f 5f       	subi	r17, 0xFF	; 255
 298:	14 30       	cpi	r17, 0x04	; 4
 29a:	b1 f7       	brne	.-20     	; 0x288 <ledset_set+0xd4>

        default:
            break;
    }
#endif
}
 29c:	df 91       	pop	r29
 29e:	cf 91       	pop	r28
 2a0:	1f 91       	pop	r17
 2a2:	0f 91       	pop	r16
 2a4:	08 95       	ret
 2a6:	70 e0       	ldi	r23, 0x00	; 0
 2a8:	61 50       	subi	r22, 0x01	; 1
 2aa:	71 09       	sbc	r23, r1
 2ac:	06 2f       	mov	r16, r22
 2ae:	00 0f       	add	r16, r16
 2b0:	06 0f       	add	r16, r22
            }

            break;

        case 3:
            if ( channel == 0 ) {
 2b2:	11 e0       	ldi	r17, 0x01	; 1
 2b4:	61 2f       	mov	r22, r17
 2b6:	60 0f       	add	r22, r16
                    tlc_set(tlc[1], 3*4+i, value);
                }
            } else {
                // G, B
                for (i=1 ; i<=3 ; i++) {
                    tlc_set(tlc[2], 3*(channel-1)+i, value);
 2b8:	ae 01       	movw	r20, r28
 2ba:	8a e4       	ldi	r24, 0x4A	; 74
 2bc:	91 e0       	ldi	r25, 0x01	; 1
 2be:	0e 94 76 03 	call	0x6ec	; 0x6ec <tlc_set>
                for (i=1 ; i<=3 ; i++) {
                    tlc_set(tlc[1], 3*4+i, value);
                }
            } else {
                // G, B
                for (i=1 ; i<=3 ; i++) {
 2c2:	1f 5f       	subi	r17, 0xFF	; 255
 2c4:	14 30       	cpi	r17, 0x04	; 4
 2c6:	b1 f7       	brne	.-20     	; 0x2b4 <ledset_set+0x100>
 2c8:	90 cf       	rjmp	.-224    	; 0x1ea <ledset_set+0x36>
 2ca:	86 2f       	mov	r24, r22
 2cc:	88 0f       	add	r24, r24
 2ce:	86 0f       	add	r24, r22
 2d0:	1a e0       	ldi	r17, 0x0A	; 10
 2d2:	18 0f       	add	r17, r24
 2d4:	0d e0       	ldi	r16, 0x0D	; 13
 2d6:	08 0f       	add	r16, r24

        case 1:
            if (channel <= 1) {
                // R, G
                for (i=1 ; i<=3 ; i++) {
                    tlc_set(tlc[0], 3*3+3*channel+i, value);
 2d8:	ae 01       	movw	r20, r28
 2da:	61 2f       	mov	r22, r17
 2dc:	8a e1       	ldi	r24, 0x1A	; 26
 2de:	91 e0       	ldi	r25, 0x01	; 1
 2e0:	0e 94 76 03 	call	0x6ec	; 0x6ec <tlc_set>
 2e4:	1f 5f       	subi	r17, 0xFF	; 255
            break;

        case 1:
            if (channel <= 1) {
                // R, G
                for (i=1 ; i<=3 ; i++) {
 2e6:	10 13       	cpse	r17, r16
 2e8:	f7 cf       	rjmp	.-18     	; 0x2d8 <ledset_set+0x124>
 2ea:	7f cf       	rjmp	.-258    	; 0x1ea <ledset_set+0x36>

000002ec <led_action>:
#include "led.h"
#include "ledset.h"
#include "tlc.h"


void led_action(uint8_t action, uint8_t args[]) {
 2ec:	cf 92       	push	r12
 2ee:	df 92       	push	r13
 2f0:	ef 92       	push	r14
 2f2:	ff 92       	push	r15
 2f4:	0f 93       	push	r16
 2f6:	1f 93       	push	r17
 2f8:	cf 93       	push	r28
 2fa:	df 93       	push	r29
 2fc:	eb 01       	movw	r28, r22
    // interpret the controller command and arguments
    
    uint8_t led, color;
    uint16_t red, grn, blu;

    switch(action) {
 2fe:	81 30       	cpi	r24, 0x01	; 1
 300:	09 f4       	brne	.+2      	; 0x304 <led_action+0x18>
 302:	91 c0       	rjmp	.+290    	; 0x426 <led_action+0x13a>
 304:	08 f4       	brcc	.+2      	; 0x308 <led_action+0x1c>
 306:	73 c0       	rjmp	.+230    	; 0x3ee <led_action+0x102>
 308:	80 31       	cpi	r24, 0x10	; 16
 30a:	c1 f1       	breq	.+112    	; 0x37c <led_action+0x90>
 30c:	81 31       	cpi	r24, 0x11	; 17
 30e:	09 f0       	breq	.+2      	; 0x312 <led_action+0x26>
 310:	65 c0       	rjmp	.+202    	; 0x3dc <led_action+0xf0>
}

// convert two 8-bit values to a 12-bit value
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
 312:	88 81       	ld	r24, Y
 314:	8f 70       	andi	r24, 0x0F	; 15
 316:	c8 2e       	mov	r12, r24
 318:	d1 2c       	mov	r13, r1
 31a:	dc 2c       	mov	r13, r12
 31c:	cc 24       	eor	r12, r12
 31e:	89 81       	ldd	r24, Y+1	; 0x01
 320:	c8 2a       	or	r12, r24
            break;

        case CMD_HDALL:
            // 0/R R/R G/G G/B B/B
            red = led_hd_lword(args[0], args[1]);
            grn = led_hd_rword(args[2], args[3]);
 322:	0b 81       	ldd	r16, Y+3	; 0x03
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
}
__inline__ uint16_t led_hd_rword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) first) << 4 ) | ( (second & 0xF0) >> 4 );
 324:	80 2f       	mov	r24, r16
 326:	82 95       	swap	r24
 328:	8f 70       	andi	r24, 0x0F	; 15
 32a:	ea 80       	ldd	r14, Y+2	; 0x02
 32c:	90 e1       	ldi	r25, 0x10	; 16
 32e:	e9 9e       	mul	r14, r25
 330:	70 01       	movw	r14, r0
 332:	11 24       	eor	r1, r1
 334:	e8 2a       	or	r14, r24
}

// convert two 8-bit values to a 12-bit value
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
 336:	0f 70       	andi	r16, 0x0F	; 15
 338:	10 e0       	ldi	r17, 0x00	; 0
 33a:	10 2f       	mov	r17, r16
 33c:	00 27       	eor	r16, r16
 33e:	8c 81       	ldd	r24, Y+4	; 0x04
 340:	08 2b       	or	r16, r24
            // 0/R R/R G/G G/B B/B
            red = led_hd_lword(args[0], args[1]);
            grn = led_hd_rword(args[2], args[3]);
            blu = led_hd_lword(args[3], args[4]);

            for ( led=0 ; led<5 ; led++ ) {
 342:	c0 e0       	ldi	r28, 0x00	; 0
                ledset_set(led, 0, red);
 344:	a6 01       	movw	r20, r12
 346:	60 e0       	ldi	r22, 0x00	; 0
 348:	8c 2f       	mov	r24, r28
 34a:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
                ledset_set(led, 1, grn);
 34e:	a7 01       	movw	r20, r14
 350:	61 e0       	ldi	r22, 0x01	; 1
 352:	8c 2f       	mov	r24, r28
 354:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
                ledset_set(led, 2, blu);
 358:	a8 01       	movw	r20, r16
 35a:	62 e0       	ldi	r22, 0x02	; 2
 35c:	8c 2f       	mov	r24, r28
 35e:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
            // 0/R R/R G/G G/B B/B
            red = led_hd_lword(args[0], args[1]);
            grn = led_hd_rword(args[2], args[3]);
            blu = led_hd_lword(args[3], args[4]);

            for ( led=0 ; led<5 ; led++ ) {
 362:	cf 5f       	subi	r28, 0xFF	; 255
 364:	c5 30       	cpi	r28, 0x05	; 5
 366:	71 f7       	brne	.-36     	; 0x344 <led_action+0x58>
            return;
            break;
    }
        
    tlc_drive();
}
 368:	df 91       	pop	r29
 36a:	cf 91       	pop	r28
 36c:	1f 91       	pop	r17
 36e:	0f 91       	pop	r16
 370:	ff 90       	pop	r15
 372:	ef 90       	pop	r14
 374:	df 90       	pop	r13
 376:	cf 90       	pop	r12
        default:
            return;
            break;
    }
        
    tlc_drive();
 378:	0c 94 49 03 	jmp	0x692	; 0x692 <tlc_drive>
            break;

        case CMD_LDALL:
            // R G B

            red = led_ld_upconv(args[0]);
 37c:	e8 80       	ld	r14, Y
}

// convert 8-bit serial input data into a 12-bit output for the TLC
// and try to preserve the full range of the TLC's control
__inline__ uint16_t led_ld_upconv(uint8_t ser) {
    return (((uint16_t) ser) << 4) | (ser >> 4);
 37e:	8e 2d       	mov	r24, r14
 380:	82 95       	swap	r24
 382:	8f 70       	andi	r24, 0x0F	; 15
 384:	20 e1       	ldi	r18, 0x10	; 16
 386:	e2 9e       	mul	r14, r18
 388:	70 01       	movw	r14, r0
 38a:	11 24       	eor	r1, r1
 38c:	e8 2a       	or	r14, r24

        case CMD_LDALL:
            // R G B

            red = led_ld_upconv(args[0]);
            grn = led_ld_upconv(args[1]);
 38e:	09 81       	ldd	r16, Y+1	; 0x01
}

// convert 8-bit serial input data into a 12-bit output for the TLC
// and try to preserve the full range of the TLC's control
__inline__ uint16_t led_ld_upconv(uint8_t ser) {
    return (((uint16_t) ser) << 4) | (ser >> 4);
 390:	80 2f       	mov	r24, r16
 392:	82 95       	swap	r24
 394:	8f 70       	andi	r24, 0x0F	; 15
 396:	90 e1       	ldi	r25, 0x10	; 16
 398:	09 9f       	mul	r16, r25
 39a:	80 01       	movw	r16, r0
 39c:	11 24       	eor	r1, r1
 39e:	08 2b       	or	r16, r24
        case CMD_LDALL:
            // R G B

            red = led_ld_upconv(args[0]);
            grn = led_ld_upconv(args[1]);
            blu = led_ld_upconv(args[2]);
 3a0:	ca 81       	ldd	r28, Y+2	; 0x02
}

// convert 8-bit serial input data into a 12-bit output for the TLC
// and try to preserve the full range of the TLC's control
__inline__ uint16_t led_ld_upconv(uint8_t ser) {
    return (((uint16_t) ser) << 4) | (ser >> 4);
 3a2:	8c 2f       	mov	r24, r28
 3a4:	82 95       	swap	r24
 3a6:	8f 70       	andi	r24, 0x0F	; 15
 3a8:	20 e1       	ldi	r18, 0x10	; 16
 3aa:	c2 9f       	mul	r28, r18
 3ac:	e0 01       	movw	r28, r0
 3ae:	11 24       	eor	r1, r1
 3b0:	c8 2b       	or	r28, r24

            red = led_ld_upconv(args[0]);
            grn = led_ld_upconv(args[1]);
            blu = led_ld_upconv(args[2]);

            for ( led=0 ; led<5 ; led++ ) {
 3b2:	d1 2c       	mov	r13, r1
                ledset_set(led, 0, red);
 3b4:	a7 01       	movw	r20, r14
 3b6:	60 e0       	ldi	r22, 0x00	; 0
 3b8:	8d 2d       	mov	r24, r13
 3ba:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
                ledset_set(led, 1, grn);
 3be:	a8 01       	movw	r20, r16
 3c0:	61 e0       	ldi	r22, 0x01	; 1
 3c2:	8d 2d       	mov	r24, r13
 3c4:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
                ledset_set(led, 2, blu);
 3c8:	ae 01       	movw	r20, r28
 3ca:	62 e0       	ldi	r22, 0x02	; 2
 3cc:	8d 2d       	mov	r24, r13
 3ce:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>

            red = led_ld_upconv(args[0]);
            grn = led_ld_upconv(args[1]);
            blu = led_ld_upconv(args[2]);

            for ( led=0 ; led<5 ; led++ ) {
 3d2:	d3 94       	inc	r13
 3d4:	85 e0       	ldi	r24, 0x05	; 5
 3d6:	d8 12       	cpse	r13, r24
 3d8:	ed cf       	rjmp	.-38     	; 0x3b4 <led_action+0xc8>
 3da:	c6 cf       	rjmp	.-116    	; 0x368 <led_action+0x7c>
            return;
            break;
    }
        
    tlc_drive();
}
 3dc:	df 91       	pop	r29
 3de:	cf 91       	pop	r28
 3e0:	1f 91       	pop	r17
 3e2:	0f 91       	pop	r16
 3e4:	ff 90       	pop	r15
 3e6:	ef 90       	pop	r14
 3e8:	df 90       	pop	r13
 3ea:	cf 90       	pop	r12
 3ec:	08 95       	ret
 3ee:	8b 01       	movw	r16, r22
    // interpret the controller command and arguments
    
    uint8_t led, color;
    uint16_t red, grn, blu;

    switch(action) {
 3f0:	e1 2c       	mov	r14, r1
#include "led.h"
#include "ledset.h"
#include "tlc.h"


void led_action(uint8_t action, uint8_t args[]) {
 3f2:	e8 01       	movw	r28, r16
 3f4:	f1 2c       	mov	r15, r1
        case CMD_LDSET:
            // R0 G0 B0 R1 G1 B1 R2 G2 B2 R3 G3 B3 R4 G4 B4

            for ( led=0 ; led<5 ; led++ ) {
                for ( color=0 ; color<3 ; color++ ) {
                    ledset_set(led, color, led_ld_upconv(args[3*led + color]));
 3f6:	49 91       	ld	r20, Y+
}

// convert 8-bit serial input data into a 12-bit output for the TLC
// and try to preserve the full range of the TLC's control
__inline__ uint16_t led_ld_upconv(uint8_t ser) {
    return (((uint16_t) ser) << 4) | (ser >> 4);
 3f8:	84 2f       	mov	r24, r20
 3fa:	82 95       	swap	r24
 3fc:	8f 70       	andi	r24, 0x0F	; 15
 3fe:	20 e1       	ldi	r18, 0x10	; 16
 400:	42 9f       	mul	r20, r18
 402:	a0 01       	movw	r20, r0
 404:	11 24       	eor	r1, r1
 406:	48 2b       	or	r20, r24
        case CMD_LDSET:
            // R0 G0 B0 R1 G1 B1 R2 G2 B2 R3 G3 B3 R4 G4 B4

            for ( led=0 ; led<5 ; led++ ) {
                for ( color=0 ; color<3 ; color++ ) {
                    ledset_set(led, color, led_ld_upconv(args[3*led + color]));
 408:	6f 2d       	mov	r22, r15
 40a:	8e 2d       	mov	r24, r14
 40c:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
        // commands
        case CMD_LDSET:
            // R0 G0 B0 R1 G1 B1 R2 G2 B2 R3 G3 B3 R4 G4 B4

            for ( led=0 ; led<5 ; led++ ) {
                for ( color=0 ; color<3 ; color++ ) {
 410:	f3 94       	inc	r15
 412:	83 e0       	ldi	r24, 0x03	; 3
 414:	f8 12       	cpse	r15, r24
 416:	ef cf       	rjmp	.-34     	; 0x3f6 <led_action+0x10a>
        // refer to README in this directory for a description of the
        // commands
        case CMD_LDSET:
            // R0 G0 B0 R1 G1 B1 R2 G2 B2 R3 G3 B3 R4 G4 B4

            for ( led=0 ; led<5 ; led++ ) {
 418:	e3 94       	inc	r14
 41a:	0d 5f       	subi	r16, 0xFD	; 253
 41c:	1f 4f       	sbci	r17, 0xFF	; 255
 41e:	95 e0       	ldi	r25, 0x05	; 5
 420:	e9 12       	cpse	r14, r25
 422:	e7 cf       	rjmp	.-50     	; 0x3f2 <led_action+0x106>
 424:	a1 cf       	rjmp	.-190    	; 0x368 <led_action+0x7c>
                * 15 R3/G3 G3/G3 B3/B3 B3/R4 R4/R4
                * 20 G4/G4 G4/B4 B4/B4
                */
            
            red = led_hd_lword(args[0], args[1]);
            grn = led_hd_rword(args[2], args[3]);
 426:	0b 81       	ldd	r16, Y+3	; 0x03
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
}
__inline__ uint16_t led_hd_rword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) first) << 4 ) | ( (second & 0xF0) >> 4 );
 428:	80 2f       	mov	r24, r16
 42a:	82 95       	swap	r24
 42c:	8f 70       	andi	r24, 0x0F	; 15
 42e:	ea 80       	ldd	r14, Y+2	; 0x02
 430:	20 e1       	ldi	r18, 0x10	; 16
 432:	e2 9e       	mul	r14, r18
 434:	70 01       	movw	r14, r0
 436:	11 24       	eor	r1, r1
 438:	e8 2a       	or	r14, r24
}

// convert two 8-bit values to a 12-bit value
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
 43a:	0f 70       	andi	r16, 0x0F	; 15
 43c:	10 e0       	ldi	r17, 0x00	; 0
 43e:	10 2f       	mov	r17, r16
 440:	00 27       	eor	r16, r16
 442:	8c 81       	ldd	r24, Y+4	; 0x04
 444:	08 2b       	or	r16, r24
 446:	48 81       	ld	r20, Y
 448:	4f 70       	andi	r20, 0x0F	; 15
 44a:	50 e0       	ldi	r21, 0x00	; 0
 44c:	54 2f       	mov	r21, r20
 44e:	44 27       	eor	r20, r20
 450:	89 81       	ldd	r24, Y+1	; 0x01
 452:	48 2b       	or	r20, r24
            
            red = led_hd_lword(args[0], args[1]);
            grn = led_hd_rword(args[2], args[3]);
            blu = led_hd_lword(args[3], args[4]);

            ledset_set(0, 0, red);
 454:	60 e0       	ldi	r22, 0x00	; 0
 456:	80 e0       	ldi	r24, 0x00	; 0
 458:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
            ledset_set(0, 1, grn);
 45c:	a7 01       	movw	r20, r14
 45e:	61 e0       	ldi	r22, 0x01	; 1
 460:	80 e0       	ldi	r24, 0x00	; 0
 462:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
            ledset_set(0, 2, blu);
 466:	a8 01       	movw	r20, r16
 468:	62 e0       	ldi	r22, 0x02	; 2
 46a:	80 e0       	ldi	r24, 0x00	; 0
 46c:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>


            red = led_hd_rword(args[5], args[6]);
 470:	9e 81       	ldd	r25, Y+6	; 0x06
}

// convert two 8-bit values to a 12-bit value
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
 472:	89 2f       	mov	r24, r25
 474:	8f 70       	andi	r24, 0x0F	; 15
 476:	e8 2e       	mov	r14, r24
 478:	f1 2c       	mov	r15, r1
 47a:	fe 2c       	mov	r15, r14
 47c:	ee 24       	eor	r14, r14
 47e:	8f 81       	ldd	r24, Y+7	; 0x07
 480:	e8 2a       	or	r14, r24
}
__inline__ uint16_t led_hd_rword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) first) << 4 ) | ( (second & 0xF0) >> 4 );
 482:	89 85       	ldd	r24, Y+9	; 0x09
 484:	82 95       	swap	r24
 486:	8f 70       	andi	r24, 0x0F	; 15
 488:	08 85       	ldd	r16, Y+8	; 0x08
 48a:	20 e1       	ldi	r18, 0x10	; 16
 48c:	02 9f       	mul	r16, r18
 48e:	80 01       	movw	r16, r0
 490:	11 24       	eor	r1, r1
 492:	08 2b       	or	r16, r24
 494:	92 95       	swap	r25
 496:	9f 70       	andi	r25, 0x0F	; 15
 498:	4d 81       	ldd	r20, Y+5	; 0x05
 49a:	80 e1       	ldi	r24, 0x10	; 16
 49c:	48 9f       	mul	r20, r24
 49e:	a0 01       	movw	r20, r0
 4a0:	11 24       	eor	r1, r1
 4a2:	49 2b       	or	r20, r25

            red = led_hd_rword(args[5], args[6]);
            grn = led_hd_lword(args[6], args[7]);
            blu = led_hd_rword(args[8], args[9]);

            ledset_set(1, 0, red);
 4a4:	60 e0       	ldi	r22, 0x00	; 0
 4a6:	81 e0       	ldi	r24, 0x01	; 1
 4a8:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
            ledset_set(1, 1, grn);
 4ac:	a7 01       	movw	r20, r14
 4ae:	61 e0       	ldi	r22, 0x01	; 1
 4b0:	81 e0       	ldi	r24, 0x01	; 1
 4b2:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
            ledset_set(1, 2, blu);
 4b6:	a8 01       	movw	r20, r16
 4b8:	62 e0       	ldi	r22, 0x02	; 2
 4ba:	81 e0       	ldi	r24, 0x01	; 1
 4bc:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>


            red = led_hd_lword(args[9],  args[10]);
            grn = led_hd_rword(args[11], args[12]);
 4c0:	0c 85       	ldd	r16, Y+12	; 0x0c
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
}
__inline__ uint16_t led_hd_rword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) first) << 4 ) | ( (second & 0xF0) >> 4 );
 4c2:	80 2f       	mov	r24, r16
 4c4:	82 95       	swap	r24
 4c6:	8f 70       	andi	r24, 0x0F	; 15
 4c8:	eb 84       	ldd	r14, Y+11	; 0x0b
 4ca:	90 e1       	ldi	r25, 0x10	; 16
 4cc:	e9 9e       	mul	r14, r25
 4ce:	70 01       	movw	r14, r0
 4d0:	11 24       	eor	r1, r1
 4d2:	e8 2a       	or	r14, r24
}

// convert two 8-bit values to a 12-bit value
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
 4d4:	0f 70       	andi	r16, 0x0F	; 15
 4d6:	10 e0       	ldi	r17, 0x00	; 0
 4d8:	10 2f       	mov	r17, r16
 4da:	00 27       	eor	r16, r16
 4dc:	8d 85       	ldd	r24, Y+13	; 0x0d
 4de:	08 2b       	or	r16, r24
 4e0:	49 85       	ldd	r20, Y+9	; 0x09
 4e2:	4f 70       	andi	r20, 0x0F	; 15
 4e4:	50 e0       	ldi	r21, 0x00	; 0
 4e6:	54 2f       	mov	r21, r20
 4e8:	44 27       	eor	r20, r20
 4ea:	8a 85       	ldd	r24, Y+10	; 0x0a
 4ec:	48 2b       	or	r20, r24

            red = led_hd_lword(args[9],  args[10]);
            grn = led_hd_rword(args[11], args[12]);
            blu = led_hd_lword(args[12], args[13]);

            ledset_set(2, 0, red);
 4ee:	60 e0       	ldi	r22, 0x00	; 0
 4f0:	82 e0       	ldi	r24, 0x02	; 2
 4f2:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
            ledset_set(2, 1, grn);
 4f6:	a7 01       	movw	r20, r14
 4f8:	61 e0       	ldi	r22, 0x01	; 1
 4fa:	82 e0       	ldi	r24, 0x02	; 2
 4fc:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
            ledset_set(2, 2, blu);
 500:	a8 01       	movw	r20, r16
 502:	62 e0       	ldi	r22, 0x02	; 2
 504:	82 e0       	ldi	r24, 0x02	; 2
 506:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>


            red = led_hd_rword(args[14], args[15]);
 50a:	9f 85       	ldd	r25, Y+15	; 0x0f
}

// convert two 8-bit values to a 12-bit value
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
 50c:	89 2f       	mov	r24, r25
 50e:	8f 70       	andi	r24, 0x0F	; 15
 510:	e8 2e       	mov	r14, r24
 512:	f1 2c       	mov	r15, r1
 514:	fe 2c       	mov	r15, r14
 516:	ee 24       	eor	r14, r14
 518:	88 89       	ldd	r24, Y+16	; 0x10
 51a:	e8 2a       	or	r14, r24
}
__inline__ uint16_t led_hd_rword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) first) << 4 ) | ( (second & 0xF0) >> 4 );
 51c:	8a 89       	ldd	r24, Y+18	; 0x12
 51e:	82 95       	swap	r24
 520:	8f 70       	andi	r24, 0x0F	; 15
 522:	09 89       	ldd	r16, Y+17	; 0x11
 524:	20 e1       	ldi	r18, 0x10	; 16
 526:	02 9f       	mul	r16, r18
 528:	80 01       	movw	r16, r0
 52a:	11 24       	eor	r1, r1
 52c:	08 2b       	or	r16, r24
 52e:	92 95       	swap	r25
 530:	9f 70       	andi	r25, 0x0F	; 15
 532:	4e 85       	ldd	r20, Y+14	; 0x0e
 534:	80 e1       	ldi	r24, 0x10	; 16
 536:	48 9f       	mul	r20, r24
 538:	a0 01       	movw	r20, r0
 53a:	11 24       	eor	r1, r1
 53c:	49 2b       	or	r20, r25

            red = led_hd_rword(args[14], args[15]);
            grn = led_hd_lword(args[15], args[16]);
            blu = led_hd_rword(args[17], args[18]);

            ledset_set(3, 0, red);
 53e:	60 e0       	ldi	r22, 0x00	; 0
 540:	83 e0       	ldi	r24, 0x03	; 3
 542:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
            ledset_set(3, 1, grn);
 546:	a7 01       	movw	r20, r14
 548:	61 e0       	ldi	r22, 0x01	; 1
 54a:	83 e0       	ldi	r24, 0x03	; 3
 54c:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
            ledset_set(3, 2, blu);
 550:	a8 01       	movw	r20, r16
 552:	62 e0       	ldi	r22, 0x02	; 2
 554:	83 e0       	ldi	r24, 0x03	; 3
 556:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>


            red = led_hd_lword(args[18], args[19]);
            grn = led_hd_rword(args[20], args[21]);
 55a:	0d 89       	ldd	r16, Y+21	; 0x15
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
}
__inline__ uint16_t led_hd_rword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) first) << 4 ) | ( (second & 0xF0) >> 4 );
 55c:	80 2f       	mov	r24, r16
 55e:	82 95       	swap	r24
 560:	8f 70       	andi	r24, 0x0F	; 15
 562:	ec 88       	ldd	r14, Y+20	; 0x14
 564:	90 e1       	ldi	r25, 0x10	; 16
 566:	e9 9e       	mul	r14, r25
 568:	70 01       	movw	r14, r0
 56a:	11 24       	eor	r1, r1
 56c:	e8 2a       	or	r14, r24
}

// convert two 8-bit values to a 12-bit value
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
 56e:	0f 70       	andi	r16, 0x0F	; 15
 570:	10 e0       	ldi	r17, 0x00	; 0
 572:	10 2f       	mov	r17, r16
 574:	00 27       	eor	r16, r16
 576:	8e 89       	ldd	r24, Y+22	; 0x16
 578:	08 2b       	or	r16, r24
 57a:	4a 89       	ldd	r20, Y+18	; 0x12
 57c:	4f 70       	andi	r20, 0x0F	; 15
 57e:	50 e0       	ldi	r21, 0x00	; 0
 580:	54 2f       	mov	r21, r20
 582:	44 27       	eor	r20, r20
 584:	8b 89       	ldd	r24, Y+19	; 0x13
 586:	48 2b       	or	r20, r24

            red = led_hd_lword(args[18], args[19]);
            grn = led_hd_rword(args[20], args[21]);
            blu = led_hd_lword(args[21], args[22]);

            ledset_set(4, 0, red);
 588:	60 e0       	ldi	r22, 0x00	; 0
 58a:	84 e0       	ldi	r24, 0x04	; 4
 58c:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
            ledset_set(4, 1, grn);
 590:	a7 01       	movw	r20, r14
 592:	61 e0       	ldi	r22, 0x01	; 1
 594:	84 e0       	ldi	r24, 0x04	; 4
 596:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
            ledset_set(4, 2, blu);
 59a:	a8 01       	movw	r20, r16
 59c:	62 e0       	ldi	r22, 0x02	; 2
 59e:	84 e0       	ldi	r24, 0x04	; 4
 5a0:	0e 94 da 00 	call	0x1b4	; 0x1b4 <ledset_set>
            
            break;
 5a4:	e1 ce       	rjmp	.-574    	; 0x368 <led_action+0x7c>

000005a6 <led_ld_upconv>:
}

// convert 8-bit serial input data into a 12-bit output for the TLC
// and try to preserve the full range of the TLC's control
__inline__ uint16_t led_ld_upconv(uint8_t ser) {
    return (((uint16_t) ser) << 4) | (ser >> 4);
 5a6:	28 2f       	mov	r18, r24
 5a8:	22 95       	swap	r18
 5aa:	2f 70       	andi	r18, 0x0F	; 15
 5ac:	30 e1       	ldi	r19, 0x10	; 16
 5ae:	83 9f       	mul	r24, r19
 5b0:	c0 01       	movw	r24, r0
 5b2:	11 24       	eor	r1, r1
}
 5b4:	82 2b       	or	r24, r18
 5b6:	08 95       	ret

000005b8 <led_hd_lword>:

// convert two 8-bit values to a 12-bit value
// direction (l, r) is which of the two bytes has the 4-bit nibble
__inline__ uint16_t led_hd_lword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) (first & 0xF)) << 8 ) | second;
 5b8:	8f 70       	andi	r24, 0x0F	; 15
 5ba:	70 e0       	ldi	r23, 0x00	; 0
}
 5bc:	9b 01       	movw	r18, r22
 5be:	38 2b       	or	r19, r24
 5c0:	c9 01       	movw	r24, r18
 5c2:	08 95       	ret

000005c4 <led_hd_rword>:
__inline__ uint16_t led_hd_rword(uint8_t first, uint8_t second) {
    return ( ((uint16_t) first) << 4 ) | ( (second & 0xF0) >> 4 );
 5c4:	20 e1       	ldi	r18, 0x10	; 16
 5c6:	82 9f       	mul	r24, r18
 5c8:	c0 01       	movw	r24, r0
 5ca:	11 24       	eor	r1, r1
 5cc:	62 95       	swap	r22
 5ce:	6f 70       	andi	r22, 0x0F	; 15
}
 5d0:	86 2b       	or	r24, r22
 5d2:	08 95       	ret

000005d4 <tlc_pulse_xlat>:
#include "config.h"
#include "main.h"
#include "tlc.h"

__inline__ void tlc_pulse_xlat(void) {
    _ON(TLC_CTRL_PRT, TLC_XLAT_PIN);
 5d4:	29 9a       	sbi	0x05, 1	; 5
	#else
		//round up by default
		__ticks_dc = (uint32_t)(ceil(fabs(__tmp)));
	#endif

	__builtin_avr_delay_cycles(__ticks_dc);
 5d6:	86 e0       	ldi	r24, 0x06	; 6
 5d8:	8a 95       	dec	r24
 5da:	f1 f7       	brne	.-4      	; 0x5d8 <tlc_pulse_xlat+0x4>
 5dc:	00 c0       	rjmp	.+0      	; 0x5de <tlc_pulse_xlat+0xa>
    _delay_us(TLC_XLATPD);
    _OFF(TLC_CTRL_PRT, TLC_XLAT_PIN);
 5de:	29 98       	cbi	0x05, 1	; 5
 5e0:	86 e0       	ldi	r24, 0x06	; 6
 5e2:	8a 95       	dec	r24
 5e4:	f1 f7       	brne	.-4      	; 0x5e2 <tlc_pulse_xlat+0xe>
 5e6:	00 c0       	rjmp	.+0      	; 0x5e8 <tlc_pulse_xlat+0x14>
 5e8:	08 95       	ret

000005ea <tlc_init>:
}

void tlc_init(void) {
    uint8_t i;

    TLC_CTRL_DDR |= _BV(TLC_XLAT_PIN) | _BV(TLC_BLANK_PIN);
 5ea:	84 b1       	in	r24, 0x04	; 4
 5ec:	86 60       	ori	r24, 0x06	; 6
 5ee:	84 b9       	out	0x04, r24	; 4
    _ON(TLC_CTRL_PRT, TLC_BLANK_PIN);
 5f0:	2a 9a       	sbi	0x05, 2	; 5
    _OFF(TLC_CTRL_PRT, TLC_XLAT_PIN);
 5f2:	29 98       	cbi	0x05, 1	; 5
    
    TLC_GSCLK_DDR |= _BV(TLC_GSCLK_PIN);
 5f4:	53 9a       	sbi	0x0a, 3	; 10

    // SPI initialization
    TLC_DATA_DDR |= _BV(TLC_MOSI_PIN) | _BV(TLC_SCLK_PIN) | _BV(TLC_SDSS_PIN);
 5f6:	84 b1       	in	r24, 0x04	; 4
 5f8:	8c 62       	ori	r24, 0x2C	; 44
 5fa:	84 b9       	out	0x04, r24	; 4
    _OFF(TLC_DATA_PRT, TLC_SCLK_PIN);
 5fc:	2d 98       	cbi	0x05, 5	; 5

    //SPSR = _BV(SPI2X);            // double speed SPI
    SPCR = _BV(SPE) | _BV(MSTR);    // enable spi in master
 5fe:	80 e5       	ldi	r24, 0x50	; 80
 600:	8c bd       	out	0x2c, r24	; 44
    SPCR |= _BV(SPR1);              // speed register (don't set this too fast)
 602:	8c b5       	in	r24, 0x2c	; 44
 604:	82 60       	ori	r24, 0x02	; 2
 606:	8c bd       	out	0x2c, r24	; 44
 608:	88 e4       	ldi	r24, 0x48	; 72

    // initialize the shift register with all 0s
    for ( i=0 ; i<24*3 ; i++ ) {
        SPDR = 0;
 60a:	1e bc       	out	0x2e, r1	; 46
        while ( !(SPSR & _BV(SPIF)) );
 60c:	0d b4       	in	r0, 0x2d	; 45
 60e:	07 fe       	sbrs	r0, 7
 610:	fd cf       	rjmp	.-6      	; 0x60c <tlc_init+0x22>
 612:	81 50       	subi	r24, 0x01	; 1
    //SPSR = _BV(SPI2X);            // double speed SPI
    SPCR = _BV(SPE) | _BV(MSTR);    // enable spi in master
    SPCR |= _BV(SPR1);              // speed register (don't set this too fast)

    // initialize the shift register with all 0s
    for ( i=0 ; i<24*3 ; i++ ) {
 614:	d1 f7       	brne	.-12     	; 0x60a <tlc_init+0x20>
#include "config.h"
#include "main.h"
#include "tlc.h"

__inline__ void tlc_pulse_xlat(void) {
    _ON(TLC_CTRL_PRT, TLC_XLAT_PIN);
 616:	29 9a       	sbi	0x05, 1	; 5
 618:	86 e0       	ldi	r24, 0x06	; 6
 61a:	8a 95       	dec	r24
 61c:	f1 f7       	brne	.-4      	; 0x61a <tlc_init+0x30>
 61e:	00 c0       	rjmp	.+0      	; 0x620 <tlc_init+0x36>
    _delay_us(TLC_XLATPD);
    _OFF(TLC_CTRL_PRT, TLC_XLAT_PIN);
 620:	29 98       	cbi	0x05, 1	; 5
 622:	86 e0       	ldi	r24, 0x06	; 6
 624:	8a 95       	dec	r24
 626:	f1 f7       	brne	.-4      	; 0x624 <tlc_init+0x3a>
 628:	00 c0       	rjmp	.+0      	; 0x62a <tlc_init+0x40>
    // pulse the latch
    tlc_pulse_xlat();

    // BLANK counter hits every 4096 GSCLK cycles
    // mode 8: PWM phase and frequency correct
    TCCR1A = _BV(COM1B1);   // clear 0C1B on compare match when upcounting, set when downcounting
 62a:	80 e2       	ldi	r24, 0x20	; 32
 62c:	80 93 80 00 	sts	0x0080, r24
    TCCR1B = _BV(WGM13);    // mode 8
 630:	80 e1       	ldi	r24, 0x10	; 16
 632:	80 93 81 00 	sts	0x0081, r24
    TCCR1B |= _BV(CS10);    // start timer, clk/1
 636:	80 91 81 00 	lds	r24, 0x0081
 63a:	81 60       	ori	r24, 0x01	; 1
 63c:	80 93 81 00 	sts	0x0081, r24
    OCR1A = 1;              // blank fires 
 640:	81 e0       	ldi	r24, 0x01	; 1
 642:	90 e0       	ldi	r25, 0x00	; 0
 644:	90 93 89 00 	sts	0x0089, r25
 648:	80 93 88 00 	sts	0x0088, r24
    OCR1B = 2;
 64c:	82 e0       	ldi	r24, 0x02	; 2
 64e:	90 e0       	ldi	r25, 0x00	; 0
 650:	90 93 8b 00 	sts	0x008B, r25
 654:	80 93 8a 00 	sts	0x008A, r24
    ICR1 = 18432; // = (GSCLKPD+1)*4096/2
 658:	80 e0       	ldi	r24, 0x00	; 0
 65a:	98 e4       	ldi	r25, 0x48	; 72
 65c:	90 93 87 00 	sts	0x0087, r25
 660:	80 93 86 00 	sts	0x0086, r24

    // GSCLK
    TCCR2A = (_BV(COM2B1) | _BV(WGM21) | _BV(WGM20));
 664:	83 e2       	ldi	r24, 0x23	; 35
 666:	80 93 b0 00 	sts	0x00B0, r24
    TCCR2B = _BV(WGM22);
 66a:	88 e0       	ldi	r24, 0x08	; 8
 66c:	80 93 b1 00 	sts	0x00B1, r24
    TCCR2B |= _BV(CS20);
 670:	80 91 b1 00 	lds	r24, 0x00B1
 674:	81 60       	ori	r24, 0x01	; 1
 676:	80 93 b1 00 	sts	0x00B1, r24
    OCR2A = 9;
 67a:	89 e0       	ldi	r24, 0x09	; 9
 67c:	80 93 b3 00 	sts	0x00B3, r24
    OCR2B = 0;
 680:	10 92 b4 00 	sts	0x00B4, r1
    
    // if we're on the new board revision, prepare the XERR pins
#if (BRDREV == 2)
    TLC_XERR_DDR &= ~(TLC_XERRS_MSK);
 684:	8a b1       	in	r24, 0x0a	; 10
 686:	8f 71       	andi	r24, 0x1F	; 31
 688:	8a b9       	out	0x0a, r24	; 10
    // enable pull-up
    TLC_XERR_PRT |= TLC_XERRS_MSK;
 68a:	8b b1       	in	r24, 0x0b	; 11
 68c:	80 6e       	ori	r24, 0xE0	; 224
 68e:	8b b9       	out	0x0b, r24	; 11
 690:	08 95       	ret

00000692 <tlc_drive>:
}

void tlc_drive(void) {
    uint8_t chip, chip1, out;

    for ( chip1=3 ; chip1>0 ; chip1-- ) {
 692:	23 e0       	ldi	r18, 0x03	; 3
        chip = chip1 - 1;
 694:	21 50       	subi	r18, 0x01	; 1
 696:	82 2f       	mov	r24, r18
 698:	90 e0       	ldi	r25, 0x00	; 0
 69a:	fc 01       	movw	r30, r24
 69c:	ee 0f       	add	r30, r30
 69e:	ff 1f       	adc	r31, r31
 6a0:	e8 0f       	add	r30, r24
 6a2:	f9 1f       	adc	r31, r25
 6a4:	ee 0f       	add	r30, r30
 6a6:	ff 1f       	adc	r31, r31
 6a8:	ee 0f       	add	r30, r30
 6aa:	ff 1f       	adc	r31, r31
 6ac:	ee 0f       	add	r30, r30
 6ae:	ff 1f       	adc	r31, r31
 6b0:	e6 5e       	subi	r30, 0xE6	; 230
 6b2:	fe 4f       	sbci	r31, 0xFE	; 254
 6b4:	88 e1       	ldi	r24, 0x18	; 24

        for ( out=0 ; out<24 ; out++ ) {
            SPDR = tlc[chip][out];
 6b6:	91 91       	ld	r25, Z+
 6b8:	9e bd       	out	0x2e, r25	; 46
            while ( !(SPSR & _BV(SPIF)) );
 6ba:	0d b4       	in	r0, 0x2d	; 45
 6bc:	07 fe       	sbrs	r0, 7
 6be:	fd cf       	rjmp	.-6      	; 0x6ba <tlc_drive+0x28>
 6c0:	81 50       	subi	r24, 0x01	; 1
    uint8_t chip, chip1, out;

    for ( chip1=3 ; chip1>0 ; chip1-- ) {
        chip = chip1 - 1;

        for ( out=0 ; out<24 ; out++ ) {
 6c2:	c9 f7       	brne	.-14     	; 0x6b6 <tlc_drive+0x24>
}

void tlc_drive(void) {
    uint8_t chip, chip1, out;

    for ( chip1=3 ; chip1>0 ; chip1-- ) {
 6c4:	21 11       	cpse	r18, r1
 6c6:	e6 cf       	rjmp	.-52     	; 0x694 <tlc_drive+0x2>
#include "config.h"
#include "main.h"
#include "tlc.h"

__inline__ void tlc_pulse_xlat(void) {
    _ON(TLC_CTRL_PRT, TLC_XLAT_PIN);
 6c8:	29 9a       	sbi	0x05, 1	; 5
 6ca:	86 e0       	ldi	r24, 0x06	; 6
 6cc:	8a 95       	dec	r24
 6ce:	f1 f7       	brne	.-4      	; 0x6cc <tlc_drive+0x3a>
 6d0:	00 c0       	rjmp	.+0      	; 0x6d2 <tlc_drive+0x40>
    _delay_us(TLC_XLATPD);
    _OFF(TLC_CTRL_PRT, TLC_XLAT_PIN);
 6d2:	29 98       	cbi	0x05, 1	; 5
 6d4:	86 e0       	ldi	r24, 0x06	; 6
 6d6:	8a 95       	dec	r24
 6d8:	f1 f7       	brne	.-4      	; 0x6d6 <tlc_drive+0x44>
 6da:	00 c0       	rjmp	.+0      	; 0x6dc <tlc_drive+0x4a>
 6dc:	08 95       	ret

000006de <tlc_read_xerr>:
    // currently will only read thermal overflow
    uint8_t xerr = 0;

#if (BRDREV == 2)
    // TODO: this is dumb and probably won't work
    while (TLC_CTRL_PRT & _BV(TLC_BLANK_PIN));
 6de:	2a 99       	sbic	0x05, 2	; 5
 6e0:	fe cf       	rjmp	.-4      	; 0x6de <tlc_read_xerr>
    
    xerr = TLC_XERR_PIN;
 6e2:	89 b1       	in	r24, 0x09	; 9
    xerr = (xerr & TLC_XERRS_MSK) >> TLC_XERR1_PIN;
#endif

    return xerr;
}
 6e4:	82 95       	swap	r24
 6e6:	86 95       	lsr	r24
 6e8:	87 70       	andi	r24, 0x07	; 7
 6ea:	08 95       	ret

000006ec <tlc_set>:
/* LED ARRAY PACKING FUNCTIONS */
void tlc_set(uint8_t volatile driver[], uint8_t posn, uint16_t value) {
    // store data to the packed driver byte array
    uint8_t idx;

    if ( posn%2 ) {
 6ec:	60 fd       	sbrc	r22, 0
 6ee:	1a c0       	rjmp	.+52     	; 0x724 <tlc_set+0x38>
        idx = 22 - ((3*posn)>>1);
        driver[idx] = value >> 4;
        driver[idx+1] = ( (value & 0x00F) << 4 ) | ( driver[idx+1] & 0x0F );
    } else {
        // for an even position number, the base index is (23 - 3*even/2)
        idx = 23 - ((3*posn)>>1);
 6f0:	70 e0       	ldi	r23, 0x00	; 0
 6f2:	9b 01       	movw	r18, r22
 6f4:	22 0f       	add	r18, r18
 6f6:	33 1f       	adc	r19, r19
 6f8:	26 0f       	add	r18, r22
 6fa:	37 1f       	adc	r19, r23
 6fc:	35 95       	asr	r19
 6fe:	27 95       	ror	r18
 700:	37 e1       	ldi	r19, 0x17	; 23
 702:	32 1b       	sub	r19, r18
        driver[idx-1] = ( driver[idx-1] & 0xF0 ) | ( (value >> 8) & 0x00F );
 704:	23 2f       	mov	r18, r19
 706:	30 e0       	ldi	r19, 0x00	; 0
 708:	f9 01       	movw	r30, r18
 70a:	31 97       	sbiw	r30, 0x01	; 1
 70c:	e8 0f       	add	r30, r24
 70e:	f9 1f       	adc	r31, r25
 710:	60 81       	ld	r22, Z
 712:	60 7f       	andi	r22, 0xF0	; 240
 714:	5f 70       	andi	r21, 0x0F	; 15
 716:	65 2b       	or	r22, r21
 718:	60 83       	st	Z, r22
        driver[idx] = value;
 71a:	fc 01       	movw	r30, r24
 71c:	e2 0f       	add	r30, r18
 71e:	f3 1f       	adc	r31, r19
 720:	40 83       	st	Z, r20
 722:	08 95       	ret
    uint8_t idx;

    if ( posn%2 ) {
        // for an odd position number, the base index (index of the full byte)
        // is (23 - 3*odd/2 - 1)
        idx = 22 - ((3*posn)>>1);
 724:	70 e0       	ldi	r23, 0x00	; 0
 726:	9b 01       	movw	r18, r22
 728:	22 0f       	add	r18, r18
 72a:	33 1f       	adc	r19, r19
 72c:	26 0f       	add	r18, r22
 72e:	37 1f       	adc	r19, r23
 730:	35 95       	asr	r19
 732:	27 95       	ror	r18
 734:	e6 e1       	ldi	r30, 0x16	; 22
 736:	e2 1b       	sub	r30, r18
        driver[idx] = value >> 4;
 738:	f0 e0       	ldi	r31, 0x00	; 0
 73a:	dc 01       	movw	r26, r24
 73c:	ae 0f       	add	r26, r30
 73e:	bf 1f       	adc	r27, r31
 740:	9a 01       	movw	r18, r20
 742:	32 95       	swap	r19
 744:	22 95       	swap	r18
 746:	2f 70       	andi	r18, 0x0F	; 15
 748:	23 27       	eor	r18, r19
 74a:	3f 70       	andi	r19, 0x0F	; 15
 74c:	23 27       	eor	r18, r19
 74e:	2c 93       	st	X, r18
        driver[idx+1] = ( (value & 0x00F) << 4 ) | ( driver[idx+1] & 0x0F );
 750:	31 96       	adiw	r30, 0x01	; 1
 752:	e8 0f       	add	r30, r24
 754:	f9 1f       	adc	r31, r25
 756:	80 81       	ld	r24, Z
 758:	8f 70       	andi	r24, 0x0F	; 15
 75a:	42 95       	swap	r20
 75c:	40 7f       	andi	r20, 0xF0	; 240
 75e:	84 2b       	or	r24, r20
 760:	80 83       	st	Z, r24
 762:	08 95       	ret

00000764 <tlc_get>:

uint16_t tlc_get(uint8_t volatile driver[], uint8_t posn) {
    // get the value of a driver from the byte array
    uint8_t idx;

    if ( posn%2 ) {
 764:	60 fd       	sbrc	r22, 0
 766:	19 c0       	rjmp	.+50     	; 0x79a <tlc_get+0x36>
        idx = 22 - ((3*posn)>>1);
        return ( ((uint16_t) driver[idx]) << 4 ) | (driver[idx+1] >> 4);
    } else {
        idx = 23 - ((3*posn)>>1);
 768:	70 e0       	ldi	r23, 0x00	; 0
 76a:	9b 01       	movw	r18, r22
 76c:	22 0f       	add	r18, r18
 76e:	33 1f       	adc	r19, r19
 770:	26 0f       	add	r18, r22
 772:	37 1f       	adc	r19, r23
 774:	35 95       	asr	r19
 776:	27 95       	ror	r18
 778:	37 e1       	ldi	r19, 0x17	; 23
 77a:	32 1b       	sub	r19, r18
        return ( ( (uint16_t) (driver[idx-1]) & 0x0F ) << 8 ) | driver[idx];
 77c:	23 2f       	mov	r18, r19
 77e:	30 e0       	ldi	r19, 0x00	; 0
 780:	f9 01       	movw	r30, r18
 782:	31 97       	sbiw	r30, 0x01	; 1
 784:	e8 0f       	add	r30, r24
 786:	f9 1f       	adc	r31, r25
 788:	40 81       	ld	r20, Z
 78a:	fc 01       	movw	r30, r24
 78c:	e2 0f       	add	r30, r18
 78e:	f3 1f       	adc	r31, r19
 790:	80 81       	ld	r24, Z
 792:	4f 70       	andi	r20, 0x0F	; 15
 794:	90 e0       	ldi	r25, 0x00	; 0
 796:	94 2b       	or	r25, r20
    }

}
 798:	08 95       	ret
uint16_t tlc_get(uint8_t volatile driver[], uint8_t posn) {
    // get the value of a driver from the byte array
    uint8_t idx;

    if ( posn%2 ) {
        idx = 22 - ((3*posn)>>1);
 79a:	70 e0       	ldi	r23, 0x00	; 0
 79c:	9b 01       	movw	r18, r22
 79e:	22 0f       	add	r18, r18
 7a0:	33 1f       	adc	r19, r19
 7a2:	26 0f       	add	r18, r22
 7a4:	37 1f       	adc	r19, r23
 7a6:	35 95       	asr	r19
 7a8:	27 95       	ror	r18
 7aa:	e6 e1       	ldi	r30, 0x16	; 22
 7ac:	e2 1b       	sub	r30, r18
        return ( ((uint16_t) driver[idx]) << 4 ) | (driver[idx+1] >> 4);
 7ae:	f0 e0       	ldi	r31, 0x00	; 0
 7b0:	dc 01       	movw	r26, r24
 7b2:	ae 0f       	add	r26, r30
 7b4:	bf 1f       	adc	r27, r31
 7b6:	3c 91       	ld	r19, X
 7b8:	31 96       	adiw	r30, 0x01	; 1
 7ba:	e8 0f       	add	r30, r24
 7bc:	f9 1f       	adc	r31, r25
 7be:	20 81       	ld	r18, Z
 7c0:	22 95       	swap	r18
 7c2:	2f 70       	andi	r18, 0x0F	; 15
 7c4:	40 e1       	ldi	r20, 0x10	; 16
 7c6:	34 9f       	mul	r19, r20
 7c8:	c0 01       	movw	r24, r0
 7ca:	11 24       	eor	r1, r1
 7cc:	82 2b       	or	r24, r18
 7ce:	08 95       	ret

000007d0 <nrf_enable_irq>:
}


// application-level commands
void nrf_enable_irq(void) {
    _ON(EIMSK, INT0);
 7d0:	e8 9a       	sbi	0x1d, 0	; 29
 7d2:	08 95       	ret

000007d4 <nrf_disable_irq>:
}


void nrf_disable_irq(void) {
    _OFF(EIMSK, INT0);
 7d4:	e8 98       	cbi	0x1d, 0	; 29
    packet_ready = 0;
 7d6:	10 92 00 01 	sts	0x0100, r1
 7da:	08 95       	ret

000007dc <nrf_wait_for_rxpacket>:
    nrf_disable_irq();
}


void nrf_wait_for_rxpacket(void) {
    while (!packet_ready);
 7dc:	80 91 00 01 	lds	r24, 0x0100
 7e0:	88 23       	and	r24, r24
 7e2:	e1 f3       	breq	.-8      	; 0x7dc <nrf_wait_for_rxpacket>
}
 7e4:	08 95       	ret

000007e6 <nrf_accept_packet>:


void nrf_accept_packet(void) {
    packet_ready = 0;
 7e6:	10 92 00 01 	sts	0x0100, r1
 7ea:	08 95       	ret

000007ec <nrf_ce_on>:
}


// chip commands
void nrf_ce_on(void) {
    _ON(NRF_CE_PRT, NRF_CE_PIN);
 7ec:	28 9a       	sbi	0x05, 0	; 5
 7ee:	08 95       	ret

000007f0 <nrf_ce_off>:
}


void nrf_ce_off(void) {
    _OFF(NRF_CE_PRT, NRF_CE_PIN);
 7f0:	28 98       	cbi	0x05, 0	; 5
 7f2:	08 95       	ret

000007f4 <nrf_txpayload>:
        nrf_regwr(NRF_REG_CONFIG, NRF_INI_CONFIG & ~(_BV(NRF_BIT_PWR_UP)));
    }
}


uint8_t nrf_txpayload(uint8_t *buf) {
 7f4:	1f 93       	push	r17
 7f6:	cf 93       	push	r28
 7f8:	df 93       	push	r29
 7fa:	ec 01       	movw	r28, r24
    uint8_t status;

    nrfspi_cs_en();
 7fc:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    status = nrfspi_txrx_byte(NRF_CMD_TXPLW);
 800:	80 ea       	ldi	r24, 0xA0	; 160
 802:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
 806:	18 2f       	mov	r17, r24
    nrfspi_txrx(COM_PL_SIZE, buf, 0);
 808:	40 e0       	ldi	r20, 0x00	; 0
 80a:	50 e0       	ldi	r21, 0x00	; 0
 80c:	be 01       	movw	r22, r28
 80e:	89 e1       	ldi	r24, 0x19	; 25
 810:	0e 94 48 06 	call	0xc90	; 0xc90 <nrfspi_txrx>
    nrfspi_cs_ds();
 814:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return status;
}
 818:	81 2f       	mov	r24, r17
 81a:	df 91       	pop	r29
 81c:	cf 91       	pop	r28
 81e:	1f 91       	pop	r17
 820:	08 95       	ret

00000822 <nrf_rxpayload>:


uint8_t nrf_rxpayload(uint8_t *buf) {
 822:	1f 93       	push	r17
 824:	cf 93       	push	r28
 826:	df 93       	push	r29
 828:	ec 01       	movw	r28, r24
    uint8_t status;

    nrfspi_cs_en();
 82a:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    status = nrfspi_txrx_byte(NRF_CMD_RXPLR);
 82e:	81 e6       	ldi	r24, 0x61	; 97
 830:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
 834:	18 2f       	mov	r17, r24
    nrfspi_txrx(COM_PL_SIZE, buf, buf);
 836:	ae 01       	movw	r20, r28
 838:	be 01       	movw	r22, r28
 83a:	89 e1       	ldi	r24, 0x19	; 25
 83c:	0e 94 48 06 	call	0xc90	; 0xc90 <nrfspi_txrx>
    nrfspi_cs_ds();
 840:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return status;
}
 844:	81 2f       	mov	r24, r17
 846:	df 91       	pop	r29
 848:	cf 91       	pop	r28
 84a:	1f 91       	pop	r17
 84c:	08 95       	ret

0000084e <nrf_regwr_long>:


uint8_t nrf_regwr_long(uint8_t reg, uint8_t len, uint8_t *buf) {
 84e:	ef 92       	push	r14
 850:	ff 92       	push	r15
 852:	0f 93       	push	r16
 854:	1f 93       	push	r17
 856:	cf 93       	push	r28
 858:	df 93       	push	r29
 85a:	1f 92       	push	r1
 85c:	cd b7       	in	r28, 0x3d	; 61
 85e:	de b7       	in	r29, 0x3e	; 62
 860:	06 2f       	mov	r16, r22
 862:	7a 01       	movw	r14, r20
    uint8_t status;

    nrfspi_cs_en();
 864:	89 83       	std	Y+1, r24	; 0x01
 866:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    status = nrfspi_txrx_byte(reg);
 86a:	89 81       	ldd	r24, Y+1	; 0x01
 86c:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
 870:	18 2f       	mov	r17, r24
    nrfspi_txrx(len, buf, 0);
 872:	40 e0       	ldi	r20, 0x00	; 0
 874:	50 e0       	ldi	r21, 0x00	; 0
 876:	b7 01       	movw	r22, r14
 878:	80 2f       	mov	r24, r16
 87a:	0e 94 48 06 	call	0xc90	; 0xc90 <nrfspi_txrx>
    nrfspi_cs_ds();
 87e:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return status;
}
 882:	81 2f       	mov	r24, r17
 884:	0f 90       	pop	r0
 886:	df 91       	pop	r29
 888:	cf 91       	pop	r28
 88a:	1f 91       	pop	r17
 88c:	0f 91       	pop	r16
 88e:	ff 90       	pop	r15
 890:	ef 90       	pop	r14
 892:	08 95       	ret

00000894 <nrf_regrd_long>:


uint8_t nrf_regrd_long(uint8_t reg, uint8_t len, uint8_t *buf) {
 894:	ef 92       	push	r14
 896:	ff 92       	push	r15
 898:	0f 93       	push	r16
 89a:	1f 93       	push	r17
 89c:	cf 93       	push	r28
 89e:	df 93       	push	r29
 8a0:	1f 92       	push	r1
 8a2:	cd b7       	in	r28, 0x3d	; 61
 8a4:	de b7       	in	r29, 0x3e	; 62
 8a6:	06 2f       	mov	r16, r22
 8a8:	7a 01       	movw	r14, r20
    uint8_t status;

    nrfspi_cs_en();
 8aa:	89 83       	std	Y+1, r24	; 0x01
 8ac:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    status = nrfspi_txrx_byte(reg);
 8b0:	89 81       	ldd	r24, Y+1	; 0x01
 8b2:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
 8b6:	18 2f       	mov	r17, r24
    nrfspi_txrx(len, buf, buf);
 8b8:	a7 01       	movw	r20, r14
 8ba:	b7 01       	movw	r22, r14
 8bc:	80 2f       	mov	r24, r16
 8be:	0e 94 48 06 	call	0xc90	; 0xc90 <nrfspi_txrx>
    nrfspi_cs_ds();
 8c2:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return status;
}
 8c6:	81 2f       	mov	r24, r17
 8c8:	0f 90       	pop	r0
 8ca:	df 91       	pop	r29
 8cc:	cf 91       	pop	r28
 8ce:	1f 91       	pop	r17
 8d0:	0f 91       	pop	r16
 8d2:	ff 90       	pop	r15
 8d4:	ef 90       	pop	r14
 8d6:	08 95       	ret

000008d8 <nrf_regwr>:


uint8_t nrf_regwr(uint8_t reg, uint8_t data) {
 8d8:	1f 93       	push	r17
 8da:	cf 93       	push	r28
 8dc:	df 93       	push	r29
 8de:	00 d0       	rcall	.+0      	; 0x8e0 <nrf_regwr+0x8>
 8e0:	cd b7       	in	r28, 0x3d	; 61
 8e2:	de b7       	in	r29, 0x3e	; 62
    uint8_t status;
    reg = NRF_CMD_REGWR | reg;

    nrfspi_cs_en();
 8e4:	6a 83       	std	Y+2, r22	; 0x02
 8e6:	89 83       	std	Y+1, r24	; 0x01
 8e8:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    status = nrfspi_txrx_byte(reg);
 8ec:	89 81       	ldd	r24, Y+1	; 0x01
 8ee:	80 62       	ori	r24, 0x20	; 32
 8f0:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
 8f4:	18 2f       	mov	r17, r24
    nrfspi_txrx_byte(data);
 8f6:	6a 81       	ldd	r22, Y+2	; 0x02
 8f8:	86 2f       	mov	r24, r22
 8fa:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
    nrfspi_cs_ds();
 8fe:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return status;
}
 902:	81 2f       	mov	r24, r17
 904:	0f 90       	pop	r0
 906:	0f 90       	pop	r0
 908:	df 91       	pop	r29
 90a:	cf 91       	pop	r28
 90c:	1f 91       	pop	r17
 90e:	08 95       	ret

00000910 <nrf_init>:
uint8_t *rx_packet_buffer;

uint8_t volatile packet_ready = 0;

// initialization
void nrf_init(uint8_t channel, uint8_t *rx_addr, uint8_t *txpbuf, uint8_t *rxpbuf) {
 910:	df 92       	push	r13
 912:	ef 92       	push	r14
 914:	ff 92       	push	r15
 916:	0f 93       	push	r16
 918:	1f 93       	push	r17
 91a:	cf 93       	push	r28
 91c:	df 93       	push	r29
 91e:	d8 2e       	mov	r13, r24
 920:	eb 01       	movw	r28, r22
 922:	7a 01       	movw	r14, r20
 924:	89 01       	movw	r16, r18
    _ON(NRF_CE_PRT, NRF_CE_PIN);
}


void nrf_ce_off(void) {
    _OFF(NRF_CE_PRT, NRF_CE_PIN);
 926:	28 98       	cbi	0x05, 0	; 5
// initialization
void nrf_init(uint8_t channel, uint8_t *rx_addr, uint8_t *txpbuf, uint8_t *rxpbuf) {
    // turn off wireless communication
    nrf_ce_off();
    // set up nrf chip enable
    _ON(NRF_CE_DDR, NRF_CE_PIN);
 928:	20 9a       	sbi	0x04, 0	; 4

    // initialize SPI layer
    nrfspi_init();
 92a:	0e 94 2b 06 	call	0xc56	; 0xc56 <nrfspi_init>
    nrfspi_enable();
 92e:	0e 94 33 06 	call	0xc66	; 0xc66 <nrfspi_enable>

    // register buffer addresses
    tx_packet_buffer = txpbuf;
 932:	f0 92 82 01 	sts	0x0182, r15
 936:	e0 92 81 01 	sts	0x0181, r14
    rx_packet_buffer = rxpbuf;
 93a:	10 93 80 01 	sts	0x0180, r17
 93e:	00 93 7f 01 	sts	0x017F, r16

    // set up interrupt with pull-up for falling edge
    _OFF(NRF_IRQ_DDR, NRF_IRQ_PIN);
 942:	52 98       	cbi	0x0a, 2	; 10
    _ON(NRF_IRQ_PRT, NRF_IRQ_PIN);
 944:	5a 9a       	sbi	0x0b, 2	; 11
    EICRA = _BV(ISC01);
 946:	82 e0       	ldi	r24, 0x02	; 2
 948:	80 93 69 00 	sts	0x0069, r24

    // perform system configuration
    nrf_regwr(NRF_REG_CONFIG, NRF_INI_CONFIG);
 94c:	6b e3       	ldi	r22, 0x3B	; 59
 94e:	80 e0       	ldi	r24, 0x00	; 0
 950:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>
    nrf_regwr(NRF_REG_EN_AA, NRF_INI_EN_AA);
 954:	63 e0       	ldi	r22, 0x03	; 3
 956:	81 e0       	ldi	r24, 0x01	; 1
 958:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>
    nrf_regwr(NRF_REG_EN_RXADDR, NRF_INI_EN_RXADDR);
 95c:	63 e0       	ldi	r22, 0x03	; 3
 95e:	82 e0       	ldi	r24, 0x02	; 2
 960:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>
    nrf_regwr(NRF_REG_SETUP_AW, NRF_INI_SETUP_AW);
 964:	61 e0       	ldi	r22, 0x01	; 1
 966:	83 e0       	ldi	r24, 0x03	; 3
 968:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>
    nrf_regwr(NRF_REG_SETUP_RETR, NRF_INI_SETUP_RETR);
 96c:	60 e0       	ldi	r22, 0x00	; 0
 96e:	84 e0       	ldi	r24, 0x04	; 4
 970:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>
    nrf_regwr(NRF_REG_RF_SETUP, NRF_INI_RF_SETUP);
 974:	66 e0       	ldi	r22, 0x06	; 6
 976:	86 e0       	ldi	r24, 0x06	; 6
 978:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>
    nrf_regwr(NRF_REG_RX_PW_P0, NRF_INI_RX_PW_P0);
 97c:	69 e1       	ldi	r22, 0x19	; 25
 97e:	81 e1       	ldi	r24, 0x11	; 17
 980:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>
    nrf_regwr(NRF_REG_RX_PW_P1, NRF_INI_RX_PW_P1);
 984:	69 e1       	ldi	r22, 0x19	; 25
 986:	82 e1       	ldi	r24, 0x12	; 18
 988:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>

    nrf_regwr(NRF_REG_RF_CH, ( channel << NRF_BIT_RF_CH60 ) );
 98c:	6d 2d       	mov	r22, r13
 98e:	85 e0       	ldi	r24, 0x05	; 5
 990:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>

    // if our primary function is receiver mode, set up pipe addresses
#ifdef NRF_FN_RX
    nrf_regwr_long(NRF_REG_RX_ADDR_P1, COM_AD_SIZE, rx_addr);
 994:	ae 01       	movw	r20, r28
 996:	63 e0       	ldi	r22, 0x03	; 3
 998:	8b e0       	ldi	r24, 0x0B	; 11
#endif
}
 99a:	df 91       	pop	r29
 99c:	cf 91       	pop	r28
 99e:	1f 91       	pop	r17
 9a0:	0f 91       	pop	r16
 9a2:	ff 90       	pop	r15
 9a4:	ef 90       	pop	r14
 9a6:	df 90       	pop	r13

    nrf_regwr(NRF_REG_RF_CH, ( channel << NRF_BIT_RF_CH60 ) );

    // if our primary function is receiver mode, set up pipe addresses
#ifdef NRF_FN_RX
    nrf_regwr_long(NRF_REG_RX_ADDR_P1, COM_AD_SIZE, rx_addr);
 9a8:	0c 94 27 04 	jmp	0x84e	; 0x84e <nrf_regwr_long>

000009ac <__vector_1>:
    packet_ready = 0;
}


// nrf24l01+ interrupt handler
ISR(INT0_vect) {
 9ac:	1f 92       	push	r1
 9ae:	0f 92       	push	r0
 9b0:	0f b6       	in	r0, 0x3f	; 63
 9b2:	0f 92       	push	r0
 9b4:	11 24       	eor	r1, r1
 9b6:	2f 93       	push	r18
 9b8:	3f 93       	push	r19
 9ba:	4f 93       	push	r20
 9bc:	5f 93       	push	r21
 9be:	6f 93       	push	r22
 9c0:	7f 93       	push	r23
 9c2:	8f 93       	push	r24
 9c4:	9f 93       	push	r25
 9c6:	af 93       	push	r26
 9c8:	bf 93       	push	r27
 9ca:	ef 93       	push	r30
 9cc:	ff 93       	push	r31
    _ON(NRF_CE_PRT, NRF_CE_PIN);
}


void nrf_ce_off(void) {
    _OFF(NRF_CE_PRT, NRF_CE_PIN);
 9ce:	28 98       	cbi	0x05, 0	; 5
    // the device and we must read it out

    // shut off receiver
    nrf_ce_off();

    while (packet_ready);
 9d0:	80 91 00 01 	lds	r24, 0x0100
 9d4:	81 11       	cpse	r24, r1
 9d6:	fc cf       	rjmp	.-8      	; 0x9d0 <__vector_1+0x24>

    // read out data into buffer
    status = nrf_rxpayload(rx_packet_buffer);
 9d8:	80 91 7f 01 	lds	r24, 0x017F
 9dc:	90 91 80 01 	lds	r25, 0x0180
 9e0:	0e 94 11 04 	call	0x822	; 0x822 <nrf_rxpayload>

    // clear RX flag
    nrf_regwr(NRF_REG_STATUS, status | _BV(NRF_BIT_RX_DR));
 9e4:	68 2f       	mov	r22, r24
 9e6:	60 64       	ori	r22, 0x40	; 64
 9e8:	87 e0       	ldi	r24, 0x07	; 7
 9ea:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>

    // report that the packet is ready
    packet_ready = 1;
 9ee:	81 e0       	ldi	r24, 0x01	; 1
 9f0:	80 93 00 01 	sts	0x0100, r24
}


// chip commands
void nrf_ce_on(void) {
    _ON(NRF_CE_PRT, NRF_CE_PIN);
 9f4:	28 9a       	sbi	0x05, 0	; 5
    // report that the packet is ready
    packet_ready = 1;

    // re-enable receiver
    nrf_ce_on();
}
 9f6:	ff 91       	pop	r31
 9f8:	ef 91       	pop	r30
 9fa:	bf 91       	pop	r27
 9fc:	af 91       	pop	r26
 9fe:	9f 91       	pop	r25
 a00:	8f 91       	pop	r24
 a02:	7f 91       	pop	r23
 a04:	6f 91       	pop	r22
 a06:	5f 91       	pop	r21
 a08:	4f 91       	pop	r20
 a0a:	3f 91       	pop	r19
 a0c:	2f 91       	pop	r18
 a0e:	0f 90       	pop	r0
 a10:	0f be       	out	0x3f, r0	; 63
 a12:	0f 90       	pop	r0
 a14:	1f 90       	pop	r1
 a16:	18 95       	reti

00000a18 <nrf_regrd>:

    return status;
}


uint8_t nrf_regrd(uint8_t reg) {
 a18:	cf 93       	push	r28
 a1a:	df 93       	push	r29
 a1c:	1f 92       	push	r1
 a1e:	cd b7       	in	r28, 0x3d	; 61
 a20:	de b7       	in	r29, 0x3e	; 62
    uint8_t data;
    reg = NRF_CMD_REGRD | reg;

    nrfspi_cs_en();
 a22:	89 83       	std	Y+1, r24	; 0x01
 a24:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    nrfspi_txrx_byte(reg);
 a28:	89 81       	ldd	r24, Y+1	; 0x01
 a2a:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
    data = nrfspi_txrx_byte(0);
 a2e:	80 e0       	ldi	r24, 0x00	; 0
 a30:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
    nrfspi_cs_ds();
 a34:	89 83       	std	Y+1, r24	; 0x01
 a36:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return data;
}
 a3a:	89 81       	ldd	r24, Y+1	; 0x01
 a3c:	0f 90       	pop	r0
 a3e:	df 91       	pop	r29
 a40:	cf 91       	pop	r28
 a42:	08 95       	ret

00000a44 <nrf_flushtx>:


uint8_t nrf_flushtx(void) {
 a44:	cf 93       	push	r28
 a46:	df 93       	push	r29
 a48:	1f 92       	push	r1
 a4a:	cd b7       	in	r28, 0x3d	; 61
 a4c:	de b7       	in	r29, 0x3e	; 62
    uint8_t status;

    nrfspi_cs_en();
 a4e:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    status = nrfspi_txrx_byte(NRF_CMD_FLSHT);
 a52:	81 ee       	ldi	r24, 0xE1	; 225
 a54:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
    nrfspi_cs_ds();
 a58:	89 83       	std	Y+1, r24	; 0x01
 a5a:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return status;
}
 a5e:	89 81       	ldd	r24, Y+1	; 0x01
 a60:	0f 90       	pop	r0
 a62:	df 91       	pop	r29
 a64:	cf 91       	pop	r28
 a66:	08 95       	ret

00000a68 <nrf_setmode.part.0>:
}


void nrf_setmode(nrf_mode_t mode) {
    if (mode == NRF_MODE_TX) {
        nrf_flushtx();
 a68:	0e 94 22 05 	call	0xa44	; 0xa44 <nrf_flushtx>

        nrf_regwr(NRF_REG_STATUS, _BV(NRF_BIT_RX_DR) | _BV(NRF_BIT_TX_DS) |
 a6c:	60 e7       	ldi	r22, 0x70	; 112
 a6e:	87 e0       	ldi	r24, 0x07	; 7
 a70:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>
                                  _BV(NRF_BIT_MAX_RT));

        nrf_regwr(NRF_REG_CONFIG, (NRF_INI_CONFIG & ~(_BV(NRF_BIT_PRIM_RX))) |
 a74:	6a e3       	ldi	r22, 0x3A	; 58
 a76:	80 e0       	ldi	r24, 0x00	; 0
 a78:	0c 94 6c 04 	jmp	0x8d8	; 0x8d8 <nrf_regwr>

00000a7c <nrf_flushrx>:

    return status;
}


uint8_t nrf_flushrx(void) {
 a7c:	cf 93       	push	r28
 a7e:	df 93       	push	r29
 a80:	1f 92       	push	r1
 a82:	cd b7       	in	r28, 0x3d	; 61
 a84:	de b7       	in	r29, 0x3e	; 62
    uint8_t status;

    nrfspi_cs_en();
 a86:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    status = nrfspi_txrx_byte(NRF_CMD_FLSHR);
 a8a:	82 ee       	ldi	r24, 0xE2	; 226
 a8c:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
    nrfspi_cs_ds();
 a90:	89 83       	std	Y+1, r24	; 0x01
 a92:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return status;
}
 a96:	89 81       	ldd	r24, Y+1	; 0x01
 a98:	0f 90       	pop	r0
 a9a:	df 91       	pop	r29
 a9c:	cf 91       	pop	r28
 a9e:	08 95       	ret

00000aa0 <nrf_stop_receiver>:
    _ON(NRF_CE_PRT, NRF_CE_PIN);
}


void nrf_ce_off(void) {
    _OFF(NRF_CE_PRT, NRF_CE_PIN);
 aa0:	28 98       	cbi	0x05, 0	; 5
}


void nrf_stop_receiver(void) {
    nrf_ce_off();
    nrf_flushrx();
 aa2:	0e 94 3e 05 	call	0xa7c	; 0xa7c <nrf_flushrx>
    _ON(EIMSK, INT0);
}


void nrf_disable_irq(void) {
    _OFF(EIMSK, INT0);
 aa6:	e8 98       	cbi	0x1d, 0	; 29
    packet_ready = 0;
 aa8:	10 92 00 01 	sts	0x0100, r1
 aac:	08 95       	ret

00000aae <nrf_setmode>:
    _OFF(NRF_CE_PRT, NRF_CE_PIN);
}


void nrf_setmode(nrf_mode_t mode) {
    if (mode == NRF_MODE_TX) {
 aae:	81 30       	cpi	r24, 0x01	; 1
 ab0:	89 f0       	breq	.+34     	; 0xad4 <nrf_setmode+0x26>
        nrf_regwr(NRF_REG_STATUS, _BV(NRF_BIT_RX_DR) | _BV(NRF_BIT_TX_DS) |
                                  _BV(NRF_BIT_MAX_RT));

        nrf_regwr(NRF_REG_CONFIG, (NRF_INI_CONFIG & ~(_BV(NRF_BIT_PRIM_RX))) |
                                  _BV(NRF_BIT_PWR_UP));
    } else if (mode == NRF_MODE_RX ) {
 ab2:	82 30       	cpi	r24, 0x02	; 2
 ab4:	29 f0       	breq	.+10     	; 0xac0 <nrf_setmode+0x12>
    _ON(NRF_CE_PRT, NRF_CE_PIN);
}


void nrf_ce_off(void) {
    _OFF(NRF_CE_PRT, NRF_CE_PIN);
 ab6:	28 98       	cbi	0x05, 0	; 5

        nrf_regwr(NRF_REG_CONFIG, NRF_INI_CONFIG | _BV(NRF_BIT_PWR_UP) |
                                  _BV(NRF_BIT_PRIM_RX));
    } else {
        nrf_ce_off();
        nrf_regwr(NRF_REG_CONFIG, NRF_INI_CONFIG & ~(_BV(NRF_BIT_PWR_UP)));
 ab8:	69 e3       	ldi	r22, 0x39	; 57
 aba:	80 e0       	ldi	r24, 0x00	; 0
 abc:	0c 94 6c 04 	jmp	0x8d8	; 0x8d8 <nrf_regwr>
                                  _BV(NRF_BIT_MAX_RT));

        nrf_regwr(NRF_REG_CONFIG, (NRF_INI_CONFIG & ~(_BV(NRF_BIT_PRIM_RX))) |
                                  _BV(NRF_BIT_PWR_UP));
    } else if (mode == NRF_MODE_RX ) {
        nrf_flushrx();
 ac0:	0e 94 3e 05 	call	0xa7c	; 0xa7c <nrf_flushrx>

        nrf_regwr(NRF_REG_STATUS, _BV(NRF_BIT_RX_DR) | _BV(NRF_BIT_TX_DS)
 ac4:	60 e7       	ldi	r22, 0x70	; 112
 ac6:	87 e0       	ldi	r24, 0x07	; 7
 ac8:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>
                                  | _BV(NRF_BIT_MAX_RT));

        nrf_regwr(NRF_REG_CONFIG, NRF_INI_CONFIG | _BV(NRF_BIT_PWR_UP) |
 acc:	6b e3       	ldi	r22, 0x3B	; 59
 ace:	80 e0       	ldi	r24, 0x00	; 0
 ad0:	0c 94 6c 04 	jmp	0x8d8	; 0x8d8 <nrf_regwr>
 ad4:	0c 94 34 05 	jmp	0xa68	; 0xa68 <nrf_setmode.part.0>

00000ad8 <nrf_start_receiver>:
    return ack;
}


void nrf_start_receiver(void) {
    packet_ready = 0;
 ad8:	10 92 00 01 	sts	0x0100, r1

    nrf_setmode(NRF_MODE_RX);
 adc:	82 e0       	ldi	r24, 0x02	; 2
 ade:	0e 94 57 05 	call	0xaae	; 0xaae <nrf_setmode>
}


// application-level commands
void nrf_enable_irq(void) {
    _ON(EIMSK, INT0);
 ae2:	e8 9a       	sbi	0x1d, 0	; 29
}


// chip commands
void nrf_ce_on(void) {
    _ON(NRF_CE_PRT, NRF_CE_PIN);
 ae4:	28 9a       	sbi	0x05, 0	; 5
 ae6:	08 95       	ret

00000ae8 <nrf_reusetx>:

    return status;
}


uint8_t nrf_reusetx(void) {
 ae8:	cf 93       	push	r28
 aea:	df 93       	push	r29
 aec:	1f 92       	push	r1
 aee:	cd b7       	in	r28, 0x3d	; 61
 af0:	de b7       	in	r29, 0x3e	; 62
    uint8_t status;

    nrfspi_cs_en();
 af2:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    status = nrfspi_txrx_byte(NRF_CMD_REUSE);
 af6:	83 ee       	ldi	r24, 0xE3	; 227
 af8:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
    nrfspi_cs_ds();
 afc:	89 83       	std	Y+1, r24	; 0x01
 afe:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return status;
}
 b02:	89 81       	ldd	r24, Y+1	; 0x01
 b04:	0f 90       	pop	r0
 b06:	df 91       	pop	r29
 b08:	cf 91       	pop	r28
 b0a:	08 95       	ret

00000b0c <nrf_rxplwidth>:


uint8_t nrf_rxplwidth(void) {
 b0c:	cf 93       	push	r28
 b0e:	df 93       	push	r29
 b10:	1f 92       	push	r1
 b12:	cd b7       	in	r28, 0x3d	; 61
 b14:	de b7       	in	r29, 0x3e	; 62
    uint8_t ret;

    nrfspi_cs_en();
 b16:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    nrfspi_txrx_byte(NRF_CMD_RXPLW);
 b1a:	80 e6       	ldi	r24, 0x60	; 96
 b1c:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
    ret = nrfspi_txrx_byte(0);
 b20:	80 e0       	ldi	r24, 0x00	; 0
 b22:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
    nrfspi_cs_ds();
 b26:	89 83       	std	Y+1, r24	; 0x01
 b28:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return ret;
}
 b2c:	89 81       	ldd	r24, Y+1	; 0x01
 b2e:	0f 90       	pop	r0
 b30:	df 91       	pop	r29
 b32:	cf 91       	pop	r28
 b34:	08 95       	ret

00000b36 <nrf_ackpl>:


uint8_t nrf_ackpl(uint8_t pipe, uint8_t len, uint8_t *buf) {
 b36:	ef 92       	push	r14
 b38:	ff 92       	push	r15
 b3a:	0f 93       	push	r16
 b3c:	1f 93       	push	r17
 b3e:	cf 93       	push	r28
 b40:	df 93       	push	r29
 b42:	1f 92       	push	r1
 b44:	cd b7       	in	r28, 0x3d	; 61
 b46:	de b7       	in	r29, 0x3e	; 62
 b48:	06 2f       	mov	r16, r22
 b4a:	7a 01       	movw	r14, r20
    uint8_t status;
    
    nrfspi_cs_en();
 b4c:	89 83       	std	Y+1, r24	; 0x01
 b4e:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    status = nrfspi_txrx_byte(NRF_CMD_RXPLW | pipe);
 b52:	89 81       	ldd	r24, Y+1	; 0x01
 b54:	80 66       	ori	r24, 0x60	; 96
 b56:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
 b5a:	18 2f       	mov	r17, r24
    nrfspi_txrx(len, buf, 0);
 b5c:	40 e0       	ldi	r20, 0x00	; 0
 b5e:	50 e0       	ldi	r21, 0x00	; 0
 b60:	b7 01       	movw	r22, r14
 b62:	80 2f       	mov	r24, r16
 b64:	0e 94 48 06 	call	0xc90	; 0xc90 <nrfspi_txrx>
    nrfspi_cs_ds();
 b68:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return status;
}
 b6c:	81 2f       	mov	r24, r17
 b6e:	0f 90       	pop	r0
 b70:	df 91       	pop	r29
 b72:	cf 91       	pop	r28
 b74:	1f 91       	pop	r17
 b76:	0f 91       	pop	r16
 b78:	ff 90       	pop	r15
 b7a:	ef 90       	pop	r14
 b7c:	08 95       	ret

00000b7e <nrf_txnoack>:


uint8_t nrf_txnoack(uint8_t pipe, uint8_t len, uint8_t *buf) {
 b7e:	ef 92       	push	r14
 b80:	ff 92       	push	r15
 b82:	0f 93       	push	r16
 b84:	1f 93       	push	r17
 b86:	cf 93       	push	r28
 b88:	df 93       	push	r29
 b8a:	1f 92       	push	r1
 b8c:	cd b7       	in	r28, 0x3d	; 61
 b8e:	de b7       	in	r29, 0x3e	; 62
 b90:	06 2f       	mov	r16, r22
 b92:	7a 01       	movw	r14, r20
    uint8_t status;

    nrfspi_cs_en();
 b94:	89 83       	std	Y+1, r24	; 0x01
 b96:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    status = nrfspi_txrx_byte(NRF_CMD_NOACK | pipe);
 b9a:	89 81       	ldd	r24, Y+1	; 0x01
 b9c:	80 6b       	ori	r24, 0xB0	; 176
 b9e:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
 ba2:	18 2f       	mov	r17, r24
    nrfspi_txrx(len, buf, 0);
 ba4:	40 e0       	ldi	r20, 0x00	; 0
 ba6:	50 e0       	ldi	r21, 0x00	; 0
 ba8:	b7 01       	movw	r22, r14
 baa:	80 2f       	mov	r24, r16
 bac:	0e 94 48 06 	call	0xc90	; 0xc90 <nrfspi_txrx>
    nrfspi_cs_ds();
 bb0:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return status;
}
 bb4:	81 2f       	mov	r24, r17
 bb6:	0f 90       	pop	r0
 bb8:	df 91       	pop	r29
 bba:	cf 91       	pop	r28
 bbc:	1f 91       	pop	r17
 bbe:	0f 91       	pop	r16
 bc0:	ff 90       	pop	r15
 bc2:	ef 90       	pop	r14
 bc4:	08 95       	ret

00000bc6 <nrf_status>:


uint8_t nrf_status(void) {
 bc6:	cf 93       	push	r28
 bc8:	df 93       	push	r29
 bca:	1f 92       	push	r1
 bcc:	cd b7       	in	r28, 0x3d	; 61
 bce:	de b7       	in	r29, 0x3e	; 62
    uint8_t status;

    nrfspi_cs_en();
 bd0:	0e 94 7f 06 	call	0xcfe	; 0xcfe <nrfspi_cs_en>
    status = nrfspi_txrx_byte(NRF_CMD_XXNOP);
 bd4:	8f ef       	ldi	r24, 0xFF	; 255
 bd6:	0e 94 72 06 	call	0xce4	; 0xce4 <nrfspi_txrx_byte>
    nrfspi_cs_ds();
 bda:	89 83       	std	Y+1, r24	; 0x01
 bdc:	0e 94 81 06 	call	0xd02	; 0xd02 <nrfspi_cs_ds>

    return status;
}
 be0:	89 81       	ldd	r24, Y+1	; 0x01
 be2:	0f 90       	pop	r0
 be4:	df 91       	pop	r29
 be6:	cf 91       	pop	r28
 be8:	08 95       	ret

00000bea <nrf_transmit_packet>:
    _OFF(EIMSK, INT0);
    packet_ready = 0;
}


uint8_t nrf_transmit_packet(uint8_t *addr, uint8_t *buf) {
 bea:	0f 93       	push	r16
 bec:	1f 93       	push	r17
 bee:	cf 93       	push	r28
 bf0:	df 93       	push	r29
 bf2:	ec 01       	movw	r28, r24
 bf4:	8b 01       	movw	r16, r22
    _ON(NRF_CE_PRT, NRF_CE_PIN);
}


void nrf_ce_off(void) {
    _OFF(NRF_CE_PRT, NRF_CE_PIN);
 bf6:	28 98       	cbi	0x05, 0	; 5
 bf8:	0e 94 34 05 	call	0xa68	; 0xa68 <nrf_setmode.part.0>
    // switch to transmit mode
    nrf_ce_off();
    nrf_setmode(NRF_MODE_TX);

    // set transmit address
    nrf_regwr_long(NRF_REG_RX_ADDR_P0, COM_AD_SIZE, addr);
 bfc:	ae 01       	movw	r20, r28
 bfe:	63 e0       	ldi	r22, 0x03	; 3
 c00:	8a e0       	ldi	r24, 0x0A	; 10
 c02:	0e 94 27 04 	call	0x84e	; 0x84e <nrf_regwr_long>
    nrf_regwr_long(NRF_REG_TX_ADDR, COM_AD_SIZE, addr);
 c06:	ae 01       	movw	r20, r28
 c08:	63 e0       	ldi	r22, 0x03	; 3
 c0a:	80 e1       	ldi	r24, 0x10	; 16
 c0c:	0e 94 27 04 	call	0x84e	; 0x84e <nrf_regwr_long>


    // load up the FIFO
    nrf_txpayload(buf);
 c10:	c8 01       	movw	r24, r16
 c12:	0e 94 fa 03 	call	0x7f4	; 0x7f4 <nrf_txpayload>
}


// chip commands
void nrf_ce_on(void) {
    _ON(NRF_CE_PRT, NRF_CE_PIN);
 c16:	28 9a       	sbi	0x05, 0	; 5
 c18:	82 e4       	ldi	r24, 0x42	; 66
 c1a:	8a 95       	dec	r24
 c1c:	f1 f7       	brne	.-4      	; 0xc1a <nrf_transmit_packet+0x30>
 c1e:	00 c0       	rjmp	.+0      	; 0xc20 <nrf_transmit_packet+0x36>
}


void nrf_ce_off(void) {
    _OFF(NRF_CE_PRT, NRF_CE_PIN);
 c20:	28 98       	cbi	0x05, 0	; 5
    nrf_ce_on();
    _delay_us(NRF_TX_PULSE_MIN_US);
    nrf_ce_off();

    // wait until transmit complete
    while ( !(nrf_status() & (_BV(NRF_BIT_TX_DS)|_BV(NRF_BIT_MAX_RT))) );
 c22:	0e 94 e3 05 	call	0xbc6	; 0xbc6 <nrf_status>
 c26:	80 73       	andi	r24, 0x30	; 48
 c28:	e1 f3       	breq	.-8      	; 0xc22 <nrf_transmit_packet+0x38>

    if ( nrf_status() & _BV(NRF_BIT_TX_DS) ) {
 c2a:	0e 94 e3 05 	call	0xbc6	; 0xbc6 <nrf_status>
 c2e:	c8 2f       	mov	r28, r24
    } else {
        ack = 0;
    }

    // clear bits
    nrf_regwr(NRF_REG_STATUS, nrf_status() | _BV(NRF_BIT_TX_DS) | _BV(NRF_BIT_MAX_RT));
 c30:	0e 94 e3 05 	call	0xbc6	; 0xbc6 <nrf_status>
 c34:	68 2f       	mov	r22, r24
 c36:	60 63       	ori	r22, 0x30	; 48
 c38:	87 e0       	ldi	r24, 0x07	; 7
 c3a:	0e 94 6c 04 	call	0x8d8	; 0x8d8 <nrf_regwr>

    // switch back to receive mode
    nrf_setmode(NRF_MODE_RX);
 c3e:	82 e0       	ldi	r24, 0x02	; 2
 c40:	0e 94 57 05 	call	0xaae	; 0xaae <nrf_setmode>
}


// chip commands
void nrf_ce_on(void) {
    _ON(NRF_CE_PRT, NRF_CE_PIN);
 c44:	28 9a       	sbi	0x05, 0	; 5
    // switch back to receive mode
    nrf_setmode(NRF_MODE_RX);
    nrf_ce_on();
    
    return ack;
}
 c46:	c5 fb       	bst	r28, 5
 c48:	88 27       	eor	r24, r24
 c4a:	80 f9       	bld	r24, 0
 c4c:	df 91       	pop	r29
 c4e:	cf 91       	pop	r28
 c50:	1f 91       	pop	r17
 c52:	0f 91       	pop	r16
 c54:	08 95       	ret

00000c56 <nrfspi_init>:

void nrfspi_init(void) {
    // NRF24L01+ accepts a maximum baud rate of 10mbps and is mode '00' with MSB first

    // set up the pins
    _ON(NRF_CSN_DDR, NRF_CSN_PIN);
 c56:	3c 9a       	sbi	0x07, 4	; 7
    _ON(NRF_SCLK_DDR, NRF_SCLK_PIN);
 c58:	54 9a       	sbi	0x0a, 4	; 10
    _ON(NRF_MOSI_DDR, NRF_MOSI_PIN);
 c5a:	51 9a       	sbi	0x0a, 1	; 10
    _OFF(NRF_MISO_DDR, NRF_MISO_PIN);
 c5c:	50 98       	cbi	0x0a, 0	; 10
    // TODO: enable interrupt mode? [if it turns out that reading a packet
    //       wastes too much time]
    //UCSR0B = ( _BV(RXCIE0) | _BV(TXCIE0) );

    // enable master spi mode, set MSB-first, mode '00'
    UCSR0C = ( _BV(UMSEL01) | _BV(UMSEL00) );
 c5e:	80 ec       	ldi	r24, 0xC0	; 192
 c60:	80 93 c2 00 	sts	0x00C2, r24
 c64:	08 95       	ret

00000c66 <nrfspi_enable>:
}


void nrfspi_enable(void) {
    // baud rate must be set after transmitter is enabled, but before transmitting
    UBRR0 = 0;
 c66:	e4 ec       	ldi	r30, 0xC4	; 196
 c68:	f0 e0       	ldi	r31, 0x00	; 0
 c6a:	11 82       	std	Z+1, r1	; 0x01
 c6c:	10 82       	st	Z, r1

    UCSR0B |= ( _BV(RXEN0) | _BV(TXEN0) );
 c6e:	a1 ec       	ldi	r26, 0xC1	; 193
 c70:	b0 e0       	ldi	r27, 0x00	; 0
 c72:	8c 91       	ld	r24, X
 c74:	88 61       	ori	r24, 0x18	; 24
 c76:	8c 93       	st	X, r24
    _ON(NRF_SCLK_DDR, NRF_SCLK_PIN);
 c78:	54 9a       	sbi	0x0a, 4	; 10

    UBRR0 = NRF_PRESCALER;
 c7a:	81 e0       	ldi	r24, 0x01	; 1
 c7c:	90 e0       	ldi	r25, 0x00	; 0
 c7e:	91 83       	std	Z+1, r25	; 0x01
 c80:	80 83       	st	Z, r24
 c82:	08 95       	ret

00000c84 <nrfspi_disable>:
}


void nrfspi_disable(void) {
    UCSR0B &= ~( _BV(RXEN0) | _BV(TXEN0) );
 c84:	e1 ec       	ldi	r30, 0xC1	; 193
 c86:	f0 e0       	ldi	r31, 0x00	; 0
 c88:	80 81       	ld	r24, Z
 c8a:	87 7e       	andi	r24, 0xE7	; 231
 c8c:	80 83       	st	Z, r24
 c8e:	08 95       	ret

00000c90 <nrfspi_txrx>:
    uint8_t count = 0;
    uint8_t tmp;

    if (rxbuf) {
        // transmit and read
        while (len--) {
 c90:	2f ef       	ldi	r18, 0xFF	; 255
 c92:	28 0f       	add	r18, r24
uint8_t nrfspi_txrx(uint8_t len, uint8_t *txbuf, uint8_t *rxbuf) {
    // UDR must be read for each byte transmitted
    uint8_t count = 0;
    uint8_t tmp;

    if (rxbuf) {
 c94:	41 15       	cp	r20, r1
 c96:	51 05       	cpc	r21, r1
 c98:	a9 f0       	breq	.+42     	; 0xcc4 <nrfspi_txrx+0x34>
        // transmit and read
        while (len--) {
 c9a:	88 23       	and	r24, r24
 c9c:	09 f1       	breq	.+66     	; 0xce0 <nrfspi_txrx+0x50>
 c9e:	da 01       	movw	r26, r20
 ca0:	fb 01       	movw	r30, r22
            while ( !(UCSR0A & _BV(UDRE0)) );
 ca2:	90 91 c0 00 	lds	r25, 0x00C0
 ca6:	95 ff       	sbrs	r25, 5
 ca8:	fc cf       	rjmp	.-8      	; 0xca2 <nrfspi_txrx+0x12>
            UDR0 = *(txbuf++);
 caa:	91 91       	ld	r25, Z+
 cac:	90 93 c6 00 	sts	0x00C6, r25

            while ( !(UCSR0A & _BV(RXC0)) );
 cb0:	90 91 c0 00 	lds	r25, 0x00C0
 cb4:	97 ff       	sbrs	r25, 7
 cb6:	fc cf       	rjmp	.-8      	; 0xcb0 <nrfspi_txrx+0x20>
            *(rxbuf++) = UDR0;
 cb8:	90 91 c6 00 	lds	r25, 0x00C6
 cbc:	9d 93       	st	X+, r25
    uint8_t count = 0;
    uint8_t tmp;

    if (rxbuf) {
        // transmit and read
        while (len--) {
 cbe:	21 50       	subi	r18, 0x01	; 1
 cc0:	80 f7       	brcc	.-32     	; 0xca2 <nrfspi_txrx+0x12>
 cc2:	08 95       	ret

            count++;
        }
    } else {
        // just transmit
        while (len--) {
 cc4:	88 23       	and	r24, r24
 cc6:	69 f0       	breq	.+26     	; 0xce2 <nrfspi_txrx+0x52>
 cc8:	fb 01       	movw	r30, r22
            while ( !(UCSR0A & _BV(UDRE0)) );
 cca:	90 91 c0 00 	lds	r25, 0x00C0
 cce:	95 ff       	sbrs	r25, 5
 cd0:	fc cf       	rjmp	.-8      	; 0xcca <nrfspi_txrx+0x3a>

            UDR0 = *(txbuf++);
 cd2:	91 91       	ld	r25, Z+
 cd4:	90 93 c6 00 	sts	0x00C6, r25
            tmp = UDR0;
 cd8:	90 91 c6 00 	lds	r25, 0x00C6

            count++;
        }
    } else {
        // just transmit
        while (len--) {
 cdc:	21 50       	subi	r18, 0x01	; 1
 cde:	a8 f7       	brcc	.-22     	; 0xcca <nrfspi_txrx+0x3a>
        }
        tmp = tmp;
    }

    return count;
}
 ce0:	08 95       	ret
 ce2:	08 95       	ret

00000ce4 <nrfspi_txrx_byte>:


uint8_t nrfspi_txrx_byte(uint8_t data) {
    uint8_t ret;

    while ( !(UCSR0A & _BV(UDRE0)) );
 ce4:	90 91 c0 00 	lds	r25, 0x00C0
 ce8:	95 ff       	sbrs	r25, 5
 cea:	fc cf       	rjmp	.-8      	; 0xce4 <nrfspi_txrx_byte>
    UDR0 = data;
 cec:	80 93 c6 00 	sts	0x00C6, r24

    while ( !(UCSR0A & _BV(RXC0)) );
 cf0:	80 91 c0 00 	lds	r24, 0x00C0
 cf4:	87 ff       	sbrs	r24, 7
 cf6:	fc cf       	rjmp	.-8      	; 0xcf0 <nrfspi_txrx_byte+0xc>
    ret = UDR0;
 cf8:	80 91 c6 00 	lds	r24, 0x00C6

    return ret;
}
 cfc:	08 95       	ret

00000cfe <nrfspi_cs_en>:


__inline void nrfspi_cs_en(void) {
    _OFF(NRF_CSN_PRT, NRF_CSN_PIN);
 cfe:	44 98       	cbi	0x08, 4	; 8
 d00:	08 95       	ret

00000d02 <nrfspi_cs_ds>:
 d02:	44 9a       	sbi	0x08, 4	; 8
 d04:	08 95       	ret

00000d06 <main>:
 d06:	0e 94 6e 00 	call	0xdc	; 0xdc <dbg_init>
 d0a:	86 e0       	ldi	r24, 0x06	; 6
 d0c:	0e 94 4e 00 	call	0x9c	; 0x9c <dbg_set>
 d10:	0e 94 f5 02 	call	0x5ea	; 0x5ea <tlc_init>
 d14:	82 e6       	ldi	r24, 0x62	; 98
 d16:	91 e0       	ldi	r25, 0x01	; 1
 d18:	0e 94 75 00 	call	0xea	; 0xea <eeprom_get_addr>
 d1c:	85 e6       	ldi	r24, 0x65	; 101
 d1e:	91 e0       	ldi	r25, 0x01	; 1
 d20:	0e 94 88 00 	call	0x110	; 0x110 <eeprom_get_chan>
 d24:	21 e0       	ldi	r18, 0x01	; 1
 d26:	31 e0       	ldi	r19, 0x01	; 1
 d28:	46 e6       	ldi	r20, 0x66	; 102
 d2a:	51 e0       	ldi	r21, 0x01	; 1
 d2c:	62 e6       	ldi	r22, 0x62	; 98
 d2e:	71 e0       	ldi	r23, 0x01	; 1
 d30:	80 91 65 01 	lds	r24, 0x0165
 d34:	0e 94 88 04 	call	0x910	; 0x910 <nrf_init>
 d38:	78 94       	sei
 d3a:	0e 94 6c 05 	call	0xad8	; 0xad8 <nrf_start_receiver>
 d3e:	0e 94 ee 03 	call	0x7dc	; 0x7dc <nrf_wait_for_rxpacket>
 d42:	62 e0       	ldi	r22, 0x02	; 2
 d44:	71 e0       	ldi	r23, 0x01	; 1
 d46:	80 91 01 01 	lds	r24, 0x0101
 d4a:	0e 94 76 01 	call	0x2ec	; 0x2ec <led_action>
 d4e:	0e 94 f3 03 	call	0x7e6	; 0x7e6 <nrf_accept_packet>
 d52:	f5 cf       	rjmp	.-22     	; 0xd3e <main+0x38>

00000d54 <__eerd_byte_m168p>:
 d54:	f9 99       	sbic	0x1f, 1	; 31
 d56:	fe cf       	rjmp	.-4      	; 0xd54 <__eerd_byte_m168p>
 d58:	92 bd       	out	0x22, r25	; 34
 d5a:	81 bd       	out	0x21, r24	; 33
 d5c:	f8 9a       	sbi	0x1f, 0	; 31
 d5e:	99 27       	eor	r25, r25
 d60:	80 b5       	in	r24, 0x20	; 32
 d62:	08 95       	ret

00000d64 <__eewr_byte_m168p>:
 d64:	26 2f       	mov	r18, r22

00000d66 <__eewr_r18_m168p>:
 d66:	f9 99       	sbic	0x1f, 1	; 31
 d68:	fe cf       	rjmp	.-4      	; 0xd66 <__eewr_r18_m168p>
 d6a:	1f ba       	out	0x1f, r1	; 31
 d6c:	92 bd       	out	0x22, r25	; 34
 d6e:	81 bd       	out	0x21, r24	; 33
 d70:	20 bd       	out	0x20, r18	; 32
 d72:	0f b6       	in	r0, 0x3f	; 63
 d74:	f8 94       	cli
 d76:	fa 9a       	sbi	0x1f, 2	; 31
 d78:	f9 9a       	sbi	0x1f, 1	; 31
 d7a:	0f be       	out	0x3f, r0	; 63
 d7c:	01 96       	adiw	r24, 0x01	; 1
 d7e:	08 95       	ret

00000d80 <_exit>:
 d80:	f8 94       	cli

00000d82 <__stop_program>:
 d82:	ff cf       	rjmp	.-2      	; 0xd82 <__stop_program>
