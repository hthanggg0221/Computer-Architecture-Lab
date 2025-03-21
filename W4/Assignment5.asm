.text
	li t1, 6		# Số nguyên bất kì
	li t0, 8		# Bậc của lũy thừa 2
	li t2, 0		# t2 sẽ lưu số bit cần dịch
loop:
	srli t0, t0, 1		# Dịch phải t0 một bit
	beqz t0, endloop	# Nếu t0 == 0, thoát vòng lặp
	addi t2, t2, 1		# Tăng số bit cần dịch
	j loop
endloop:
	sll s1, t1, t2		# Dịch trái t1 với số bit trong t2
	# Kết quả của phép nhân sẽ được lưu trong thanh ghi s1