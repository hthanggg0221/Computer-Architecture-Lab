# Laboratory Exercise 5, Home Assignment 3
.data
	string: .space 50
	message1: .asciz "Nhap xau: "
	message2: .asciz "Do dai xau la: "
	newline: .byte 10
.text
main:
get_string:
	# TODO Nhập chuỗi ký tự từ bàn phím
	# Hiển thị hộp thoại để người dùng nhập chuỗi
	la	a0, message1		# Nạp địa chỉ của thông báo yêu cầu nhập chuỗi
	la	a1, string		# Nạp địa chỉ của chuỗi vào buffer
	li	a2, 50			# Giới hạn số ký tự nhập là 50
	li	a7, 54			# Mã ecall để hiển thị hội thoại nhập chuỗi
	ecall				# Gọi ecall hiển thị hộp thoại
	
	# Loại bỏ ký tự newline nếu có
	la	a0, string		# Nạp địa chỉ của chuỗi vào a0
	li	t0, 0			# Đặt biến đếm i = 0
	
remove_newline:
	add	t1, a0, t0		# Tính địa chỉ của string[i]
	lb	t2, 0(t1)		# Lấy giá trị string[i]
	beq	t2, zero, end_remove_nl	# Nếu gặp ký tự NULL, kết thúc vòng lặp
	li	t3, 10			# Giá trị của ký tự newline (ASCII: 10)
	beq	t2, t3, set_null	# Nếu ký tự là newline, thay thế bằng null
	addi	t0, t0, 1		# Tăng biến đếm i
	j	remove_newline		# Lặp lại vòng lặp
	
set_null:
	sb	zero, 0(t1)		# Thay newline bằng ký tự NULL
	
end_remove_nl:
get_length:
	li	t0, 0			# t0 = i = 0
check_char:
	add	t1, a0, t0		# t1 = a0 + t0 = address(string[0]+i)
	lb	t2, 0(t1)		# t2 = string[i]
	beq	t2, zero, end_of_str	# Nếu là ký tự NULL thì kết thúc
	addi	t0, t0, 1		# t0 = t0 + 1 -> i = i + 1
	j	check_char
end_of_str:
end_of_get_length:
print_length:
	# TODO In kết quả ra màn hình
	la	a0, message2		# Nap dia chi cua thong bao "Do dai xau la: "
	mv	a1, t0			# Chuyen gia tri do dai chuoi vao thanh ghi a1
	li	a7, 56			# Mã ECALL để hiển thị hộp thoại thông báo độ dài
	ecall				# Goi ECALL hien thi hop thoai
	
	# Thoat chuong trinh
	li	a7, 10			# Ma ECALL de thoat chuong trinh
	ecall