.eqv	KEY_CODE	0xFFFF0004
.eqv	KEY_READY	0xFFFF0000
.eqv	DISPLAY_CODE	0xFFFF000C
.eqv	DISPLAY_READY	0xFFFF0008

.text
main:
	li	a0, KEY_CODE
	li	a1, KEY_READY
	li	s0, DISPLAY_CODE
	li	s1, DISPLAY_READY
	li	s2, 'a'
	li	s3, 'z'
	li	s4, 'A'
	li	s5, 'Z'
	li	s6, '0'
	li	s7, '9'
	li	t5, '*'
	
	li	s8, 0
	li	s9, 0
	li	s10, 0
	li	s11, 0
loop:
WaitForKey:
	lw	t1, 0(a1)
	beq	t1, zero, WaitForKey
ReadKey:
	lw	t0, 0(a0)

CheckExit:
	mv	s11, s10
	mv	s10, s9
	mv	s9, s8
	mv	s8, t0
	
	li	t1, 'e'
	bne	s11, t1, ProcessChar
	li	t1, 'x'
	bne	s10, t1, ProcessChar
	li	t1, 'i'
	bne	s9, t1, ProcessChar
	li	t1, 't'
	bne	s8, t1, ProcessChar
	j	exit
	
ProcessChar:
	blt	t0, s2, CheckUpper
	blt	s3, t0, CheckUpper
	addi	t0, t0, -32
	j	display
	
CheckUpper:
	blt	t0, s4, CheckDigit
	blt	s5, t0, CheckDigit
	addi	t0, t0, 32
	j	display
	
CheckDigit:
	blt	t0, s6, star
	blt	s7, t0, star
	j	display

star:
	mv	t0, t5
	
display:
WaitForDis:
	lw	t2, 0(s1)
	beq	t2, zero, WaitForDis
ShowKey:
	sw	t0, 0(s0)
	j	loop
	
exit:
	li	a7, 10
	ecall