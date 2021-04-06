.data
      matrix : .word 1,2
      		.word 5,9
      		.word 12,4,0,4,6
      		.word 4,3,2,1,3
      		.word 29,12,13,12,12
     size : .word 2
     success: .asciiz "Your Primary Diagonal Total is "
     success2: .asciiz "\nYour Secondary Diagonal Total is "
.text
	main :
		la $s0, matrix
		lw $s3, size
		addi $a1, $s3, 1
		jal sumDiagonal
		jal sumDiagonalSecondary
		
		li $v0,4
		la $a0, success
		syscall
		
		li $v0, 1
		move $a0, $s2
		syscall
		
		li $v0,4
		la $a0, success2
		syscall
		
		li $v0, 1
		move $a0, $s7
		syscall
		
		li $v0, 10
		syscall
	
	sumDiagonal:
		li $t0, 0
		subi $s3, $a1, 1
		start:
			sll $t1, $t0, 2
			mul $t1, $t1, $a1
			add $t1, $t1, $s0
			lw $s1, ($t1) #t1 = (colIndex*4)*(size+1)+base
			add $s2, $s2, $s1 #sum total
			addi $t0, $t0,1
			blt $t0, $s3, start
		return:
			jr $ra
	sumDiagonalSecondary:
		li $t0,0
		subi $s4, $s3, 1
		sll $s4, $s4, 2
		startSecondary:
			add $s0, $s0, $s4
			lw $s1, ($s0) #$t1=base + (size-1)*4
			add $s7, $s7, $s1 #sumSecondary 
			addi $t0, $t0,1
			blt $t0, $s3, startSecondary
		returnSecondary:
			jr $ra
			
			
		
