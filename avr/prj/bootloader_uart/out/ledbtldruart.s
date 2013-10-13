
out/ledbtldruart.out:     file format elf32-avr


Disassembly of section .text:

00003800 <__vectors>:
    3800:	0c 94 51 1c 	jmp	0x38a2	; 0x38a2 <__ctors_end>
    3804:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3808:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    380c:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3810:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3814:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3818:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    381c:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3820:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3824:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3828:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    382c:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3830:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3834:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3838:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    383c:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3840:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3844:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3848:	0c 94 90 1e 	jmp	0x3d20	; 0x3d20 <__vector_18>
    384c:	0c 94 c8 1e 	jmp	0x3d90	; 0x3d90 <__vector_19>
    3850:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3854:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3858:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    385c:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3860:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3864:	0c 94 6e 1c 	jmp	0x38dc	; 0x38dc <__bad_interrupt>
    3868:	c3 1c       	adc	r12, r3
    386a:	c9 1c       	adc	r12, r9
    386c:	a8 1c       	adc	r10, r8
    386e:	b1 1c       	adc	r11, r1
    3870:	d8 1c       	adc	r13, r8
    3872:	dc 1c       	adc	r13, r12
    3874:	a8 1c       	adc	r10, r8
    3876:	f2 1c       	adc	r15, r2
    3878:	02 1d       	adc	r16, r2
    387a:	0f 1d       	adc	r16, r15
    387c:	e0 1c       	adc	r14, r0
    387e:	37 1d       	adc	r19, r7
    3880:	44 1d       	adc	r20, r4
    3882:	a8 1c       	adc	r10, r8
    3884:	3b 1d       	adc	r19, r11
    3886:	2f 1d       	adc	r18, r15
    3888:	23 1d       	adc	r18, r3
    388a:	a8 1c       	adc	r10, r8
    388c:	a8 1c       	adc	r10, r8
    388e:	a8 1c       	adc	r10, r8
    3890:	a8 1c       	adc	r10, r8
    3892:	a8 1c       	adc	r10, r8
    3894:	a8 1c       	adc	r10, r8
    3896:	a8 1c       	adc	r10, r8
    3898:	a8 1c       	adc	r10, r8
    389a:	a8 1c       	adc	r10, r8
    389c:	5d 1d       	adc	r21, r13
    389e:	a8 1c       	adc	r10, r8
    38a0:	48 1d       	adc	r20, r8

000038a2 <__ctors_end>:
    38a2:	11 24       	eor	r1, r1
    38a4:	1f be       	out	0x3f, r1	; 63
    38a6:	cf ef       	ldi	r28, 0xFF	; 255
    38a8:	d4 e0       	ldi	r29, 0x04	; 4
    38aa:	de bf       	out	0x3e, r29	; 62
    38ac:	cd bf       	out	0x3d, r28	; 61

000038ae <__do_copy_data>:
    38ae:	11 e0       	ldi	r17, 0x01	; 1
    38b0:	a0 e0       	ldi	r26, 0x00	; 0
    38b2:	b1 e0       	ldi	r27, 0x01	; 1
    38b4:	e4 ef       	ldi	r30, 0xF4	; 244
    38b6:	ff e3       	ldi	r31, 0x3F	; 63
    38b8:	02 c0       	rjmp	.+4      	; 0x38be <__do_copy_data+0x10>
    38ba:	05 90       	lpm	r0, Z+
    38bc:	0d 92       	st	X+, r0
    38be:	a8 30       	cpi	r26, 0x08	; 8
    38c0:	b1 07       	cpc	r27, r17
    38c2:	d9 f7       	brne	.-10     	; 0x38ba <__do_copy_data+0xc>

000038c4 <__do_clear_bss>:
    38c4:	11 e0       	ldi	r17, 0x01	; 1
    38c6:	a8 e0       	ldi	r26, 0x08	; 8
    38c8:	b1 e0       	ldi	r27, 0x01	; 1
    38ca:	01 c0       	rjmp	.+2      	; 0x38ce <.do_clear_bss_start>

000038cc <.do_clear_bss_loop>:
    38cc:	1d 92       	st	X+, r1

000038ce <.do_clear_bss_start>:
    38ce:	a7 3d       	cpi	r26, 0xD7	; 215
    38d0:	b1 07       	cpc	r27, r17
    38d2:	e1 f7       	brne	.-8      	; 0x38cc <.do_clear_bss_loop>
    38d4:	0e 94 a9 1f 	call	0x3f52	; 0x3f52 <main>
    38d8:	0c 94 f8 1f 	jmp	0x3ff0	; 0x3ff0 <_exit>

000038dc <__bad_interrupt>:
    38dc:	0c 94 00 1c 	jmp	0x3800	; 0x3800 <__vectors>

000038e0 <give_up>:
 *    bootloader from trying to run the application at the beginning.
 *  - Go back and wait for new data.
 */
void give_up(uint8_t corrupted) {
    uint16_t i;
    if (corrupted) {
    38e0:	88 23       	and	r24, r24
    38e2:	29 f1       	breq	.+74     	; 0x392e <give_up+0x4e>
        // set LEDs to "shit really hit the fan"
        dbg_set(0xA);
    38e4:	8a e0       	ldi	r24, 0x0A	; 10
    38e6:	0e 94 85 1d 	call	0x3b0a	; 0x3b0a <dbg_set>

        // fill the first page with 0xFF
        for ( i=0 ; i<PAGESIZE ; i+=2 ) {
    38ea:	e0 e0       	ldi	r30, 0x00	; 0
    38ec:	f0 e0       	ldi	r31, 0x00	; 0
            boot_page_fill_safe(i, 0xFFFF);
    38ee:	21 e0       	ldi	r18, 0x01	; 1
    38f0:	8f ef       	ldi	r24, 0xFF	; 255
    38f2:	9f ef       	ldi	r25, 0xFF	; 255
    38f4:	07 b6       	in	r0, 0x37	; 55
    38f6:	00 fc       	sbrc	r0, 0
    38f8:	fd cf       	rjmp	.-6      	; 0x38f4 <give_up+0x14>
    38fa:	f9 99       	sbic	0x1f, 1	; 31
    38fc:	fe cf       	rjmp	.-4      	; 0x38fa <give_up+0x1a>
    38fe:	0c 01       	movw	r0, r24
    3900:	20 93 57 00 	sts	0x0057, r18
    3904:	e8 95       	spm
    3906:	11 24       	eor	r1, r1
    if (corrupted) {
        // set LEDs to "shit really hit the fan"
        dbg_set(0xA);

        // fill the first page with 0xFF
        for ( i=0 ; i<PAGESIZE ; i+=2 ) {
    3908:	32 96       	adiw	r30, 0x02	; 2
    390a:	e0 38       	cpi	r30, 0x80	; 128
    390c:	f1 05       	cpc	r31, r1
    390e:	91 f7       	brne	.-28     	; 0x38f4 <give_up+0x14>
            boot_page_fill_safe(i, 0xFFFF);
        }
        boot_page_write_safe(0);
    3910:	07 b6       	in	r0, 0x37	; 55
    3912:	00 fc       	sbrc	r0, 0
    3914:	fd cf       	rjmp	.-6      	; 0x3910 <give_up+0x30>
    3916:	f9 99       	sbic	0x1f, 1	; 31
    3918:	fe cf       	rjmp	.-4      	; 0x3916 <give_up+0x36>
    391a:	e0 e0       	ldi	r30, 0x00	; 0
    391c:	f0 e0       	ldi	r31, 0x00	; 0
    391e:	85 e0       	ldi	r24, 0x05	; 5
    3920:	80 93 57 00 	sts	0x0057, r24
    3924:	e8 95       	spm
        boot_spm_busy_wait();
    3926:	07 b6       	in	r0, 0x37	; 55
    3928:	00 fc       	sbrc	r0, 0
    392a:	fd cf       	rjmp	.-6      	; 0x3926 <give_up+0x46>
    392c:	ff cf       	rjmp	.-2      	; 0x392c <give_up+0x4c>

        // halt
        while(1);
    } else {
        // set LEDs to "shit slightly hit the fan"
        dbg_set(0x9);
    392e:	89 e0       	ldi	r24, 0x09	; 9
    3930:	0e 94 85 1d 	call	0x3b0a	; 0x3b0a <dbg_set>
    }

    // return to waiting for data
    curstate = CST_IDLE;    // reset state machine
    3934:	10 92 8e 01 	sts	0x018E, r1
    receive_data();
    3938:	0e 94 71 1d 	call	0x3ae2	; 0x3ae2 <receive_data>

0000393c <process_rx>:
        if ( uart_rb_data_rdy() ) process_rx();
    }
}

/* Processed a received byte */
void process_rx(void) {
    393c:	cf 93       	push	r28
    uint8_t data, i;
    uint8_t csum = 0;
    data = uart_rb_rx();
    393e:	0e 94 59 1f 	call	0x3eb2	; 0x3eb2 <uart_rb_rx>
    3942:	c8 2f       	mov	r28, r24

    switch (curstate) {
    3944:	40 91 8e 01 	lds	r20, 0x018E
    3948:	50 e0       	ldi	r21, 0x00	; 0
    394a:	4b 30       	cpi	r20, 0x0B	; 11
    394c:	51 05       	cpc	r21, r1
    394e:	20 f0       	brcs	.+8      	; 0x3958 <process_rx+0x1c>
            }
            dbg_on(0x3);
            break;

        default:
            curstate = CST_IDLE;
    3950:	10 92 8e 01 	sts	0x018E, r1
            break;
    }
}
    3954:	cf 91       	pop	r28
    3956:	08 95       	ret
void process_rx(void) {
    uint8_t data, i;
    uint8_t csum = 0;
    data = uart_rb_rx();

    switch (curstate) {
    3958:	fa 01       	movw	r30, r20
    395a:	ec 5c       	subi	r30, 0xCC	; 204
    395c:	f3 4e       	sbci	r31, 0xE3	; 227
    395e:	0c 94 dc 1f 	jmp	0x3fb8	; 0x3fb8 <__tablejump2__>
    eeprom_busy_wait();
    return eeprom_read_byte(EEPROM_INST_ADDR);

}
void addr_set(uint8_t address) {
    eeprom_busy_wait();
    3962:	f9 99       	sbic	0x1f, 1	; 31
    3964:	fe cf       	rjmp	.-4      	; 0x3962 <process_rx+0x26>
    eeprom_write_byte(EEPROM_INST_ADDR, address);
    3966:	6c 2f       	mov	r22, r28
    3968:	81 e0       	ldi	r24, 0x01	; 1
    396a:	90 e0       	ldi	r25, 0x00	; 0
    396c:	0e 94 ea 1f 	call	0x3fd4	; 0x3fd4 <__eewr_byte_m168p>
            } 
            break;

        case CST_ADDR:
            addr_set(data);
            curstate = CST_IDLE;
    3970:	10 92 8e 01 	sts	0x018E, r1
    receive_data();
}

/* Get and set the single-byte instrument address */
uint8_t addr_get(void) {
    eeprom_busy_wait();
    3974:	f9 99       	sbic	0x1f, 1	; 31
    3976:	fe cf       	rjmp	.-4      	; 0x3974 <process_rx+0x38>
    return eeprom_read_byte(EEPROM_INST_ADDR);
    3978:	81 e0       	ldi	r24, 0x01	; 1
    397a:	90 e0       	ldi	r25, 0x00	; 0
    397c:	0e 94 e2 1f 	call	0x3fc4	; 0x3fc4 <__eerd_byte_m168p>
            break;

        case CST_ADDR:
            addr_set(data);
            curstate = CST_IDLE;
            my_addr = addr_get();
    3980:	80 93 95 01 	sts	0x0195, r24
            break;
    3984:	e7 cf       	rjmp	.-50     	; 0x3954 <process_rx+0x18>
    uint8_t csum = 0;
    data = uart_rb_rx();

    switch (curstate) {
        case CST_IDLE:
            if ( data == CMD_SYNC ) curstate = CST_SYNC;
    3986:	8a 3a       	cpi	r24, 0xAA	; 170
    3988:	19 f7       	brne	.-58     	; 0x3950 <process_rx+0x14>
    398a:	81 e0       	ldi	r24, 0x01	; 1
    398c:	80 93 8e 01 	sts	0x018E, r24
    3990:	e1 cf       	rjmp	.-62     	; 0x3954 <process_rx+0x18>
            else curstate = CST_IDLE;
            break;
        case CST_SYNC:
            if ( data == CMD_NOP ) curstate = CST_IDLE;
    3992:	8e 34       	cpi	r24, 0x4E	; 78
    3994:	e9 f2       	breq	.-70     	; 0x3950 <process_rx+0x14>
            else if ( data == CMD_SYNC ) curstate = CST_SYNC;
    3996:	8a 3a       	cpi	r24, 0xAA	; 170
    3998:	c1 f3       	breq	.-16     	; 0x398a <process_rx+0x4e>
            else {
                switch (data) {
    399a:	90 e0       	ldi	r25, 0x00	; 0
    399c:	fc 01       	movw	r30, r24
    399e:	e1 54       	subi	r30, 0x41	; 65
    39a0:	f1 09       	sbc	r31, r1
    39a2:	e2 31       	cpi	r30, 0x12	; 18
    39a4:	f1 05       	cpc	r31, r1
    39a6:	a0 f6       	brcc	.-88     	; 0x3950 <process_rx+0x14>
    39a8:	e1 5c       	subi	r30, 0xC1	; 193
    39aa:	f3 4e       	sbci	r31, 0xE3	; 227
    39ac:	0c 94 dc 1f 	jmp	0x3fb8	; 0x3fb8 <__tablejump2__>
            curstate = CST_IDLE;
            my_addr = addr_get();
            break;

        case CST_BAUD_H:
            curstate = CST_BAUD_L;
    39b0:	85 e0       	ldi	r24, 0x05	; 5
    39b2:	80 93 8e 01 	sts	0x018E, r24
            break;
    39b6:	ce cf       	rjmp	.-100    	; 0x3954 <process_rx+0x18>
        case CST_BAUD_L:
            curstate = CST_BAUD_D;
    39b8:	86 e0       	ldi	r24, 0x06	; 6
    39ba:	80 93 8e 01 	sts	0x018E, r24
            break;
    39be:	ca cf       	rjmp	.-108    	; 0x3954 <process_rx+0x18>
            } else {
                curstate = CST_PROG_D;
            }
            break;
        case CST_PROG_V:
            curstate = CST_IDLE;
    39c0:	10 92 8e 01 	sts	0x018E, r1
    39c4:	ee e0       	ldi	r30, 0x0E	; 14
    39c6:	f1 e0       	ldi	r31, 0x01	; 1
}

/* Processed a received byte */
void process_rx(void) {
    uint8_t data, i;
    uint8_t csum = 0;
    39c8:	90 e0       	ldi	r25, 0x00	; 0
            break;
        case CST_PROG_V:
            curstate = CST_IDLE;

            for ( i=0 ; i<PAGESIZE ; i++ ) {
                csum += page_buf[i];
    39ca:	21 91       	ld	r18, Z+
    39cc:	92 0f       	add	r25, r18
            }
            break;
        case CST_PROG_V:
            curstate = CST_IDLE;

            for ( i=0 ; i<PAGESIZE ; i++ ) {
    39ce:	81 e0       	ldi	r24, 0x01	; 1
    39d0:	ee 38       	cpi	r30, 0x8E	; 142
    39d2:	f8 07       	cpc	r31, r24
    39d4:	d1 f7       	brne	.-12     	; 0x39ca <process_rx+0x8e>
                csum += page_buf[i];
            }
            csum = ~csum;
    39d6:	90 95       	com	r25

            if ( csum == data ) {
    39d8:	9c 17       	cp	r25, r28
    39da:	09 f4       	brne	.+2      	; 0x39de <process_rx+0xa2>
    39dc:	76 c0       	rjmp	.+236    	; 0x3aca <process_rx+0x18e>
                flash_write_page(page_addr, page_buf);
            } else {
                // damnit...
                // TODO: we can be slightly smarter (if it's the first address,
                // we technically haven't corrupted anything yet)
                give_up(1);
    39de:	81 e0       	ldi	r24, 0x01	; 1
    39e0:	0e 94 70 1c 	call	0x38e0	; 0x38e0 <give_up>
            // TODO: save some space by always setting double to 1
            curstate = CST_IDLE;
            break;

        case CST_PROG_A_H:
            dbg_set(data);
    39e4:	0e 94 85 1d 	call	0x3b0a	; 0x3b0a <dbg_set>
            page_addr = data << 8;
    39e8:	10 92 0a 01 	sts	0x010A, r1
    39ec:	c0 93 0b 01 	sts	0x010B, r28
            // reset page buffer pointer
            page_buf_ptr = page_buf;
    39f0:	8e e0       	ldi	r24, 0x0E	; 14
    39f2:	91 e0       	ldi	r25, 0x01	; 1
    39f4:	90 93 0d 01 	sts	0x010D, r25
    39f8:	80 93 0c 01 	sts	0x010C, r24
            curstate = CST_PROG_A_L;
    39fc:	88 e0       	ldi	r24, 0x08	; 8
    39fe:	80 93 8e 01 	sts	0x018E, r24
            break;
    3a02:	a8 cf       	rjmp	.-176    	; 0x3954 <process_rx+0x18>
        case CST_PROG_A_L:
            //dbg_set(data);    // not useful
            page_addr |= data;
    3a04:	20 91 0a 01 	lds	r18, 0x010A
    3a08:	30 91 0b 01 	lds	r19, 0x010B
    3a0c:	28 2b       	or	r18, r24
    3a0e:	30 93 0b 01 	sts	0x010B, r19
    3a12:	20 93 0a 01 	sts	0x010A, r18
            curstate = CST_PROG_D;
    3a16:	89 e0       	ldi	r24, 0x09	; 9
    3a18:	80 93 8e 01 	sts	0x018E, r24
            break;
    3a1c:	9b cf       	rjmp	.-202    	; 0x3954 <process_rx+0x18>
        case CST_PROG_D:
            *(page_buf_ptr++) = data;
    3a1e:	e0 91 0c 01 	lds	r30, 0x010C
    3a22:	f0 91 0d 01 	lds	r31, 0x010D
    3a26:	9f 01       	movw	r18, r30
    3a28:	2f 5f       	subi	r18, 0xFF	; 255
    3a2a:	3f 4f       	sbci	r19, 0xFF	; 255
    3a2c:	30 93 0d 01 	sts	0x010D, r19
    3a30:	20 93 0c 01 	sts	0x010C, r18
    3a34:	80 83       	st	Z, r24
            if ( page_buf_ptr - page_buf == PAGESIZE ) {
    3a36:	2e 58       	subi	r18, 0x8E	; 142
    3a38:	31 40       	sbci	r19, 0x01	; 1
    3a3a:	09 f4       	brne	.+2      	; 0x3a3e <process_rx+0x102>
    3a3c:	42 c0       	rjmp	.+132    	; 0x3ac2 <process_rx+0x186>
                // we hit the last byte of the page, so the next byte is the
                // checksum
                curstate = CST_PROG_V;
            } else {
                curstate = CST_PROG_D;
    3a3e:	89 e0       	ldi	r24, 0x09	; 9
    3a40:	80 93 8e 01 	sts	0x018E, r24
    3a44:	87 cf       	rjmp	.-242    	; 0x3954 <process_rx+0x18>
                    case CMD_PROG:
                        curstate = CST_PROG_A_H;
                        break;

                    case CMD_FNSH:
                        boot_rww_enable_safe();
    3a46:	07 b6       	in	r0, 0x37	; 55
    3a48:	00 fc       	sbrc	r0, 0
    3a4a:	fd cf       	rjmp	.-6      	; 0x3a46 <process_rx+0x10a>
    3a4c:	f9 99       	sbic	0x1f, 1	; 31
    3a4e:	fe cf       	rjmp	.-4      	; 0x3a4c <process_rx+0x110>
    3a50:	81 e1       	ldi	r24, 0x11	; 17
    3a52:	80 93 57 00 	sts	0x0057, r24
    3a56:	e8 95       	spm
                        curstate = CST_IDLE;
    3a58:	10 92 8e 01 	sts	0x018E, r1
                        break;
    3a5c:	7b cf       	rjmp	.-266    	; 0x3954 <process_rx+0x18>
                    case CMD_DISP_ADDR_H:
                        dbg_set(my_addr>>4);
                        curstate = CST_IDLE;
                        break;
                    case CMD_DISP_ADDR_L:
                        dbg_set(my_addr&0x0F);
    3a5e:	80 91 95 01 	lds	r24, 0x0195
    3a62:	8f 70       	andi	r24, 0x0F	; 15
    3a64:	0e 94 85 1d 	call	0x3b0a	; 0x3b0a <dbg_set>
                        curstate = CST_IDLE;
    3a68:	10 92 8e 01 	sts	0x018E, r1
                        break;
    3a6c:	73 cf       	rjmp	.-282    	; 0x3954 <process_rx+0x18>

                    case CMD_ADDR:
                        curstate = CST_ADDR;
    3a6e:	83 e0       	ldi	r24, 0x03	; 3
    3a70:	80 93 8e 01 	sts	0x018E, r24
                        break;
    3a74:	6f cf       	rjmp	.-290    	; 0x3954 <process_rx+0x18>
                        app_start();
                        curstate = CST_IDLE;
                        break;
                        
                    case CMD_DISP_ADDR_H:
                        dbg_set(my_addr>>4);
    3a76:	80 91 95 01 	lds	r24, 0x0195
    3a7a:	82 95       	swap	r24
    3a7c:	8f 70       	andi	r24, 0x0F	; 15
    3a7e:	0e 94 85 1d 	call	0x3b0a	; 0x3b0a <dbg_set>
                        curstate = CST_IDLE;
    3a82:	10 92 8e 01 	sts	0x018E, r1
                        break;
    3a86:	66 cf       	rjmp	.-308    	; 0x3954 <process_rx+0x18>
                    case CMD_ADDR:
                        curstate = CST_ADDR;
                        break;

                    case CMD_BAUD:
                        curstate = CST_BAUD_H;
    3a88:	84 e0       	ldi	r24, 0x04	; 4
    3a8a:	80 93 8e 01 	sts	0x018E, r24
                        break;
    3a8e:	62 cf       	rjmp	.-316    	; 0x3954 <process_rx+0x18>
            if ( data == CMD_NOP ) curstate = CST_IDLE;
            else if ( data == CMD_SYNC ) curstate = CST_SYNC;
            else {
                switch (data) {
                    case CMD_BOOT:
                        cli();
    3a90:	f8 94       	cli
                        boot_rww_enable_safe();
    3a92:	07 b6       	in	r0, 0x37	; 55
    3a94:	00 fc       	sbrc	r0, 0
    3a96:	fd cf       	rjmp	.-6      	; 0x3a92 <process_rx+0x156>
    3a98:	f9 99       	sbic	0x1f, 1	; 31
    3a9a:	fe cf       	rjmp	.-4      	; 0x3a98 <process_rx+0x15c>
    3a9c:	81 e1       	ldi	r24, 0x11	; 17
    3a9e:	80 93 57 00 	sts	0x0057, r24
    3aa2:	e8 95       	spm
                        MCUCR = (1<<IVCE);
    3aa4:	81 e0       	ldi	r24, 0x01	; 1
    3aa6:	85 bf       	out	0x35, r24	; 53
                        MCUCR = 0;
    3aa8:	15 be       	out	0x35, r1	; 53
                        app_start();
    3aaa:	e0 91 08 01 	lds	r30, 0x0108
    3aae:	f0 91 09 01 	lds	r31, 0x0109
    3ab2:	09 95       	icall
                        curstate = CST_IDLE;
    3ab4:	10 92 8e 01 	sts	0x018E, r1
                        break;
    3ab8:	4d cf       	rjmp	.-358    	; 0x3954 <process_rx+0x18>
                    case CMD_BAUD:
                        curstate = CST_BAUD_H;
                        break;

                    case CMD_PROG:
                        curstate = CST_PROG_A_H;
    3aba:	87 e0       	ldi	r24, 0x07	; 7
    3abc:	80 93 8e 01 	sts	0x018E, r24
                        break;
    3ac0:	49 cf       	rjmp	.-366    	; 0x3954 <process_rx+0x18>
        case CST_PROG_D:
            *(page_buf_ptr++) = data;
            if ( page_buf_ptr - page_buf == PAGESIZE ) {
                // we hit the last byte of the page, so the next byte is the
                // checksum
                curstate = CST_PROG_V;
    3ac2:	8a e0       	ldi	r24, 0x0A	; 10
    3ac4:	80 93 8e 01 	sts	0x018E, r24
    3ac8:	45 cf       	rjmp	.-374    	; 0x3954 <process_rx+0x18>
            }
            csum = ~csum;

            if ( csum == data ) {
                // checksum verifies, so write the page
                flash_write_page(page_addr, page_buf);
    3aca:	6e e0       	ldi	r22, 0x0E	; 14
    3acc:	71 e0       	ldi	r23, 0x01	; 1
    3ace:	80 91 0a 01 	lds	r24, 0x010A
    3ad2:	90 91 0b 01 	lds	r25, 0x010B
    3ad6:	0e 94 11 1e 	call	0x3c22	; 0x3c22 <flash_write_page>
                // damnit...
                // TODO: we can be slightly smarter (if it's the first address,
                // we technically haven't corrupted anything yet)
                give_up(1);
            }
            dbg_on(0x3);
    3ada:	83 e0       	ldi	r24, 0x03	; 3

        default:
            curstate = CST_IDLE;
            break;
    }
}
    3adc:	cf 91       	pop	r28
                // damnit...
                // TODO: we can be slightly smarter (if it's the first address,
                // we technically haven't corrupted anything yet)
                give_up(1);
            }
            dbg_on(0x3);
    3ade:	0c 94 8e 1d 	jmp	0x3b1c	; 0x3b1c <dbg_on>

00003ae2 <receive_data>:
}

/* Loop, waiting for data */
void receive_data(void) {
    while (1) {
        if ( uart_rb_data_rdy() ) process_rx();
    3ae2:	0e 94 56 1f 	call	0x3eac	; 0x3eac <uart_rb_data_rdy>
    3ae6:	88 23       	and	r24, r24
    3ae8:	e1 f3       	breq	.-8      	; 0x3ae2 <receive_data>
    3aea:	0e 94 9e 1c 	call	0x393c	; 0x393c <process_rx>
    3aee:	f9 cf       	rjmp	.-14     	; 0x3ae2 <receive_data>

00003af0 <addr_get>:
    receive_data();
}

/* Get and set the single-byte instrument address */
uint8_t addr_get(void) {
    eeprom_busy_wait();
    3af0:	f9 99       	sbic	0x1f, 1	; 31
    3af2:	fe cf       	rjmp	.-4      	; 0x3af0 <addr_get>
    return eeprom_read_byte(EEPROM_INST_ADDR);
    3af4:	81 e0       	ldi	r24, 0x01	; 1
    3af6:	90 e0       	ldi	r25, 0x00	; 0
    3af8:	0c 94 e2 1f 	jmp	0x3fc4	; 0x3fc4 <__eerd_byte_m168p>

00003afc <addr_set>:

}
void addr_set(uint8_t address) {
    eeprom_busy_wait();
    3afc:	f9 99       	sbic	0x1f, 1	; 31
    3afe:	fe cf       	rjmp	.-4      	; 0x3afc <addr_set>
    eeprom_write_byte(EEPROM_INST_ADDR, address);
    3b00:	68 2f       	mov	r22, r24
    3b02:	81 e0       	ldi	r24, 0x01	; 1
    3b04:	90 e0       	ldi	r25, 0x00	; 0
    3b06:	0c 94 ea 1f 	jmp	0x3fd4	; 0x3fd4 <__eewr_byte_m168p>

00003b0a <dbg_set>:

#include "config.h"
#include "dbg.h"

void dbg_set(uint8_t val) {
    uint8_t tmp = val & 0xF;
    3b0a:	8f 70       	andi	r24, 0x0F	; 15
    DBGLED_PRT |= tmp;
    3b0c:	98 b1       	in	r25, 0x08	; 8
    3b0e:	98 2b       	or	r25, r24
    3b10:	98 b9       	out	0x08, r25	; 8
    DBGLED_PRT &= 0xF0 | tmp;
    3b12:	98 b1       	in	r25, 0x08	; 8
    3b14:	80 6f       	ori	r24, 0xF0	; 240
    3b16:	89 23       	and	r24, r25
    3b18:	88 b9       	out	0x08, r24	; 8
    3b1a:	08 95       	ret

00003b1c <dbg_on>:
}

void dbg_on(uint8_t val) {
    _ON(DBGLED_PRT, val);
    3b1c:	98 b1       	in	r25, 0x08	; 8
    3b1e:	21 e0       	ldi	r18, 0x01	; 1
    3b20:	30 e0       	ldi	r19, 0x00	; 0
    3b22:	08 2e       	mov	r0, r24
    3b24:	01 c0       	rjmp	.+2      	; 0x3b28 <dbg_on+0xc>
    3b26:	22 0f       	add	r18, r18
    3b28:	0a 94       	dec	r0
    3b2a:	ea f7       	brpl	.-6      	; 0x3b26 <dbg_on+0xa>
    3b2c:	92 2b       	or	r25, r18
    3b2e:	98 b9       	out	0x08, r25	; 8
    3b30:	08 95       	ret

00003b32 <dbg_off>:
}

void dbg_off(uint8_t val) {
    _OFF(DBGLED_PRT, val);
    3b32:	98 b1       	in	r25, 0x08	; 8
    3b34:	21 e0       	ldi	r18, 0x01	; 1
    3b36:	30 e0       	ldi	r19, 0x00	; 0
    3b38:	08 2e       	mov	r0, r24
    3b3a:	01 c0       	rjmp	.+2      	; 0x3b3e <dbg_off+0xc>
    3b3c:	22 0f       	add	r18, r18
    3b3e:	0a 94       	dec	r0
    3b40:	ea f7       	brpl	.-6      	; 0x3b3c <dbg_off+0xa>
    3b42:	20 95       	com	r18
    3b44:	29 23       	and	r18, r25
    3b46:	28 b9       	out	0x08, r18	; 8
    3b48:	08 95       	ret

00003b4a <dbg_init>:
}

void dbg_init(void) {
    // this requires the debug bank to be the bottom 4 bits of a bank
    // TODO: make it more advanced
    DBGLED_DDR |= 0x0F;
    3b4a:	87 b1       	in	r24, 0x07	; 7
    3b4c:	8f 60       	ori	r24, 0x0F	; 15
    3b4e:	87 b9       	out	0x07, r24	; 7
    DBGLED_PRT &= 0xF0; // clear leds
    3b50:	88 b1       	in	r24, 0x08	; 8
    3b52:	80 7f       	andi	r24, 0xF0	; 240
    3b54:	88 b9       	out	0x08, r24	; 8
    3b56:	08 95       	ret

00003b58 <eeprom_get_addr>:
 */

#include "config.h"
#include "eeprom.h"

void eeprom_get_addr(uint8_t *buf) {
    3b58:	1f 93       	push	r17
    3b5a:	cf 93       	push	r28
    3b5c:	df 93       	push	r29
    3b5e:	ec 01       	movw	r28, r24
    uint8_t i;

    for ( i=0 ; i<COM_AD_SIZE ; i++ ) {
    3b60:	10 e0       	ldi	r17, 0x00	; 0
        eeprom_busy_wait();
    3b62:	f9 99       	sbic	0x1f, 1	; 31
    3b64:	fe cf       	rjmp	.-4      	; 0x3b62 <eeprom_get_addr+0xa>
        buf[i] = eeprom_read_byte(EEPROM_INST_ADDR);
    3b66:	80 e0       	ldi	r24, 0x00	; 0
    3b68:	90 e0       	ldi	r25, 0x00	; 0
    3b6a:	0e 94 e2 1f 	call	0x3fc4	; 0x3fc4 <__eerd_byte_m168p>
    3b6e:	89 93       	st	Y+, r24
#include "eeprom.h"

void eeprom_get_addr(uint8_t *buf) {
    uint8_t i;

    for ( i=0 ; i<COM_AD_SIZE ; i++ ) {
    3b70:	1f 5f       	subi	r17, 0xFF	; 255
    3b72:	13 30       	cpi	r17, 0x03	; 3
    3b74:	b1 f7       	brne	.-20     	; 0x3b62 <eeprom_get_addr+0xa>
        eeprom_busy_wait();
        buf[i] = eeprom_read_byte(EEPROM_INST_ADDR);
    }
}
    3b76:	df 91       	pop	r29
    3b78:	cf 91       	pop	r28
    3b7a:	1f 91       	pop	r17
    3b7c:	08 95       	ret

00003b7e <eeprom_get_chan>:


void eeprom_get_chan(uint8_t *buf) {
    3b7e:	cf 93       	push	r28
    3b80:	df 93       	push	r29
    3b82:	ec 01       	movw	r28, r24
    eeprom_busy_wait();
    3b84:	f9 99       	sbic	0x1f, 1	; 31
    3b86:	fe cf       	rjmp	.-4      	; 0x3b84 <eeprom_get_chan+0x6>
    buf[0] = eeprom_read_byte(EEPROM_INST_CHAN);
    3b88:	84 e0       	ldi	r24, 0x04	; 4
    3b8a:	90 e0       	ldi	r25, 0x00	; 0
    3b8c:	0e 94 e2 1f 	call	0x3fc4	; 0x3fc4 <__eerd_byte_m168p>
    3b90:	88 83       	st	Y, r24
}
    3b92:	df 91       	pop	r29
    3b94:	cf 91       	pop	r28
    3b96:	08 95       	ret

00003b98 <eeprom_read>:


void eeprom_read(uint8_t *offset, uint8_t len, uint8_t *buf) {
    3b98:	cf 92       	push	r12
    3b9a:	df 92       	push	r13
    3b9c:	ef 92       	push	r14
    3b9e:	ff 92       	push	r15
    3ba0:	0f 93       	push	r16
    3ba2:	1f 93       	push	r17
    3ba4:	cf 93       	push	r28
    3ba6:	df 93       	push	r29
    3ba8:	ec 01       	movw	r28, r24
    3baa:	c6 2e       	mov	r12, r22
    3bac:	7a 01       	movw	r14, r20
    uint8_t i = 0;

    while (len--) {
    3bae:	66 23       	and	r22, r22
    3bb0:	79 f0       	breq	.+30     	; 0x3bd0 <eeprom_read+0x38>
    buf[0] = eeprom_read_byte(EEPROM_INST_CHAN);
}


void eeprom_read(uint8_t *offset, uint8_t len, uint8_t *buf) {
    uint8_t i = 0;
    3bb2:	d1 2c       	mov	r13, r1

    while (len--) {
        eeprom_busy_wait();
    3bb4:	f9 99       	sbic	0x1f, 1	; 31
    3bb6:	fe cf       	rjmp	.-4      	; 0x3bb4 <eeprom_read+0x1c>

        buf[i] = eeprom_read_byte(offset);
    3bb8:	87 01       	movw	r16, r14
    3bba:	0d 0d       	add	r16, r13
    3bbc:	11 1d       	adc	r17, r1
    3bbe:	ce 01       	movw	r24, r28
    3bc0:	0e 94 e2 1f 	call	0x3fc4	; 0x3fc4 <__eerd_byte_m168p>
    3bc4:	f8 01       	movw	r30, r16
    3bc6:	80 83       	st	Z, r24
        offset = &(offset[1]);
    3bc8:	21 96       	adiw	r28, 0x01	; 1
        i++;
    3bca:	d3 94       	inc	r13


void eeprom_read(uint8_t *offset, uint8_t len, uint8_t *buf) {
    uint8_t i = 0;

    while (len--) {
    3bcc:	dc 10       	cpse	r13, r12
    3bce:	f2 cf       	rjmp	.-28     	; 0x3bb4 <eeprom_read+0x1c>

        buf[i] = eeprom_read_byte(offset);
        offset = &(offset[1]);
        i++;
    }
}
    3bd0:	df 91       	pop	r29
    3bd2:	cf 91       	pop	r28
    3bd4:	1f 91       	pop	r17
    3bd6:	0f 91       	pop	r16
    3bd8:	ff 90       	pop	r15
    3bda:	ef 90       	pop	r14
    3bdc:	df 90       	pop	r13
    3bde:	cf 90       	pop	r12
    3be0:	08 95       	ret

00003be2 <eeprom_write>:


void eeprom_write(uint8_t *offset, uint8_t len, uint8_t *buf) {
    3be2:	ef 92       	push	r14
    3be4:	ff 92       	push	r15
    3be6:	0f 93       	push	r16
    3be8:	1f 93       	push	r17
    3bea:	cf 93       	push	r28
    3bec:	df 93       	push	r29
    3bee:	ec 01       	movw	r28, r24
    3bf0:	e6 2e       	mov	r14, r22
    3bf2:	8a 01       	movw	r16, r20
    uint8_t i = 0;

    while (len--) {
    3bf4:	66 23       	and	r22, r22
    3bf6:	71 f0       	breq	.+28     	; 0x3c14 <eeprom_write+0x32>
    }
}


void eeprom_write(uint8_t *offset, uint8_t len, uint8_t *buf) {
    uint8_t i = 0;
    3bf8:	f1 2c       	mov	r15, r1

    while (len--) {
        eeprom_busy_wait();
    3bfa:	f9 99       	sbic	0x1f, 1	; 31
    3bfc:	fe cf       	rjmp	.-4      	; 0x3bfa <eeprom_write+0x18>

        eeprom_write_byte(offset, buf[i]);
    3bfe:	f8 01       	movw	r30, r16
    3c00:	ef 0d       	add	r30, r15
    3c02:	f1 1d       	adc	r31, r1
    3c04:	60 81       	ld	r22, Z
    3c06:	ce 01       	movw	r24, r28
    3c08:	0e 94 ea 1f 	call	0x3fd4	; 0x3fd4 <__eewr_byte_m168p>
        offset = &(offset[1]);
    3c0c:	21 96       	adiw	r28, 0x01	; 1
        i++;
    3c0e:	f3 94       	inc	r15


void eeprom_write(uint8_t *offset, uint8_t len, uint8_t *buf) {
    uint8_t i = 0;

    while (len--) {
    3c10:	ef 10       	cpse	r14, r15
    3c12:	f3 cf       	rjmp	.-26     	; 0x3bfa <eeprom_write+0x18>

        eeprom_write_byte(offset, buf[i]);
        offset = &(offset[1]);
        i++;
    }
}
    3c14:	df 91       	pop	r29
    3c16:	cf 91       	pop	r28
    3c18:	1f 91       	pop	r17
    3c1a:	0f 91       	pop	r16
    3c1c:	ff 90       	pop	r15
    3c1e:	ef 90       	pop	r14
    3c20:	08 95       	ret

00003c22 <flash_write_page>:
 */

#include "config.h"
#include "flash.h"

void flash_write_page(uint16_t addr, uint8_t *buf) {
    3c22:	1f 93       	push	r17
    3c24:	cf 93       	push	r28
    3c26:	df 93       	push	r29
    3c28:	ec 01       	movw	r28, r24
    uint16_t i,w;
    uint8_t sreg;

    // disable interrupts
    sreg = SREG;
    3c2a:	1f b7       	in	r17, 0x3f	; 63
    cli();
    3c2c:	f8 94       	cli

    boot_page_erase_safe(addr);
    3c2e:	07 b6       	in	r0, 0x37	; 55
    3c30:	00 fc       	sbrc	r0, 0
    3c32:	fd cf       	rjmp	.-6      	; 0x3c2e <flash_write_page+0xc>
    3c34:	f9 99       	sbic	0x1f, 1	; 31
    3c36:	fe cf       	rjmp	.-4      	; 0x3c34 <flash_write_page+0x12>
    3c38:	83 e0       	ldi	r24, 0x03	; 3
    3c3a:	fe 01       	movw	r30, r28
    3c3c:	80 93 57 00 	sts	0x0057, r24
    3c40:	e8 95       	spm
    boot_spm_busy_wait();
    3c42:	07 b6       	in	r0, 0x37	; 55
    3c44:	00 fc       	sbrc	r0, 0
    3c46:	fd cf       	rjmp	.-6      	; 0x3c42 <flash_write_page+0x20>
    3c48:	cb 01       	movw	r24, r22
    3c4a:	80 58       	subi	r24, 0x80	; 128
    3c4c:	9f 4f       	sbci	r25, 0xFF	; 255
    3c4e:	db 01       	movw	r26, r22
    3c50:	ae 01       	movw	r20, r28
    3c52:	46 1b       	sub	r20, r22
    3c54:	57 0b       	sbc	r21, r23
    for ( i=0 ; i<PAGESIZE ; i+=2 ) {
        // make word
        w = *buf++;
        w |= (*buf++)<<8;

        boot_page_fill_safe(addr+i, w);
    3c56:	71 e0       	ldi	r23, 0x01	; 1
    boot_page_erase_safe(addr);
    boot_spm_busy_wait();

    for ( i=0 ; i<PAGESIZE ; i+=2 ) {
        // make word
        w = *buf++;
    3c58:	2c 91       	ld	r18, X
        w |= (*buf++)<<8;
    3c5a:	11 96       	adiw	r26, 0x01	; 1
    3c5c:	6c 91       	ld	r22, X
    3c5e:	11 97       	sbiw	r26, 0x01	; 1
    3c60:	30 e0       	ldi	r19, 0x00	; 0
    3c62:	36 2b       	or	r19, r22

        boot_page_fill_safe(addr+i, w);
    3c64:	07 b6       	in	r0, 0x37	; 55
    3c66:	00 fc       	sbrc	r0, 0
    3c68:	fd cf       	rjmp	.-6      	; 0x3c64 <flash_write_page+0x42>
    3c6a:	f9 99       	sbic	0x1f, 1	; 31
    3c6c:	fe cf       	rjmp	.-4      	; 0x3c6a <flash_write_page+0x48>
    3c6e:	fa 01       	movw	r30, r20
    3c70:	ea 0f       	add	r30, r26
    3c72:	fb 1f       	adc	r31, r27
    3c74:	09 01       	movw	r0, r18
    3c76:	70 93 57 00 	sts	0x0057, r23
    3c7a:	e8 95       	spm
    3c7c:	11 24       	eor	r1, r1
    3c7e:	12 96       	adiw	r26, 0x02	; 2
    cli();

    boot_page_erase_safe(addr);
    boot_spm_busy_wait();

    for ( i=0 ; i<PAGESIZE ; i+=2 ) {
    3c80:	a8 17       	cp	r26, r24
    3c82:	b9 07       	cpc	r27, r25
    3c84:	49 f7       	brne	.-46     	; 0x3c58 <flash_write_page+0x36>
        w |= (*buf++)<<8;

        boot_page_fill_safe(addr+i, w);
    }

    boot_page_write_safe(addr);
    3c86:	07 b6       	in	r0, 0x37	; 55
    3c88:	00 fc       	sbrc	r0, 0
    3c8a:	fd cf       	rjmp	.-6      	; 0x3c86 <flash_write_page+0x64>
    3c8c:	f9 99       	sbic	0x1f, 1	; 31
    3c8e:	fe cf       	rjmp	.-4      	; 0x3c8c <flash_write_page+0x6a>
    3c90:	85 e0       	ldi	r24, 0x05	; 5
    3c92:	fe 01       	movw	r30, r28
    3c94:	80 93 57 00 	sts	0x0057, r24
    3c98:	e8 95       	spm
    boot_spm_busy_wait();
    3c9a:	07 b6       	in	r0, 0x37	; 55
    3c9c:	00 fc       	sbrc	r0, 0
    3c9e:	fd cf       	rjmp	.-6      	; 0x3c9a <flash_write_page+0x78>

    // re-enable interrupts
    SREG = sreg;
    3ca0:	1f bf       	out	0x3f, r17	; 63
}
    3ca2:	df 91       	pop	r29
    3ca4:	cf 91       	pop	r28
    3ca6:	1f 91       	pop	r17
    3ca8:	08 95       	ret

00003caa <uart_init>:
void (*tx_handler)(void) = NULL;
void (*rx_handler)(uint8_t) = NULL;


void uart_init(void (*txh)(void), void (*rxh)(uint8_t)) {
	UBRR0 = UART_PRESCALER;
    3caa:	23 e0       	ldi	r18, 0x03	; 3
    3cac:	31 e0       	ldi	r19, 0x01	; 1
    3cae:	30 93 c5 00 	sts	0x00C5, r19
    3cb2:	20 93 c4 00 	sts	0x00C4, r18

    UCSR0A = ( UART_DBL << U2X0 );
    3cb6:	22 e0       	ldi	r18, 0x02	; 2
    3cb8:	20 93 c0 00 	sts	0x00C0, r18
	UCSR0C = ( _BV(UCSZ01) | _BV(UCSZ00) );
    3cbc:	26 e0       	ldi	r18, 0x06	; 6
    3cbe:	20 93 c2 00 	sts	0x00C2, r18

    UCSR0C |= UART_PARITY;
    3cc2:	20 91 c2 00 	lds	r18, 0x00C2
    3cc6:	20 93 c2 00 	sts	0x00C2, r18

    UCSR0B = 0;
    3cca:	10 92 c1 00 	sts	0x00C1, r1

    tx_handler = txh;
    3cce:	90 93 92 01 	sts	0x0192, r25
    3cd2:	80 93 91 01 	sts	0x0191, r24
    rx_handler = rxh;
    3cd6:	70 93 90 01 	sts	0x0190, r23
    3cda:	60 93 8f 01 	sts	0x018F, r22

    if (tx_handler) {
    3cde:	89 2b       	or	r24, r25
    3ce0:	09 f0       	breq	.+2      	; 0x3ce4 <uart_init+0x3a>
        UART_TX_DDR |= 1<<UART_TX_PIN;
    3ce2:	51 9a       	sbi	0x0a, 1	; 10
    3ce4:	08 95       	ret

00003ce6 <uart_enable>:
    }
}


void uart_enable(void) {
    if (tx_handler) {
    3ce6:	80 91 91 01 	lds	r24, 0x0191
    3cea:	90 91 92 01 	lds	r25, 0x0192
    3cee:	89 2b       	or	r24, r25
    3cf0:	29 f0       	breq	.+10     	; 0x3cfc <uart_enable+0x16>
        UCSR0B |= ( _BV(UDRIE0) | _BV(TXEN0) );
    3cf2:	80 91 c1 00 	lds	r24, 0x00C1
    3cf6:	88 62       	ori	r24, 0x28	; 40
    3cf8:	80 93 c1 00 	sts	0x00C1, r24
    }

    if (rx_handler) {
    3cfc:	80 91 8f 01 	lds	r24, 0x018F
    3d00:	90 91 90 01 	lds	r25, 0x0190
    3d04:	89 2b       	or	r24, r25
    3d06:	29 f0       	breq	.+10     	; 0x3d12 <uart_enable+0x2c>
        UCSR0B |= ( _BV(RXCIE0) | _BV(RXEN0) );
    3d08:	80 91 c1 00 	lds	r24, 0x00C1
    3d0c:	80 69       	ori	r24, 0x90	; 144
    3d0e:	80 93 c1 00 	sts	0x00C1, r24
    3d12:	08 95       	ret

00003d14 <uart_disable>:
    }
}


void uart_disable(void) {
    UCSR0B &= ~( _BV(UDRIE0) | _BV(TXEN0) | _BV(RXCIE0) | _BV(RXEN0) );
    3d14:	e1 ec       	ldi	r30, 0xC1	; 193
    3d16:	f0 e0       	ldi	r31, 0x00	; 0
    3d18:	80 81       	ld	r24, Z
    3d1a:	87 74       	andi	r24, 0x47	; 71
    3d1c:	80 83       	st	Z, r24
    3d1e:	08 95       	ret

00003d20 <__vector_18>:
}


ISR(USART_RX_vect) {
    3d20:	1f 92       	push	r1
    3d22:	0f 92       	push	r0
    3d24:	0f b6       	in	r0, 0x3f	; 63
    3d26:	0f 92       	push	r0
    3d28:	11 24       	eor	r1, r1
    3d2a:	2f 93       	push	r18
    3d2c:	3f 93       	push	r19
    3d2e:	4f 93       	push	r20
    3d30:	5f 93       	push	r21
    3d32:	6f 93       	push	r22
    3d34:	7f 93       	push	r23
    3d36:	8f 93       	push	r24
    3d38:	9f 93       	push	r25
    3d3a:	af 93       	push	r26
    3d3c:	bf 93       	push	r27
    3d3e:	ef 93       	push	r30
    3d40:	ff 93       	push	r31
	uint8_t byte;

    // check for framing errors, overrun errors, and parity errors
    // reset the uart if necessary
    if ( UCSR0A & (_BV(FE0) | _BV(DOR0) | _BV(UPE0)) ) {
    3d42:	80 91 c0 00 	lds	r24, 0x00C0
    3d46:	8c 71       	andi	r24, 0x1C	; 28
    3d48:	d9 f0       	breq	.+54     	; 0x3d80 <__vector_18+0x60>
        UCSR0B &= ~(_BV(RXCIE0) | _BV(RXEN0));
    3d4a:	80 91 c1 00 	lds	r24, 0x00C1
    3d4e:	8f 76       	andi	r24, 0x6F	; 111
    3d50:	80 93 c1 00 	sts	0x00C1, r24
        UCSR0B |=  (_BV(RXCIE0) | _BV(RXEN0));
    3d54:	80 91 c1 00 	lds	r24, 0x00C1
    3d58:	80 69       	ori	r24, 0x90	; 144
    3d5a:	80 93 c1 00 	sts	0x00C1, r24
    } else {
        byte = UDR0;
        rx_handler(byte);
    }
}
    3d5e:	ff 91       	pop	r31
    3d60:	ef 91       	pop	r30
    3d62:	bf 91       	pop	r27
    3d64:	af 91       	pop	r26
    3d66:	9f 91       	pop	r25
    3d68:	8f 91       	pop	r24
    3d6a:	7f 91       	pop	r23
    3d6c:	6f 91       	pop	r22
    3d6e:	5f 91       	pop	r21
    3d70:	4f 91       	pop	r20
    3d72:	3f 91       	pop	r19
    3d74:	2f 91       	pop	r18
    3d76:	0f 90       	pop	r0
    3d78:	0f be       	out	0x3f, r0	; 63
    3d7a:	0f 90       	pop	r0
    3d7c:	1f 90       	pop	r1
    3d7e:	18 95       	reti
    // reset the uart if necessary
    if ( UCSR0A & (_BV(FE0) | _BV(DOR0) | _BV(UPE0)) ) {
        UCSR0B &= ~(_BV(RXCIE0) | _BV(RXEN0));
        UCSR0B |=  (_BV(RXCIE0) | _BV(RXEN0));
    } else {
        byte = UDR0;
    3d80:	80 91 c6 00 	lds	r24, 0x00C6
        rx_handler(byte);
    3d84:	e0 91 8f 01 	lds	r30, 0x018F
    3d88:	f0 91 90 01 	lds	r31, 0x0190
    3d8c:	09 95       	icall
    3d8e:	e7 cf       	rjmp	.-50     	; 0x3d5e <__vector_18+0x3e>

00003d90 <__vector_19>:
    }
}

ISR(USART_UDRE_vect) {
    3d90:	1f 92       	push	r1
    3d92:	0f 92       	push	r0
    3d94:	0f b6       	in	r0, 0x3f	; 63
    3d96:	0f 92       	push	r0
    3d98:	11 24       	eor	r1, r1
    3d9a:	2f 93       	push	r18
    3d9c:	3f 93       	push	r19
    3d9e:	4f 93       	push	r20
    3da0:	5f 93       	push	r21
    3da2:	6f 93       	push	r22
    3da4:	7f 93       	push	r23
    3da6:	8f 93       	push	r24
    3da8:	9f 93       	push	r25
    3daa:	af 93       	push	r26
    3dac:	bf 93       	push	r27
    3dae:	ef 93       	push	r30
    3db0:	ff 93       	push	r31
    tx_handler();
    3db2:	e0 91 91 01 	lds	r30, 0x0191
    3db6:	f0 91 92 01 	lds	r31, 0x0192
    3dba:	09 95       	icall
}
    3dbc:	ff 91       	pop	r31
    3dbe:	ef 91       	pop	r30
    3dc0:	bf 91       	pop	r27
    3dc2:	af 91       	pop	r26
    3dc4:	9f 91       	pop	r25
    3dc6:	8f 91       	pop	r24
    3dc8:	7f 91       	pop	r23
    3dca:	6f 91       	pop	r22
    3dcc:	5f 91       	pop	r21
    3dce:	4f 91       	pop	r20
    3dd0:	3f 91       	pop	r19
    3dd2:	2f 91       	pop	r18
    3dd4:	0f 90       	pop	r0
    3dd6:	0f be       	out	0x3f, r0	; 63
    3dd8:	0f 90       	pop	r0
    3dda:	1f 90       	pop	r1
    3ddc:	18 95       	reti

00003dde <uart_rb_rxh>:
    UCSR0B |= _BV(UDRIE0);
}


void uart_rb_rxh(uint8_t data) {
    if ( uart_rxbuf_count <= UART_RX_BUFSZ ) {
    3dde:	90 91 94 01 	lds	r25, 0x0194
    3de2:	91 34       	cpi	r25, 0x41	; 65
    3de4:	e0 f4       	brcc	.+56     	; 0x3e1e <uart_rb_rxh+0x40>
        *uart_rxbuf_iptr = data;
    3de6:	e0 91 06 01 	lds	r30, 0x0106
    3dea:	f0 91 07 01 	lds	r31, 0x0107
    3dee:	80 83       	st	Z, r24
        uart_rxbuf_count++;
    3df0:	80 91 94 01 	lds	r24, 0x0194
    3df4:	8f 5f       	subi	r24, 0xFF	; 255
    3df6:	80 93 94 01 	sts	0x0194, r24

        uart_rxbuf_iptr++;
    3dfa:	80 91 06 01 	lds	r24, 0x0106
    3dfe:	90 91 07 01 	lds	r25, 0x0107
    3e02:	01 96       	adiw	r24, 0x01	; 1
    3e04:	90 93 07 01 	sts	0x0107, r25
    3e08:	80 93 06 01 	sts	0x0106, r24
        if ( uart_rxbuf_iptr >= uart_rxbuf + UART_RX_BUFSZ )
    3e0c:	86 5d       	subi	r24, 0xD6	; 214
    3e0e:	91 40       	sbci	r25, 0x01	; 1
    3e10:	30 f0       	brcs	.+12     	; 0x3e1e <uart_rb_rxh+0x40>
            uart_rxbuf_iptr = uart_rxbuf;
    3e12:	86 e9       	ldi	r24, 0x96	; 150
    3e14:	91 e0       	ldi	r25, 0x01	; 1
    3e16:	90 93 07 01 	sts	0x0107, r25
    3e1a:	80 93 06 01 	sts	0x0106, r24
    3e1e:	08 95       	ret

00003e20 <uart_rb_txh>:
}

void uart_rb_txh(void) {
    uint8_t data;

    data = *uart_txbuf_optr;
    3e20:	e0 91 00 01 	lds	r30, 0x0100
    3e24:	f0 91 01 01 	lds	r31, 0x0101
    3e28:	21 91       	ld	r18, Z+
    uart_txbuf_count--;
    3e2a:	80 91 93 01 	lds	r24, 0x0193
    3e2e:	81 50       	subi	r24, 0x01	; 1
    3e30:	80 93 93 01 	sts	0x0193, r24

    uart_txbuf_optr++;
    if ( uart_txbuf_optr >= uart_txbuf + UART_TX_BUFSZ )
    3e34:	81 e0       	ldi	r24, 0x01	; 1
    3e36:	e7 3d       	cpi	r30, 0xD7	; 215
    3e38:	f8 07       	cpc	r31, r24
    3e3a:	80 f4       	brcc	.+32     	; 0x3e5c <uart_rb_txh+0x3c>
    uint8_t data;

    data = *uart_txbuf_optr;
    uart_txbuf_count--;

    uart_txbuf_optr++;
    3e3c:	f0 93 01 01 	sts	0x0101, r31
    3e40:	e0 93 00 01 	sts	0x0100, r30
    if ( uart_txbuf_optr >= uart_txbuf + UART_TX_BUFSZ )
        uart_txbuf_optr = uart_txbuf;

    UDR0 = data;
    3e44:	20 93 c6 00 	sts	0x00C6, r18

    // if we're out of things to send, disable the interrupt until more data is
    // added to the buffer
    if (!uart_txbuf_count) {
    3e48:	80 91 93 01 	lds	r24, 0x0193
    3e4c:	81 11       	cpse	r24, r1
    3e4e:	05 c0       	rjmp	.+10     	; 0x3e5a <uart_rb_txh+0x3a>
        UCSR0B &= ~(_BV(UDRIE0));
    3e50:	80 91 c1 00 	lds	r24, 0x00C1
    3e54:	8f 7d       	andi	r24, 0xDF	; 223
    3e56:	80 93 c1 00 	sts	0x00C1, r24
    3e5a:	08 95       	ret
    data = *uart_txbuf_optr;
    uart_txbuf_count--;

    uart_txbuf_optr++;
    if ( uart_txbuf_optr >= uart_txbuf + UART_TX_BUFSZ )
        uart_txbuf_optr = uart_txbuf;
    3e5c:	86 ed       	ldi	r24, 0xD6	; 214
    3e5e:	91 e0       	ldi	r25, 0x01	; 1
    3e60:	90 93 01 01 	sts	0x0101, r25
    3e64:	80 93 00 01 	sts	0x0100, r24
    3e68:	ed cf       	rjmp	.-38     	; 0x3e44 <uart_rb_txh+0x24>

00003e6a <uart_rb_init>:
volatile uint8_t *uart_txbuf_optr = uart_txbuf;
volatile uint8_t uart_txbuf_count = 0;


void uart_rb_init(void) {
    uart_init(&uart_rb_txh, &uart_rb_rxh);
    3e6a:	6f ee       	ldi	r22, 0xEF	; 239
    3e6c:	7e e1       	ldi	r23, 0x1E	; 30
    3e6e:	80 e1       	ldi	r24, 0x10	; 16
    3e70:	9f e1       	ldi	r25, 0x1F	; 31
    3e72:	0e 94 55 1e 	call	0x3caa	; 0x3caa <uart_init>
    uart_enable();
    3e76:	0e 94 73 1e 	call	0x3ce6	; 0x3ce6 <uart_enable>

	uart_rxbuf_iptr = uart_rxbuf;
    3e7a:	86 e9       	ldi	r24, 0x96	; 150
    3e7c:	91 e0       	ldi	r25, 0x01	; 1
    3e7e:	90 93 07 01 	sts	0x0107, r25
    3e82:	80 93 06 01 	sts	0x0106, r24
	uart_rxbuf_optr = uart_rxbuf;
    3e86:	90 93 05 01 	sts	0x0105, r25
    3e8a:	80 93 04 01 	sts	0x0104, r24
    uart_rxbuf_count = 0;
    3e8e:	10 92 94 01 	sts	0x0194, r1

	uart_txbuf_iptr = uart_txbuf;
    3e92:	86 ed       	ldi	r24, 0xD6	; 214
    3e94:	91 e0       	ldi	r25, 0x01	; 1
    3e96:	90 93 03 01 	sts	0x0103, r25
    3e9a:	80 93 02 01 	sts	0x0102, r24
	uart_txbuf_optr = uart_txbuf;
    3e9e:	90 93 01 01 	sts	0x0101, r25
    3ea2:	80 93 00 01 	sts	0x0100, r24
    uart_txbuf_count = 0;
    3ea6:	10 92 93 01 	sts	0x0193, r1
    3eaa:	08 95       	ret

00003eac <uart_rb_data_rdy>:
}

uint8_t uart_rb_data_rdy(void) {
	return ( uart_rxbuf_count );
    3eac:	80 91 94 01 	lds	r24, 0x0194
}
    3eb0:	08 95       	ret

00003eb2 <uart_rb_rx>:

uint8_t uart_rb_rx(void) {
	unsigned char tmp;

    // blocking call -- wait until we receive data
	while ( uart_rxbuf_count == 0 );
    3eb2:	80 91 94 01 	lds	r24, 0x0194
    3eb6:	88 23       	and	r24, r24
    3eb8:	e1 f3       	breq	.-8      	; 0x3eb2 <uart_rb_rx>

    UCSR0B &= ~(_BV(RXCIE0) | _BV(RXEN0));
    3eba:	80 91 c1 00 	lds	r24, 0x00C1
    3ebe:	8f 76       	andi	r24, 0x6F	; 111
    3ec0:	80 93 c1 00 	sts	0x00C1, r24

	tmp = *uart_rxbuf_optr;
    3ec4:	e0 91 04 01 	lds	r30, 0x0104
    3ec8:	f0 91 05 01 	lds	r31, 0x0105
    3ecc:	81 91       	ld	r24, Z+
	uart_rxbuf_count--;
    3ece:	90 91 94 01 	lds	r25, 0x0194
    3ed2:	91 50       	subi	r25, 0x01	; 1
    3ed4:	90 93 94 01 	sts	0x0194, r25

    // increment pointer
	uart_rxbuf_optr++;
	if ( uart_rxbuf_optr >= uart_rxbuf + UART_RX_BUFSZ )
    3ed8:	91 e0       	ldi	r25, 0x01	; 1
    3eda:	e6 3d       	cpi	r30, 0xD6	; 214
    3edc:	f9 07       	cpc	r31, r25
    3ede:	60 f0       	brcs	.+24     	; 0x3ef8 <uart_rb_rx+0x46>
		uart_rxbuf_optr = uart_rxbuf;
    3ee0:	26 e9       	ldi	r18, 0x96	; 150
    3ee2:	31 e0       	ldi	r19, 0x01	; 1
    3ee4:	30 93 05 01 	sts	0x0105, r19
    3ee8:	20 93 04 01 	sts	0x0104, r18

    UCSR0B |= (_BV(RXCIE0) | _BV(RXEN0));
    3eec:	90 91 c1 00 	lds	r25, 0x00C1
    3ef0:	90 69       	ori	r25, 0x90	; 144
    3ef2:	90 93 c1 00 	sts	0x00C1, r25
    
	return tmp;
}
    3ef6:	08 95       	ret

	tmp = *uart_rxbuf_optr;
	uart_rxbuf_count--;

    // increment pointer
	uart_rxbuf_optr++;
    3ef8:	f0 93 05 01 	sts	0x0105, r31
    3efc:	e0 93 04 01 	sts	0x0104, r30
    3f00:	f5 cf       	rjmp	.-22     	; 0x3eec <uart_rb_rx+0x3a>

00003f02 <uart_rb_tx>:
    3f02:	90 91 c1 00 	lds	r25, 0x00C1
    3f06:	9f 7d       	andi	r25, 0xDF	; 223
    3f08:	90 93 c1 00 	sts	0x00C1, r25
    3f0c:	90 91 93 01 	lds	r25, 0x0193
    3f10:	91 30       	cpi	r25, 0x01	; 1
    3f12:	e1 f3       	breq	.-8      	; 0x3f0c <uart_rb_tx+0xa>
    3f14:	e0 91 02 01 	lds	r30, 0x0102
    3f18:	f0 91 03 01 	lds	r31, 0x0103
    3f1c:	80 83       	st	Z, r24
    3f1e:	80 91 93 01 	lds	r24, 0x0193
    3f22:	8f 5f       	subi	r24, 0xFF	; 255
    3f24:	80 93 93 01 	sts	0x0193, r24
    3f28:	80 91 02 01 	lds	r24, 0x0102
    3f2c:	90 91 03 01 	lds	r25, 0x0103
    3f30:	01 96       	adiw	r24, 0x01	; 1
    3f32:	21 e0       	ldi	r18, 0x01	; 1
    3f34:	87 3d       	cpi	r24, 0xD7	; 215
    3f36:	92 07       	cpc	r25, r18
    3f38:	10 f0       	brcs	.+4      	; 0x3f3e <uart_rb_tx+0x3c>
    3f3a:	86 ed       	ldi	r24, 0xD6	; 214
    3f3c:	91 e0       	ldi	r25, 0x01	; 1
    3f3e:	90 93 03 01 	sts	0x0103, r25
    3f42:	80 93 02 01 	sts	0x0102, r24
    3f46:	80 91 c1 00 	lds	r24, 0x00C1
    3f4a:	80 62       	ori	r24, 0x20	; 32
    3f4c:	80 93 c1 00 	sts	0x00C1, r24
    3f50:	08 95       	ret

00003f52 <main>:
    3f52:	81 e0       	ldi	r24, 0x01	; 1
    3f54:	85 bf       	out	0x35, r24	; 53
    3f56:	82 e0       	ldi	r24, 0x02	; 2
    3f58:	85 bf       	out	0x35, r24	; 53
    3f5a:	0e 94 a5 1d 	call	0x3b4a	; 0x3b4a <dbg_init>
    3f5e:	89 e0       	ldi	r24, 0x09	; 9
    3f60:	0e 94 85 1d 	call	0x3b0a	; 0x3b0a <dbg_set>
    3f64:	f9 99       	sbic	0x1f, 1	; 31
    3f66:	fe cf       	rjmp	.-4      	; 0x3f64 <main+0x12>
    3f68:	81 e0       	ldi	r24, 0x01	; 1
    3f6a:	90 e0       	ldi	r25, 0x00	; 0
    3f6c:	0e 94 e2 1f 	call	0x3fc4	; 0x3fc4 <__eerd_byte_m168p>
    3f70:	80 93 95 01 	sts	0x0195, r24
    3f74:	0e 94 35 1f 	call	0x3e6a	; 0x3e6a <uart_rb_init>
    3f78:	78 94       	sei
    3f7a:	2f e7       	ldi	r18, 0x7F	; 127
    3f7c:	84 e8       	ldi	r24, 0x84	; 132
    3f7e:	9e e1       	ldi	r25, 0x1E	; 30
    3f80:	21 50       	subi	r18, 0x01	; 1
    3f82:	80 40       	sbci	r24, 0x00	; 0
    3f84:	90 40       	sbci	r25, 0x00	; 0
    3f86:	e1 f7       	brne	.-8      	; 0x3f80 <main+0x2e>
    3f88:	00 c0       	rjmp	.+0      	; 0x3f8a <main+0x38>
    3f8a:	00 00       	nop
    3f8c:	0e 94 56 1f 	call	0x3eac	; 0x3eac <uart_rb_data_rdy>
    3f90:	88 23       	and	r24, r24
    3f92:	21 f0       	breq	.+8      	; 0x3f9c <main+0x4a>
    3f94:	0e 94 59 1f 	call	0x3eb2	; 0x3eb2 <uart_rb_rx>
    3f98:	8e 34       	cpi	r24, 0x4E	; 78
    3f9a:	61 f0       	breq	.+24     	; 0x3fb4 <main+0x62>
    3f9c:	f8 94       	cli
    3f9e:	81 e0       	ldi	r24, 0x01	; 1
    3fa0:	85 bf       	out	0x35, r24	; 53
    3fa2:	15 be       	out	0x35, r1	; 53
    3fa4:	e0 91 08 01 	lds	r30, 0x0108
    3fa8:	f0 91 09 01 	lds	r31, 0x0109
    3fac:	09 95       	icall
    3fae:	80 e0       	ldi	r24, 0x00	; 0
    3fb0:	90 e0       	ldi	r25, 0x00	; 0
    3fb2:	08 95       	ret
    3fb4:	0e 94 71 1d 	call	0x3ae2	; 0x3ae2 <receive_data>

00003fb8 <__tablejump2__>:
    3fb8:	ee 0f       	add	r30, r30
    3fba:	ff 1f       	adc	r31, r31

00003fbc <__tablejump__>:
    3fbc:	05 90       	lpm	r0, Z+
    3fbe:	f4 91       	lpm	r31, Z
    3fc0:	e0 2d       	mov	r30, r0
    3fc2:	09 94       	ijmp

00003fc4 <__eerd_byte_m168p>:
    3fc4:	f9 99       	sbic	0x1f, 1	; 31
    3fc6:	fe cf       	rjmp	.-4      	; 0x3fc4 <__eerd_byte_m168p>
    3fc8:	92 bd       	out	0x22, r25	; 34
    3fca:	81 bd       	out	0x21, r24	; 33
    3fcc:	f8 9a       	sbi	0x1f, 0	; 31
    3fce:	99 27       	eor	r25, r25
    3fd0:	80 b5       	in	r24, 0x20	; 32
    3fd2:	08 95       	ret

00003fd4 <__eewr_byte_m168p>:
    3fd4:	26 2f       	mov	r18, r22

00003fd6 <__eewr_r18_m168p>:
    3fd6:	f9 99       	sbic	0x1f, 1	; 31
    3fd8:	fe cf       	rjmp	.-4      	; 0x3fd6 <__eewr_r18_m168p>
    3fda:	1f ba       	out	0x1f, r1	; 31
    3fdc:	92 bd       	out	0x22, r25	; 34
    3fde:	81 bd       	out	0x21, r24	; 33
    3fe0:	20 bd       	out	0x20, r18	; 32
    3fe2:	0f b6       	in	r0, 0x3f	; 63
    3fe4:	f8 94       	cli
    3fe6:	fa 9a       	sbi	0x1f, 2	; 31
    3fe8:	f9 9a       	sbi	0x1f, 1	; 31
    3fea:	0f be       	out	0x3f, r0	; 63
    3fec:	01 96       	adiw	r24, 0x01	; 1
    3fee:	08 95       	ret

00003ff0 <_exit>:
    3ff0:	f8 94       	cli

00003ff2 <__stop_program>:
    3ff2:	ff cf       	rjmp	.-2      	; 0x3ff2 <__stop_program>
