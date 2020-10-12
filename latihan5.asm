#Nama/NPM	: Hakim Amarullah/1906293051
#Tugas		: Latihan 5/Oct 12,2020

.data
	anggotaPOK : .word 19, 6, 29, 30, 51, 23, 55, 57, 59, 61, 63, 77, 71, 81, 67, 79, 88, 99
	hoki : .asciiz "Hoki : "
	klasik : .asciiz "\nKlasik : "
	prima : .asciiz "\nPrima : "
	asik : .asciiz "\nAsik : "
	
.text
.globl main
main	:
	la $t0,anggotaPOK
	li $t1, 0 #loop counter
	li $t2, 4 #Array size (We need to change the size if the array change)
	addi $t4, $zero, 7 
	addi $t6, $zero, 25
	addi $s4, $zero, 2 #to find prime
	li $s5, 26
	li $s0, 0 #hoki counter
	li $s1, 0 #klasik counter
	li $s2, 0 #prima counter
	li $s3, 0 #asik counter
	
	#hoki and klasik loop
	begin_loop :  bgt $t1, $t2, reloop
	              sll $t3, $t1, 2
	              addu $t3, $t3, $t0
	              lw $a0, 0($t3)
	              addi $t1, $t1, 1
	              bgt $a0, $t6, check_hoki
	              j begin_loop
	              
	#Check whether it's Hoki or not              
	check_hoki : div $a0, $t4
	             mfhi $t5
	             bnez $t5, increase_klasik
	             j increase_hoki
	# Increase Hoki if bnez $t5 not equals zero                 
	increase_hoki : addi $s0,$s0, 1
	                j begin_loop
	
	increase_klasik : addi $s1, $s1, 1
	                  j begin_loop
	 
	#Prima and Asik Loop
	reloop : li $t3,0 #set $t3 and $t1 to zero. so, it can be use again
		 li $t1,0
		 j prime
	#Loop array again to check prime
	prime :  bgt $t1, $t2, Done
	         sll $t3, $t1, 2
	         addu $t3, $t3, $t0
	         lw $a1, 0($t3)
	         addi $t1, $t1, 1
	         bgt $s5, $a1, check_prima #check if $a1<=25 but in greater than form
	         j prime
	#Check prime or not
	check_prima : beq $a1, $s4, increase_prime
	              div $a1, $s4
	              mfhi $t8
	              beqz $t8, increase_asik
	              addi $s4, $s4, 1
	              b check_prima
	#Increase prime
	increase_prime : addi $s2, $s2, 1
			 li $s4, 2 #Set $s4 to 2 again (this is the start of prime number)
			 j prime
	#Increase asik counter
	increase_asik : addi $s3, $s3, 1
			li $s4,2
			j prime
	              
                      
	Done : #Print Hoki
	            li $v0, 4
	            la $a0, hoki
	            syscall
	            li $v0, 1
	            la $a0, ($s0)
	            syscall
	            #print Klasik
	            li $v0, 4
	            la $a0, klasik
	            syscall
	            li $v0, 1
	            la $a0, ($s1)
	            syscall
	            #Print prima
	            li $v0, 4
	            la $a0, prima
	            syscall
	            li $v0, 1
	            la $a0, ($s2)
	            syscall
	            #Print Asik
	            li $v0, 4
	            la $a0, asik
	            syscall
	            li $v0, 1
	            la $a0, ($s3)
	            syscall
	            
	
	#Exit program
	li $v0, 10
	syscall
