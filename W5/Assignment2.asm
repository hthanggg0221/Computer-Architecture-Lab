.data
	message1: .asciz "The sum of "	# Chuỗi đầu tiên
	message2: .asciz " and "		# Chuỗi nối giữa
	message3: .asciz " is "		# Chuỗi kết thúc
.text
	# Khởi tạo giá trị cho các thanh ghi s0 và s1
	li s0, 5			# s0 = 5
	li s1, 10			# s1 = 10
	
	# Tính tổng
	add t0, s0, s1			# t0 = s0 + s1
	
	# In ra chuỗi "The sum of"
	la a0, message1			# Load giá trị của chuỗi message1 vào a0
	li a7, 4			# Service number: 4 (print string)
	ecall				# Gọi hệ thống để in chuỗi message1
	
	# In giá trị của s0
	mv a0, s0			# Move giá trị của s0 vào a0
	li a7, 1			# Service number: 1 (print integer)
	ecall				# Gọi hệ thống để in giá trị s0
	
	# In ra chuỗi " and"
	la a0, message2			# Load giá trị của chuỗi message2 vào a0
	li a7, 4			# Service number: 4 (print string)
	ecall				# Gọi hệ thống để in chuỗi message2
	
	# In giá trị của s1
	mv a0, s1 			# Move giá trị của s1 vào a0
	li a7, 1 			# Service number: 1 (print integer)
	ecall 				# Gọi hệ thống để in giá trị s1
	
	# In ra chuỗi " is "
	la a0, message3 		# Load địa chỉ của chuỗi message3 vào a0
	li a7, 4 			# Service number: 4 (print string)
	ecall 				# Gọi hệ thống để in chuỗi message3
	
	# In kết quả tổng
	mv a0, t0 			# Move giá trị tổng từ t0 vào a0
	li a7, 1 			# Service number: 1 (print integer)
	ecall 				# Gọi hệ thống để in kết quả tổng
	
	# Thoát chương trình
	li a7, 10 			# Service number: 10 (thoát chương trình)
	ecall
	