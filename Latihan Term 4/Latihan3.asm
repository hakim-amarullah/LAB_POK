.data
	prompt : .asciiz "Jumlah teman yang kamu bawa: "
	success: .asciiz "\nTiap orang akan mendapat "
	permen: .asciiz " permen"
	error: .asciiz "\nInput harus ada pada rentang 0-999"
	
.text
	main :
		#jumlah permen tersedia
		li $v1, 1000
		li $v0, 4
		la $a0, prompt #request input
		syscall
		
		li $v0, 5
		syscall #take input integer
		
		add $t0, $zero, $v0 #save jumlah teman in $t0
		
		#check if jumlah teman<999
		bgt $t0, 999, errorAmount
		successDiv :
				add $t0, $t0, 1
				div $v1, $t0 #1000 divided by jumlah teman from input
				mflo $t1 #save result in $t1
				
				li $v0, 4
				la $a0, success
				syscall
				
				li $v0, 1
				add $a0, $zero, $t1
				syscall
				
				li $v0, 4
				la $a0, permen
				syscall
				j exit
		errorAmount : 
			li $v0, 4
			la $a0, error
			syscall
			j exit
	exit :
		li $v0, 10
		syscall