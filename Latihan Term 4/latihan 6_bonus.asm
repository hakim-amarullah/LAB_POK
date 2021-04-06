.data
	array : .byte 21, 42, 56, 57, 13, 12, 13, 41, 15, 12, 57
	array_end:
	sortedMsg: .asciiz "Data yang sudah diurutkan : "
	koma: .asciiz ", "
	prompt: .asciiz "\nData ke-berapa yang anda inginkan (Enter -1 to terminate): "
	res: .asciiz "\nData yang anda inginkan: "
	median: .asciiz "\nMediannya adalah "
	modus: .asciiz "\nModusnya adalah "
	warn : .asciiz "\nYour data range only 1-"
.text
	main:
		la $a0, array
		la $a1, array_end
		sub $t2, $a1,$a0 #arrayLength
		jal sortArray
		jal findMedian
		
		#print sorted array
		li $v0,4
		la $a0, sortedMsg #message for sortedMsg
		syscall
		
		li $t0, 0 #index and iterator
		printArray:
			lbu $t1, array($t0) #load byte element
			
			li $v0, 1
			move $a0, $t1 #print element
			syscall
			
			addi $t0,$t0, 1 #increase index of array
			beq $t0, $t2, printMedian #print median after printing the whole sorted array
			
			#print delimiter ", "
			li $v0, 4
			la $a0, koma
			syscall
			j printArray
		
		printMedian:
				li $v0, 4
				la $a0, median
				syscall
				
				li $v0, 1
				move $a0, $s4 #$s4 = median, after calling function findMedian
				syscall
		printModus:
				jal findMaxOccurence
				li $v0, 4
				la $a0, modus
				syscall
				li $t0, 0 #itertor loop1
				li $t4, 0 #iterator loop2
				li $t9, 0 #occurrence counter
				li $s5, 0
				loop1:
					beq $t0, $t2, nextInstruction
					lbu $t3, array($t0)
					beqz $t0, loop2
					loop2:
						beq $t4, $t2, check
						lbu $t1, array($t4)
						addi $t4, $t4, 1
						bne $t1, $t3, loop2
						addi $t9, $t9, 1 #increase counter
						j loop2
						
					check:
						bne $t9, $s4, reset
						beq $t3, $s5, reset
						
						li $v0, 1
						add $a0, $zero, $t3
						syscall
						#print delimiter ", "
						li $v0, 4
						la $a0, koma
						syscall
					reset:
						li $t9, 0
						li $t4,0
						add $s5, $zero, $t3 #avoid duplicate print
						addi $t0, $t0, 1
						j loop1
		
		sortArray:
			li $t0, 0 # i
			li $t1, 0 # j
			outerLoop:
				beq $t0, $t2, return
				lbu $s0, array($t0)
				sub $t3, $t2, $t0
				subi $t3, $t3, 1
				innerLoop:
					beq $t1, $t3, cleanReg
					lbu $s1, array($t1)
					addi $t4, $t1, 1
					lbu $s2, array($t4)
					bgt $s1, $s2, swap
					addi $t1, $t1, 1
					j innerLoop
				swap:
					addi $t5, $s1, 0 #temp = arr[j]
					sb $s2, array($t1) # arr[j] = arr[j+1]
					sb $t5, array($t4) #arr[j+1] = temp
					addi $t1, $t1, 1 #increase j
					j innerLoop
		cleanReg:
			li $t1,0
			addi $t0, $t0, 1 #increase i
			j outerLoop
		return:
			jr $ra
					
				
		findMedian :
				li $s1, 2
				addi $t5, $t2, 1 #$t5 = n+1
				div $t5, $t5, $s1 # $t5 = (n+1)/2
				subi $t5,$t5, 1 #$t5 = ((n+1)/2) -1
				lbu $s4, array($t5) #median element of array saved in $s4
				jr $ra
	
		findMaxOccurence:
			li $t0, 0 #index i
			li $t4, 0 #index j
			li $t9, 0 #counter
			li $s4, 0 #store max kemunculan
			for:
				beq $t0, $t2, returnMax
				lbu $t3, array($t0)
				for2:
					beq $t4, $t2, checkMax
					lbu $t1, array($t4)
					addi $t4, $t4, 1
					bne $t1, $t3, for2
					addi $t9, $t9, 1 #increase counter
					j for2
				checkMax:
					blt $t9, $s4, resetCounter
					add $s4, $zero, $t9
					resetCounter:
						li $t9, 0
						li $t4,0
						addi $t0, $t0, 1
						j for
				returnMax:
					jr $ra
			
							
				
		nextInstruction:
				li $v0, 4
				la $a0, prompt
				syscall
				
				li $v0, 5
				syscall
				
				beq $v0, -1, Done
				bgt $v0, $t2, warning
				addi $t8, $v0, -1
				lbu $t9, array($t8)
				
				li $v0, 4
				la $a0, res
				syscall
				
				li $v0, 1
				move $a0, $t9
				syscall
				j nextInstruction
				warning :
					li $v0, 4
					la $a0, warn
					syscall
					
					li $v0, 1
					add $a0, $0, $t2
					syscall
					j nextInstruction
			
		Done:
			li $v0, 10
			syscall
			
			
