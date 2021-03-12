.data
	array : .byte 12,1,2,1,3,4,5,6,7
	str: .asciiz "Here is the element of index  "
	newline : .asciiz "\n"
.text
	main :
		la $s0, array
		li $t0, 0
		
		li $v0, 5
		syscall
		
		read :
			add $s0, $s0, $v0
			lb $t0, 0($s0)
			sub $s0, $s0, $v0
			j exit
	exit:
		add $t1, $zero, $v0
		
		li $v0, 4
		la $a0, str
		syscall
		
		sub $a0, $a0, $a0
		li $v0, 1
		add $a0, $zero, $t1
		syscall
		
		li $v0, 4
		la $a0, newline
		syscall
		
		li $v0, 1
		move $a0, $t0
		syscall
		li $v0, 10
		syscall
		