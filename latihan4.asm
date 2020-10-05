#Nama/NPM 	: Hakim Amarullah/1906293051
#Kode Asdos 	: datapath
#Program 	: Hitung Luas Permukaan Balok
.data
	in1 : .asciiz "Berapa panjangnya? "
	in2 : .asciiz "\nBerapa Lebarnya? "
	in3 : .asciiz "\nBerapa tingginya? "
	out : .asciiz "\nLuas permukaannya adalah "
.text
main :
	#Print pesan input
	li $v0, 4 #Service print string
	la $a0, in1 #Save in address in1 a0
	syscall
	
	#Read integer input as Length
	li $v0, 5 #service read integer
	syscall
	#Check if  1<=$v0<=100
	L1 : slti $t0, $v0, 101 #Set less than 100
	     beq $t0, 0, Exit #if $v0 greater than 100, jump to Exit
	     slti $t0, $v0, 1 #check whether $v0 less than 1
	     beq $t0, 1, Exit #if $v0 less than 1, jump to Exit
	     move $s0, $v0 #if 1<=$v0<=100, move $v0 to $s0 (PANJANG)
	
	#Print pesan input
	li $v0, 4 #Service print string
	la $a0, in2 #Save in address in a0
	syscall
	
	#Read integer input as Width
	li $v0, 5 #service read integer
	syscall
	#Check if  1<=$v0<=100
	L2 : slti $t0, $v0, 101 #Set less than 100
	     beq $t0, 0, Exit #if $v0 greater than 100, jump to Exit
	     slti $t0, $v0, 1 #check whether $v0 less than 1
	     beq $t0, 1, Exit #if $v0 less than 1, jump to Exit
	     move $s1, $v0 #if 1<=$v0<=100, move $v0 to $s1 (LEBAR)
	
	#Print pesan input
	li $v0, 4 #Service print string
	la $a0, in3 #Save in address in a0
	syscall
	
	#Read integer input as Height
	li $v0, 5 #service read integer
	syscall
	
	#Check if  1<=$v0<=100
	L3 : slti $t0, $v0, 101 #Set less than 100
	     beq $t0, 0, Exit #if $v0 greater than 100, jump to Exit
	     slti $t0, $v0, 1 #check whether $v0 less than 1
	     beq $t0, 1, Exit #if $v0 less than 1, jump to Exit
	     move $s3, $v0 #if 1<=$v0<=100, move $v0 to $s3 (TINGGI)
	
	#Calculate Luas Permukaan
	mul $t1, $s0, $s1 #Panjang X Lebar
	mul $t2, $s0, $s3 #Panjang x Tinggi
	mul $t3, $s1, $s3 #Lebar x Tinggi
	add $t4, $t1, $t2 # (pxl + pxt)
	add $t4, $t4, $t3 # (pxl + pxt + lxt)
	addi $s4, $zero, 2 #constant 2
	mul $t4, $t4, $s4 #multiply $t4 with constant (store result in $t4)
	
	#Print output message
	li $v0, 4
	la $a0, out
	syscall
	#Print Luas Permukaan stored in $t4
	li $v0, 1
	la $a0, ($t4)
	syscall
	
	#Exit Label
	Exit :

	li $v0, 10 #exit service
	syscall