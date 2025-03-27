# Laboratory Exercise 7, Home Assignment 3
.text
main:
	li	s0, 69		# Gán giá trị 69 cho thanh ghi s0
	li	s1, 96		# Gán giá trị 96 cho thanh ghi s1
	jal	stack
	# Kết thúc chương trình
	li	a7, 10
	ecall

stack:
	addi	sp, sp, -8	# Điều chỉnh con trỏ ngăn xếp (giảm 8 byte)
	sw	s0, 4(sp)	# Lưu giá trị s0 vào ngăn xếp
	sw	s1, 0(sp)	# Lưu giá trị s1 vào ngăn xếp
	nop
	lw	s0, 0(sp)	# Lấy giá trị s1 từ ngăn xếp và gán cho s0
	lw	s1, 4(sp)	# Lấy giá trị s0 từ ngăn xếp và gán cho s1
	addi	sp, sp, 8	# Khôi phục con trỏ ngăn xếp (tăng 8 byte)
	jr	ra