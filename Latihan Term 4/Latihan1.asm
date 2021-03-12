.data

	nama: .asciiz "Halo, nama saya Hakim. Saya merupakan mahasiswa POK kelas B. saya memiliki  "
	saudara: .asciiz " saudara."
	prompt: .asciiz "Jumlah Saudara : "
	
.text 
	main:
		li $v0,4
		la $a0, prompt #load address prompt message
		syscall
		
		li $v0, 5 #request input
		syscall
		
		add $t1, $v0, $zero #Move integer input to $t1
		
		li $v0, 4
		la $a0, nama #print out name
		syscall
		
		li $v0, 1
		add $a0, $t1, $zero # add jumlah saudara to $a0
		syscall
		
		li $v0, 4
		la $a0, saudara #print string saudara next to jumlah saudara
		syscall
		
		#Exit program
		li $v0, 10
		syscall