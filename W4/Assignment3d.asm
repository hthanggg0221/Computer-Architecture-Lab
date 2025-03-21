.text
	li s1, 5		# s1 = 5
	li s2, 10		# s2 = 10
	li t1, 1		# x = 1
	li t2, 2		# y = 2
	li t3, 3		# z = 3
	bge s2, s1, else	# if s2 >= s1, junp else
then:
	add t3, t1, t2		# z = x + y
	j endif
else:
	sub t3, t2, t1		# z = y - x
endif: