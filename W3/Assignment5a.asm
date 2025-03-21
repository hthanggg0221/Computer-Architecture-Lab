# Laboratory 3, Assignment 5a
.data
	A: .word 1, 3, 2, 5, 4, 7, 8, 9, 6
.text
	# TODO: Khởi tạo giá trị các thanh ghi
	li s1, 0	# i = 0
	la s2, A	# load address of array A in s2
	li s3, 9	# s3 = 9 (number of element in array A)
	li s4, 1	# s4 = 1 (step = 1)
	li s5, 0	# sum = 0
loop:
	blt s3, s1, endloop	# if i > n then end loop
	add t1, s1, s1		# t1 = 2 * s1
	add t1, t1, t1		# t1 = 4 * s1 => t1 = 4*i
	add t1, t1, s2		# t1 store the address of A[i]
	lw t0, 0(t1)		# load value of A[i] in t0
	add s5, s5, t0		# sum = sum + A[i]
	add s1, s1, s4		# i = i + step
	j loop			# go to loop
endloop: