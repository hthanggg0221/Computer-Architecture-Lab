.data
input_message: .asciz "Nhap so nguyen duong N: "
output_message: .asciz "So N o he co so 8 la: "
error_message: .asciz "Vui long nhap dau vao dung yeu cau de bai!"
.text
main:
	li	a7, 4
	la	a0, input_message
	ecall
	
	li	a7, 5
	ecall
	mv	t0, a0
	
	blez	t0, error
	
	li	t1, 8		# He co so
	li	t2, 0		# Ans
	li	t3, 1		# Chi so
	li	t6, 10

loop:
	beq	t0, zero, end_loop
	rem	t4, t0, t1
	mul	t5, t4, t3
	add	t2, t2, t5
	mul	t3, t3, t6
	div	t0, t0, t1
	j	loop
	
error:
	li	a7, 4
	la	a0, error_message
	ecall
	j	end
	
end_loop:
	li	a7, 4
	la	a0, output_message
	ecall
	
	li	a7, 1
	mv	a0, t2
	ecall
	
end:
	li	a7, 10
	ecall