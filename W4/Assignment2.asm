.text
	li 	s0, 0x12345678		# s0 = 0x12345678
	srli 	t0, s0, 24		# Trích xuất MSB (dịch phải 24 bit)
	andi 	t1, s0, 0xFFFFFF00	# Xóa LSB (AND với 0xFFFFFF00 để xóa LSB)
	ori 	t2, s0, 0x000000FF	# Thiết lập LSB (OR với 0xFF để đặt các bit từ 7 đến 0)
	li	s0, 0			# Xóa thanh ghi s0 (s0 = 0)