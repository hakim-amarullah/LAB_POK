.data
	line : .asciiz "\n"
.text
	main :
		addi $s0, $zero, 270
		addi $s1, $zero, 192
		
		addi $a1, $zero, 1
		gcd :
			beq $s0, $zero, exit1
			add $t1, $zero, $s0
			add $t2, $zero, $s1
			
			div $t1, $t2
			move $t1, $t2
			mfhi $t2
			add $t0, $zero, $t2
			
			beq $t0, $zero, exit
			beq $t0, $a1, exit
			
			j gcd
			
	exit1:
		li $v0,1 
		add $a0, $zero, $s1
		syscall
		li $v0, 10
		syscall			
	exit:
		li $v0, 1
		mfhi $t1
		beq $t1, $a1, gcdNotFound
		mflo $a0
		syscall
		li $v0, 10
		syscall
		
		gcdNotFound:
			addi $a0, $zero, 1
			syscall
			
			li $v0, 10
			syscall