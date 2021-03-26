.data
	amount : .word 200,300,500
	permenA: .asciiz "Harga permen A: "
	permenB: .asciiz "\nHarga permen B: "
	permenC: .asciiz "\nHarga permen C: "
	prompt: .word permenA,permenB,permenC
	error : .asciiz "\nHarga dan diskon tidak boleh negatif\n"
	discount : .asciiz "\nDiskon permen: "
	success: .asciiz "\nTotal Harga: "
.text
	main:
		li $s1, 100
		li $t0, 3 #array size
		li $t1, 0 #iterator
		la $t2, prompt
		la $t3, amount
		li $s0, 0 #reserved for result
		input :
			beq $t1, $t0, discountPrice
			li $v0, 4
			lw $a0, 0($t2) #load prompt message from array
			syscall
			
			li $v0, 5 #take input
			syscall
			
			add $t5, $zero, $v0 #save price of current candy
			blt $t5, 1, errorPrice #check price if price<1 request input again
			lw $t4, 0($t3) #load amount of current candy
			
			mult $t5, $t4 #price of current candy x available amount of current candy
			mflo $a0
			add $s0, $s0, $a0 #result will
		
			addi $t2, $t2, 4 #address of prompt messages
			addi $t3, $t3, 4 #address of candy's amount saved in array
			addi $t1, $t1, 1 #increase iterator
			j input
		discountPrice : 
			  li $v0, 4
			  la $a0, discount #print prompt discount msg
			  syscall
			  
			  li $v0, 5
			  syscall #discount amount saved in $v0
			  
			  blt $v0, 0, warning
			  mult $s0, $v0 #total price x diskon
			  mflo $t0
			  
			  div $t0, $s1 #(total price x diskon) /100
			  mflo $t1
			  sub $s0, $s0, $t1 #price after discount
			  j Done
		warning:
			  	li $v0, 4
				la $a0, error #print warning
				syscall
				j discountPrice			
		errorPrice:
			li $v0, 4
			la $a0, error #print warning
			syscall
			j input #request again
			
		Done:
			li $v0, 4
			la $a0, success #messages on success
			syscall
			
			#print result saved in $s0
			li $v0, 1
			add $a0, $s0, $zero
			syscall
			
			li $v0, 10
			syscall
			
		