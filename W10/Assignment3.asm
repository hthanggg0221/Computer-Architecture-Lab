.eqv	MONITOR_SCREEN	0x10010000
.eqv	WHITE		0x00FFFFFF
.eqv	YELLOW		0x00FFFF00

.text
main:
	li	t0, 0
outer:
	li	t1, 0

inner:
	slli t3, t0, 3
	add t3, t3, t1
	slli t3, t3, 2
	li t4, MONITOR_SCREEN
	add t3, t3, t4

	add t5, t0, t1		# t5 = i + j
	andi t5, t5, 1		# (i+j)%2
	beqz t5, choose_white
	li t6, YELLOW
	j store

choose_white:	
	li t6, WHITE

store:
	sw t6, 0(t3)

	addi t1, t1, 1
	li t6, 8
	blt t1, t6, inner

	addi t0, t0, 1
	blt t0, t6, outer

exit:
	li a7, 10
	ecall
