.data
arr:          .space 400           # Mảng đầu vào (tối đa 100 số nguyên)
pos_arr:      .space 400           # Mảng chứa các số dương để sắp xếp
buffer:       .space 20            # Bộ đệm đọc chuỗi
prompt_n:     .asciz "Nhap so phan tu cua mang: "
prompt_i:     .asciz "Nhap phan tu thu "
prompt_is:    .asciz " la: "
error:        .asciz "So phan tu cua mang khong hop le\n"
input_error:  .asciz "Vui long khong de trong truong nhap\n"
space:        .asciz " "
newline:      .asciz "\n"

.text
main:
	# Nhap so phan tu
	li a7, 4
	la a0, prompt_n
	ecall

	li a7, 8
	la a0, buffer
	li a1, 20
	ecall

	# Kiem tra rong
	la t0, buffer
	lb t1, 0(t0)
	li a3, 10
	beq t1, a3, print_input_error   # ASCII '\n' = 10

	jal ra_chuoi_sang_so
	mv s0, a0    # s0 = n
	blez s0, print_error

	li t2, 0     # i = 0
nhap_mang:
	bge t2, s0, tach_so_duong

	li a7, 4
	la a0, prompt_i
	ecall
	li a7, 1
	mv a0, t2
	ecall
	li a7, 4
	la a0, prompt_is
	ecall

	# Nhap chuoi
	li a7, 8
	la a0, buffer
	li a1, 20
	ecall

	# Kiem tra rong
	la t0, buffer
	lb t1, 0(t0)
	li a3, 10
	beq t1, a3, print_input_error

	jal ra_chuoi_sang_so
	mv t3, a0

	# Luu vao mang arr[i]
	la t4, arr
	slli t5, t2, 2
	add t6, t4, t5
	sw t3, 0(t6)

	addi t2, t2, 1
	j nhap_mang

# Tach cac so duong vao pos_arr
tach_so_duong:
	li t0, 0         # i = 0
	li s1, 0         # dem = 0 (so phan tu duong)
tach_loop:
	bge t0, s0, sort_pos

	la t1, arr
	slli t2, t0, 2
	add t3, t1, t2
	lw t4, 0(t3)     # t4 = arr[i]

	li a1, 0
	ble t4, a1, skip_pos
	la t5, pos_arr
	slli t6, s1, 2
	add a2, t5, t6
	sw t4, 0(a2)
	addi s1, s1, 1
skip_pos:
	addi t0, t0, 1
	j tach_loop

# Bubble sort pos_arr
sort_pos:
	addi t0, s1, -1
outer:
	blt t0, zero, gan_lai
	li t1, 0
inner:
	bge t1, t0, next_outer
	la t2, pos_arr
	slli t3, t1, 2
	add t4, t2, t3
	lw a0, 0(t4)
	lw a1, 4(t4)
	bgt a0, a1, swap
	j no_swap
swap:
	sw a1, 0(t4)
	sw a0, 4(t4)
no_swap:
	addi t1, t1, 1
	j inner
next_outer:
	addi t0, t0, -1
	j outer

# Gan lai vao arr
gan_lai:
	li t0, 0
	li t1, 0
gan_loop:
	bge t0, s0, in_kq
	la t2, arr
	slli t3, t0, 2
	add t4, t2, t3
	lw t5, 0(t4)

	li a1, 0
	ble t5, a1, skip_update
	la t6, pos_arr
	slli a2, t1, 2
	add a3, t6, a2
	lw a4, 0(a3)
	sw a4, 0(t4)
	addi t1, t1, 1
skip_update:
	addi t0, t0, 1
	j gan_loop

# In ket qua
in_kq:
	li t0, 0
print_loop:
	bge t0, s0, end
	la t1, arr
	slli t2, t0, 2
	add t3, t1, t2
	lw a0, 0(t3)
	li a7, 1
	ecall
	li a7, 4
	la a0, space
	ecall
	addi t0, t0, 1
	j print_loop
	
ra_chuoi_sang_so:
	la t0, buffer
	li a0, 0       # result
	li t1, 0       # index

parse_loop:
	lb t2, 0(t0)
	li a3, 10
	beq t2, a3, done_parse    # newline
	li t3, '0'
	li t4, '9'
	blt t2, t3, invalid
	bgt t2, t4, invalid
	addi t2, t2, -48
	mul a0, a0, a3
	add a0, a0, t2
	addi t0, t0, 1
	j parse_loop
done_parse:
	ret
invalid:
	li a0, -1
	ret

print_error:
	li a7, 4
	la a0, error
	ecall
	j end

print_input_error:
	li a7, 4
	la a0, input_error
	ecall
	j end

end:
	li a7, 10
	ecall
