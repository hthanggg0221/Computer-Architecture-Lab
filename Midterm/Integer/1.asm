.data
message: .asciz "Nhap so nguyen duong N: "
newline: .asciz "\n"
.text
main:
	li	a7, 4
	la	a0, message
	ecall
	
	li	a7, 5
	ecall
	mv	s0, a0
	
	li	t0, 3
	li	t3, 3
	li	t4, 5
loop:
	bge	t0, s0, end_loop
	
	rem	t1, t0, t3
	rem	t2, t0, t4
	
	beqz	t1, print_ans
	beqz	t2, print_ans
	
	j	next_num

print_ans:
	li	a7, 1
	mv	a0, t0
	ecall
	
	li	a7, 4
	la	a0, newline
	ecall
	
next_num:
	addi	t0, t0, 1
	j	loop
	
end_loop: