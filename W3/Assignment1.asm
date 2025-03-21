# Laboratory Exercise 3, Home Assignment 1
.data
	i: .word 5	# Khai báo biến i với giá trị 5
	j: .word 3	# Khai báo biến j với giá trị 3
	x: .word 0	# Khai báo biến x với giá trị 0
	y: .word 0	# Khai báo biến y với giá trị 0
	z: .word 0	# Khai báo biến z với giá trị 0
.text
start:
	# TODO:
	# Khởi tạo giá trị i vào thanh ghi s1
	# Khởi tạo giá trị j vào thanh ghi s2
	la t0, i	# Load address i in t0
	lw s1, 0(t0)	# load value of i in s1
	lw s2, 4(t0)	# load value of j in s2
	# Khởi tạo x, y, z (t1, t2, t3)
	li t1, 0 # x = 0
	li t2, 0 # y = 0
	li t3, 0 # z = 0
	# Cạch 1:
	# blt s2, s1, else # if j < i them jump else
	# Cách 2:
	slt	t0, s2, s1	# set t0 = 1 if j < i else clear t0 = 0
	bne t0, zero, else	# t0 != 0 means t0 = 1, jump else
	
then:
	addi	t1, t1, 1	# then part: x = x + 1
	addi	t3, zero, 1	# z = 1
	j 	endif		# skip else part
else:
	addi	t2, t2, -1	# begin else part: y = y - 1
	add	t3, t3, t3	# z = 2 * z	
endif:
