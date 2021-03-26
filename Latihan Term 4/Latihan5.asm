.data
	msg1 : .asciiz "Apakah anda ingin memasukkan id baru(0/1)?"
	msg2: .asciiz "Masukkan input berapa digit: "
	msg3: .asciiz "Masukkan input:"
	warning_msg: .asciiz "Anda Bukan Children :("
	id: .word 
	npm: .word 1,9,0,6,2,9,3,0,5,1
.text
	main:
		la $t0, npm
		la $t5, id
		add $t2, $t0,36
		li $t1, 0
		
		input:	
			#print msg1
			li $v0, 4
			la $a0, msg1
			syscall
			
			#take input 0 or 1
			li $v0, 5
			syscall
			beqz $v0, npmID
			
			#print msg2
			li $v0, 4
			la $a0, msg2
			syscall
			
			#take input digit n
			li $v0, 5
			syscall
			bgt $v0, 10, Warning
			blt $v0, 2, Warning
			
			mul $v1, $v0, 4 #length of new array
		
			#print msg3
			li $v0, 4
			la $a0, msg3
			syscall
			
			#take input integer n digit
			li $v0, 5
			syscall
			add $t9, $zero, $v0 #save input of n digit in $t9
			
			li $a1, 10 #temporary value to get digit by digit
			addElement:
				   beq $t1, $v1, resetIterator
				   div $t9, $a1 #get digit by digit (start from last digit)
				   mflo $t9
				   mfhi $s0
				   sw $s0, 0($t5) #store every digit of input into array id
				   addi $t5, $t5, 4
				   addi $t1, $t1, 4
				   j addElement
		
			resetIterator: sub $t1, $t1, $t1 #reset iterator
					sub $t5, $t5, $v1 # reset addres of array id to original address
					add $t4, $t5, $v1 #set address to reverse iterate element
					addi $t4, $t4, -4 #-4 to avoid index out of bound
					
			calculateID:
					beq $t1, $v1, Done
					lw $s0, 0($t5) #element n
					lw $s1, 0($t4) #element n-1
					add $t3, $s0, $s1 #result by digit
					li $v0, 1 #printing digit by digit the result
					add $a0, $zero, $t3
					syscall
					addi $t5, $t5,4 #increase index n
					sub $t4, $t4, 4 # subtract reversed address
					addi $t1, $t1, 4 #increase iterator
					j calculateID
		npmID:
			beq $t1,40,Done
			lw $s0, 0($t0) #element n
			lw $s1, 0($t2) #element n-1
			add $t3, $s0, $s1 #result by digit 
			li $v0, 1 #printing digit by digit the result
			add $a0, $zero, $t3
			syscall
			addi $t0, $t0,4 #increase index n
			sub $t2, $t2, 4 #subtract reversed address
			addi $t1, $t1, 4 #increase iterator
			j npmID
		Warning :
			li $v0, 4
			la $a0, warning_msg
			syscall
		Done:
			li $v0,10
			syscall
			
	