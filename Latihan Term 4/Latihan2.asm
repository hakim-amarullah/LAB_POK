.data
	bulan : .asciiz "Bulan Lahir: "
	tahun : .asciiz "Tahun Lahir: "
	msg: .asciiz "\nSaya berumur "
	msg2: .asciiz " tahun."
	"MANUAL : Bulan $t0, Tahun $t1"
.text
	#tahun acuan
	addi $v1, $zero, 2021
	main:
		#print bulan request message
		li $v0, 4
		la $a0, bulan
		syscall
		
		#take integer input of bulan
		li $v0, 5
		syscall
		add $t0, $v0, $zero #save bulan in $t0
	
		#print tahun request message
		li $v0, 4
		la $a0, tahun
		syscall
		
		#take integer input of tahun
		li $v0, 5
		syscall
		add $t1, $v0, $zero #save tahun in $t1
		
		#check bulan lahir lebih dari maret atau tidak
		bgt $t0, 3, notOn12March
		
		#lahir di bulan maret atau sebelumnya
		birthOnMarch :
				sub $t2, $v1, $t1 #Save age after (2021 - tahun input)
				j Done	
		notOn12March :
				sub $t2, $v1, $t1
				sub $t2, $t2, 1 #Save age after 2021 - tahun input -1
				j Done
				
	Done :
		li $v0, 4
		la $a0, msg #print "Saya berumur"
		syscall
		
		li $v0, 1
		add $a0, $zero, $t2 #print age
		syscall
		
		li $v0, 4
		la $a0, msg2
		syscall
		
		#exit
		li $v0, 10
		syscall
		
		
		
