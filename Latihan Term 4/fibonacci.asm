.data
	msg: .asciiz " "
	msg2: .asciiz "Fibonacci : "
	n : .word 50
	fibo: .word 
.text
	main :
		la $a1, fibo
		lw $a0, n
		la $a2, msg
		mul $t0, $a0, 4
		jal fibonacci

		li $v0, 4
		la $a0, msg2
		syscall
		printArray:
			lw $t3, fibo($t1)
			li $v0, 1
			add $a0, $t3, $zero
			syscall
			
			li $v0, 4
			add $a0, $zero, $a2
			syscall
			
			addi $t1, $t1, 4
			beqz $t0, Done # avoid infinite loop if n=0
			bne $t1, $t0, printArray
		Done:
			li $v0, 10
			syscall
	fibonacci:
		li $s0, 0 #n-2
		li $s1, 1 #n-1
		sw $s0, 0($a1) #initial value for n=0
		sw $s1, 4($a1) #initial value for n=1
		li $t3, 8
		beq $a0, 1, return #if n=1
		beqz $a0, return # if n=0
		start:
			beq $t3, $t0, return
			lw $s0, fibo($t1) #n-2
			addi $t1, $t1, 4
			lw $s1, fibo($t1) #n-1
			addu $s4, $s0, $s1 # n = n-1 + n-2
			sw $s4, fibo($t3) #n
			addi $t3, $t3, 4
			j start
		return:
			li $t3, 0
			li $t1, 0
			jr $ra
			
			
		
			
