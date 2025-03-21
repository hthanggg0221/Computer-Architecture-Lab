.data
A: .word  1, -5, 3, 7, -2, 8, -6 # Khởi tạo mảng A với các phần tử số nguyên
.text
main:
	la	a0, A	# Tải địa chỉ cơ sở của mảng A vào thanh ghi a0
	li	a1, 8	# Gán giá trị 8 vào a1 (số phần tử trong mảng, nhưng thực tế mảng chỉ có 7 phần tử)
	j	mspfx	# Nhảy đến thủ tục mspfx để tính tổng tiền tố lớn nhất
continue:
exit:
	li	a7, 10	# Gán giá trị 10 vào a7 (mã cho system call kết thúc chương trình)
	ecall		# Gọi system call để kết thúc chương trình
end_of_main:
# ----------------------------------------------------------------- 
# Procedure mspfx 
# @brief find the maximum-sum prefix in a list of integers 
# @param[in] a0 the base address of this list(A) needs to be processed 
# @param[in] a1 the number of elements in list(A)  
# @param[out] s0 the length of sub-array of A in which max sum reachs. 
# @param[out] s1 the max sum of a certain sub-array 
# ----------------------------------------------------------------- 
# Procedure mspfx 
# Function: find the maximum-sum prefix in a list of integers 
# The base address of this list(A) in a0 and the number of 
# elements is stored in a1
mspfx:
	li	s0, 0			# Khởi tạo độ dài của tiền tố lớn nhất trong s0 là 0
	li	s1, 0x80000000		# Khởi tạo tổng tiền tố lớn nhất trong s1 là số nguyên nhỏ nhất (giá trị nhỏ nhất kiểu int)
	li	t0, 0			# Khởi tạo chỉ số i cho vòng lặp trong t0 là 0
	li	t1, 0			# Khởi tạo tổng chạy (running sum) trong t1 là 0
loop:
	add	t2, t0, t0		# Đưa 2*i vào t2 (tính 2*i)
	add	t2, t2, t2		# Đưa 4*i vào t2 (tính 4*i)
	add	t3, t2, a0		# Đưa địa chỉ của A[i] vào t3 (tính 4*i + A)
	lw	t4, 0(t3)		# Tải giá trị A[i] từ bộ nhớ vào t4
	add	t1, t1, t4		# Cộng giá trị A[i] vào tổng chạy (running sum) trong t1
	blt	s1, t1, mdfy		# Nếu tổng chạy (t1) lớn hơn tổng lớn nhất hiện tại (s1), nhảy đến mdfy để cập nhật kết quả
	j	next			# Nhảy đến bước tiếp theo nếu không cần cập nhật
mdfy:
	addi	s0, t0, 1		# Cập nhật độ dài mới của tiền tố lớn nhất (i + 1)
	addi	s1, t1, 0		# Cập nhật tổng tiền tố lớn nhất là tổng chạy hiện tại
next:
	addi	t0, t0, 1		# Tăng chỉ số i lên 1
	blt	t0, a1, loop		# Nếu i < n (số phần tử trong mảng), lặp lại
done:
	j	continue		# Kết thúc thủ tục, nhảy về continue
mspfx_end: