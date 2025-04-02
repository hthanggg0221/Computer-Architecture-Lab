.data
message: .asciz "Nhap so nguyen duong N: "
error_message: .asciz "Vui long nhap so N dung theo yeu cau (N > 0)!"
newline: .asciz "\n"
.text
main:
	li	a7, 4
	la	a0, message
	ecall
	
	li	a7, 5
	ecall
	mv	s0, a0
	
	blez	s0, error
	li	t3, 1
	beq	s0, t3, print_end
	
	li	t0, 0
	li	t1, 1
	li	t2, 1
loop:
	bge	t2, s0, end_loop
	j	print_ans
	
print_ans:
	li	a7, 1
	mv	a0, t0
	ecall
	
	li	a7, 4
	la	a0, newline
	ecall
	
next:
	mv	t0, t1
	mv	t1, t2
	add	t2, t0, t1
	j	loop
	
end_loop:
	li	a7, 1
	mv	a0, t0
	ecall
	
	li	a7, 4
	la	a0, newline
	ecall
	
	li	a7, 1
	mv	a0, t1
	ecall
	
	j	end
print_end:
	li	a7, 1
	li	a0, 0
	ecall
	
	j	end

error:
	li	a7, 4
	la	a0, error_message
	ecall
end:
	