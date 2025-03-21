.data
	string: .space 21			# Cấp phát 21 byte cho chuỗi (bao gồm 20 ký tự và 1 ký tự NULL)
	msg: .asciz "Nhap ki tu: "		# Thông báo yêu cầu nhập ký tự
	msg2: .asciz "\nChuoi nguoc lai la: "	# Thông báo về chuỗi ngược
.text
get_str:
	la	a0, msg				# Đưa thông báo "Nhap ky tu: " vào thanh ghi a0 để in ra
	li	a7, 4				# Mã hệ thống để in chuỗi (syscall 4)
	ecall					# Thực hiện lệnh syscall để in ra thông báo
	
	li	t0, 0				# t0 là chỉ số hiện tại của chuỗi (để đếm số ký tự)
	la	t1, string			# t1 trỏ đến vị trí bắt đầu của chuỗi (string)
	
get_input:
	li	a7, 12				# Mã hệ thống để đọc ký tự (syscall 12)
	ecall					# Thực hiện syscall để đọc ký tự từ người dùng
	sb	a0, 0(t1)			# Lưu ký tự vừa nhập vào vị trí hiện tại của chuỗi (t1)
	
	li	t2, 10				# t2 giữ giá trị '\n' (ASCII: 10)
	beq	a0, t2, end_input		# Nếu ký tự nhập vào là '\n' (Enter), thì kết thúc nhập
	
	addi	t0, t0, 1			# Tăng chỉ số chuỗi (số ký tự đã nhập)
	addi	t1, t1, 1			# Di chuyển con trỏ chuỗi (t1) đến vị trí tiếp theo
	
	li	t2, 20				# t2 giữ giá trị 20 (số ký tự tối đa có thể nhập)
	bge	t0, t2, end_input		# Nếu số ký tự nhập vào >= 20, thì dừng nhập
	
	j	get_input			# Quay lại vòng lặp nhập ký tự tiếp theo
	
end_input:
	sb	zero, 0(t1)			# Thêm ký tự NULL '\0' vào cuối chuỗi để kết thúc chuỗi
	la	t1, string			# t1 trở lại vị trí đầu tiên của chuỗi (string)
	add	t2, t1, t0			# t2 trỏ đến vị trí cuối cùng của chuỗi (dựa trên số ký tự t0)
	addi	t2, t2, -1			# t2 trỏ đến ký tự cuối cùng thực sự của chuỗi (không phải NULL)
	addi	t3, t0, -1			# t3 là chỉ số dùng để duyệt ngược chuỗi
	la	a0, msg2			# Đưa ra thông báo "Chuoi nguoc lai la: " vào a0
	li	a7, 4				# Mã hệ thống để in chuỗi (syscall 4)
	ecall					# Thực hiện lệnh syscall để in ra thông báo

print_rev:
	blt	t3, zero, end_prog		# Nếu chỉ số t3 < 0 (đã duyệt hết chuỗi), thì kết thúc chương trình
	lb	a0, 0(t2)			# Đọc ký tự tại vị trí t2 (ký tự hiện tại của chuỗi ngược)
	li	a7, 11				# Mã hệ thống để in ký tự (syscall 11) 
	ecall					# Thực hiện lệnh syscall để in ký tự ra màn hình
	addi	t2, t2, -1			# Di chuyển t2 về phía trước (ký tự trước trong chuỗi)
	addi	t3, t3, -1			# Giảm chỉ số t3 (vì đang duyệt ngược chuỗi)
	j	print_rev			# Quay lại vòng lặp để in ký tự tiếp theo

end_prog:
	li	a7, 10				# Mã hệ thống để thoát chương trình (syscall 10)
	ecall					# Thực hiện lệnh syscall để thoát chương trình