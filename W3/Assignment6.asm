# Laboratory 3, Assignment 6
.data
    array: .word 1, -3, 2, -5, 4, 7, -8, -2147483648, -21
.text
start:
    la t0, array        	# t0: &A
    li t1, 9           		# t1: n (number element of Array)
    li t2, 0            	# t2: i = 0
    lw t3, 0(t0)        	# t3: max_abs = A[0]
    li t6, -2147483648		# t6: -2^31
    mv a1, t3           	# a1: max_val = A[0] (giữ nguyên dấu)
    bltz t3, neg_change  	# Nếu A[0] < 0, đảo dấu
    j loop
neg_change:
    sub t3, zero, t3    	# max_abs = -A[0]
loop:
    bge t2, t1, endloop  	# Thoát nếu i >= n
    add t4, t2, t2
    add t4, t4, t4      	# t4 = i * 4
    add t4, t4, t0      	# t4 = &A[i]
    lw t5, 0(t4)       	 	# t5 = A[i]
    
    beq t5, t6, set_max 	# Nếu A[i] == -2^31, dừng ngay lập tức
    bltz t5, neg_val    	# Nếu A[i] < 0, đảo dấu
    j compare
neg_val:
    sub t5, zero, t5		# t5 = 0 - t5
compare:
    blt t5, t3, increment  	# Nếu max_abs >= abs(A[i]), bỏ qua
    addi t3, t5, 0      	# max_abs = abs(A[i])  
    mv a1, t5           	# max_val = A[i] (giữ nguyên dấu)
increment:
    addi t2, t2, 1      	# i++
    j loop
set_max:
    mv a1, t6           	# max_val = -2^31
    j endloop
endloop:
    # a1 chứa phần tử có giá trị tuyệt đối lớn nhất, giữ nguyên dấu
