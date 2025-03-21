# Laboratory Exercise 3, Assignment 4d
.text
start:
	# Khởi tạo i, j, x, y, z, m, n
	li s1, 2	# i = 10
	li s2, 5	# j = 5
	li t1, 1	# x = 1
	li t2, 2	# y = 2
	li t3, 3	# z = 3
	li s4, 7	# m = 7
	li s5, 3	# n = 3
	# Điều kiện rẽ nhánh i + j > m + n
	add t0, s1, s2	# sum = i + j
	add t4, s4, s5	# sum2 = m + n
	bge t4, t0, else	# if i + j <= m + n, nhảy đến else
then:
	addi	t1, t1, 1	# then part: x = x + 1
	addi	t3, zero, 1	# z = 1
	j 	endif		# skip else part
else:
	addi	t2, t2, -1	# begin else part: y = y - 1
	add	t3, t3, t3	# z = 2 * z	
endif: