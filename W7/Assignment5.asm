.data
	msg1: .string "Largest: "
	msg2: .string ", "
	msg3: .string "\nSmallest: "
	newline: .string "\n"
.text
main:
	# Cấp phát bộ nhớ stack cho 8 số +4 kết quả (max, maxpos, min, minpos)
	addi sp, sp, -48
	
	# Lưu các giá trị test vào check
	li	t0, 5
	sw	t0, 0(sp)	# a0
	li	t0, -2
	sw	t0, 4(sp)	# a1
	li	t0, 7
	sw	t0, 8(sp)	# a2
	li	t0, 9
	sw	t0, 12(sp)	# a3
	li	t0, 1
	sw	t0, 16(sp)	# a4
	li	t0, 12
	sw	t0, 20(sp)	# a5
	li	t0, -3
	sw	t0, 24(sp)	# a6
	li	t0, -6
	sw	t0, 28(sp)	# a7
	
	jal	ra, find_max_min
	
	# In "Largest: "
	la	a0, msg1
	li	a7, 4
	ecall
	
	# In gía trị max
	lw	a0, 32(sp)
	li	a7, 1
	ecall
	
	# In ", "
	la	a0, msg2
	li	a7, 4
	ecall
	
	# In vị trí max
	lw	a0, 36(sp)
	li	a7, 1
	ecall
	
	# In "\nSmallest: "
	la	a0, msg3
	li	a7, 4
	ecall
	
	# In giá trị min
	lw	a0, 40(sp)
	li	a7, 1
	ecall
	
	# In ", "
	la	a0, msg2
	li	a7, 4
	ecall
	
	# In vị trí min
	lw	a0, 44(sp)
	li	a7, 1
	ecall
	
	# In newline
	la	a0, newline
	li	a7, 4
	ecall
	
	# Giải phóng stack
	addi	sp, sp, 48
	li	a7, 10
	ecall
	
find_max_min:
	# Khởi tạo giá trị max, min là phần tử đầu tiên
	lw	t0, 0(sp)
	mv	t1, t0
	li	t2, 0
	li	t3, 0
	li	t4, 1
	li	t5, 8
	
loop:
	beq	t4, t5, end_loop
	
	# Load giá trị hiện tại
	slli	t6, t4, 2		# t6 = t4 * 4 (offset)
	add	t6, sp, t6		# t6: địa chỉ của phần tử hiện tại
	lw	s1, 0(t6)
	
	# So sánh với max
	bge	t0, s1, check_min	# Nếu max >= current thì kiểm tra min
	mv	t0, s1			# Update max value
	mv	t2, t4			# Update max position
	
check_min:
	ble	t1, s1, continue	# Nếu min <= current thì continue
	mv	t1, s1			# Update min value
	mv	t3, t4			# Update min position
	
continue:
	addi	t4, t4, 1		# Tăng counter
	j	loop

end_loop:
	# Lưu kết quả vào stack
	sw	t0, 32(sp)		# max value
	sw	t2, 36(sp)		# max position
	sw	t1, 40(sp)		# min value
	sw	t3, 44(sp)		# min position
	
	ret
	
	
	