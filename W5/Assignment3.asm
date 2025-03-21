# Laboratory Exercise 5, Home Assignment 2
.data
	x: .space 32				# Chuỗi đích x, khởi tạo là buffer rỗng
	y: .asciz "Hello"			# Chuỗi nguồn y
.text
# Nạp địa chỉ của chuỗi đích x và chuỗi nguồn y vào thanh ghi
	la	a0, x				# Nạp địa chỉ của chuỗi x vào a0
	la	a1, y				# Nạp địa chỉ của chuỗi y vào a1
strcpy:
	add	s0, zero, zero			# s0 = i = 0
L1:
	add	t1, s0, a1			# t1 = s0 + a1 = i + y[0] = address of y[i]
	lb	t2, 0(t1)			# t2 = value at t1 = y[i]
	add	t3, s0, a0			# t3 = s0 + a0 = i + x[0] = address of x[i]
	sb	t2, 0(t3)			# x[i] = t2 = y[i]
	beq	t2, zero, end_of_strcpy		# if y[i] = 0, then exit
	addi	s0, s0, 1			# s0 = s0 + 1 <-> i = i + 1
	j	L1				# Ký tự tiếp theo
end_of_strcpy:
	# In chuỗi x ra màn hình để kiểm tra kết quả
	la	a0, x				# Nạp địa chỉ chuỗi x vào a0
	li	a7, 4				# Service number: 4 (print string)
	ecall					# Gọi hệ thống để in chuỗi x
	
	# Thoát chương trình
	li	a7, 10				# Dịch vụ thoát chương trình
	ecall