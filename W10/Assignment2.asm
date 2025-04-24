.eqv	SEVENSEG_LEFT	0xFFFF0011
.eqv	SEVENSEG_RIGHT	0xFFFF0010
.data
message:	.asciz "Nhap ky tu: "
newline:	.asciz "\n"
SEG_TABLE:
	.byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
.text
main:
	li	a7, 4
	la	a0, message
	ecall
	
	li	a7, 12
	ecall
	mv	t0, a0
	
	li	a7, 4
	la	a0, newline
	ecall
	
	li	t3, 100
	remu	t0, t0, t3
	
	li	t4, 10
	divu	t1, t0, t4
	remu	t2, t0, t4
	
	la	t5, SEG_TABLE
	add	t6, t5, t1
	lbu	a0, 0(t6)
	jal	SHOW_7SEG_LEFT
	
	add	t6, t5, t2
	lbu	a0, 0(t6)
	jal	SHOW_7SEG_RIGHT
exit:
	li	a7, 10
	ecall
end_main:
	
SHOW_7SEG_LEFT:
	li	t0, SEVENSEG_LEFT
	sb	a0, 0(t0)
	jr	ra
	
SHOW_7SEG_RIGHT:	
	li	t0, SEVENSEG_RIGHT
	sb	a0, 0(t0)
	jr	ra
