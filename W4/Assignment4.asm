.data
	message_no_overflow:	.asciz "No overflow detected.\n"
	message_overflow:	.asciz "Overflow detected.\n"
.text
	.globl _start
_start:
	# Giả sử chúng ta cần cộng hai số nguyên dương hoặc hai số nguyên âm, ở đây sử dụng hai số nguyên dương.
	li s0, 5	# Toán hạng thứ nhất (số nguyên dương lớn nhất 32-bit)
	li s1, 1		# Toán hạng thứ hai (giá trị cần cộng)
	
	add t0, s0, s1		# t0 = s0 + s1
	
	# Kiểm tra tràn số
	# 1. Kiểm tra nếu s0 và s1 đều là số dương
	# 2. Nếu tổng t0 là số âm, điều đó có nghĩa là có tràn số dương.
	bltz s0, check_negative	# If s0 < 0, jump check_negative
	bltz s1, check_negative	# If s1 < 0, jump check_negative
	bltz t0, overflow	# If t0 < 0, jump overflow
	j no_overflow		# jump no_overflow

check_negative:
	# Kiểm tra nếu cả s0 và s1 đều là số âm
	# Nếu tổng là số dương, điều đó có nghĩa là có tràn số âm.
	bgez s0, no_overflow	# If s0 >= 0, jump no_overflow
	bgez s1, no_overflow	# If s1 >= 0, jump no_overflow
	bgez t0, overflow	# If t0 >= 0, jump overflow

no_overflow:
	# In ra thông báo không có tràn số
	la a0, message_no_overflow	# Đưa địa chỉ chuỗi "No overflow detected!" vào a0
	li a7, 4			# Sử dụng syscall 4 (print string)
	ecall				# Thực hiện syscall để in chuỗi
	j end				# Nhảy tới kết thúc chương trình

overflow:
	# In ra thông báo có tràn số
	la a0, message_overflow		# Đưa địa chỉ chuỗi "Overflow detected!" vào a0
	li a7, 4			# Sử dụng syscall 4 (print string)
	ecall				# Thực hiện syscall để in chuỗi
end:
	li a7, 10			# Sử dụng syscall 10 (exit)
	ecall				# Thoát chương trình
