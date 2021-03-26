.data
	array: .word 1,2,7,2,0,1,12,6,8,0,0,7,0,45,0,2,56,0
	msg: .asciiz "Your result : "
	countThis: .byte 1
.text
	main :
		la $t0, array
		li $s0, 0
		lb $t4, countThis
		
		count:
			beq $s0, 72, Done
			lw $t1, 0($t0)
			beq $t1, $t4,countElem
			addi $s0, $s0, 4
			addi $t0, $t0, 4
			j count
			
			countElem:
				  addi $t3, $t3, 1
				  addi $s0, $s0, 4
				  addi $t0, $t0, 4
				  j count
	Done:
		li $v0, 4
		la $a0, msg
		syscall
		
		li $v0, 1
		add $a0, $zero, $t3
		syscall
		
		li $v0,10
		syscall
			