.data

.text
	main :
		li $a0, 201
		jal sumDigit
		
		li $v0, 1
		add $a0, $zero, $t0
		syscall
		
		li $v0,10
		syscall
	sumDigit:
		li $t0, 0 #sum
		li $a1, 10
		start:
			blez $a0, returnSum
			div $a0, $a1
			mflo $a0
			mfhi $t1
			add $t0, $t0, $t1 #sum
			j start
		returnSum:
			jr $ra