# Laboratory Exercise 3, Assignment 4c
.text
start:
	# Khởi tạo i, j, x, y, z
	li s1, -5	# i = -5
	li s2, 5	# j = 5
	li t1, 1	# x = 1
	li t2, 2	# y = 2
	li t3, 3	# z = 3
	# Điều kiện rẽ nhánh i + j <= 0
	add t0, s1, s2	# sum = i + j
	bgtz t0, else	# if i + j <= 0, nhảy đến else
then:
	addi	t1, t1, 1	# then part: x = x + 1
	addi	t3, zero, 1	# z = 1
	j 	endif		# skip else part
else:
	addi	t2, t2, -1	# begin else part: y = y - 1
	add	t3, t3, t3	# z = 2 * z	
endif: