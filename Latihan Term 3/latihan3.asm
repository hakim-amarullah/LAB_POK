#Nama/NPM 	: Hakim Amarullah/1906293051
#Kode Asdos 	: -
#Program 	: Hitung Volume kubus
.data
	in : .asciiz "Berapa panjang sisinya? " #inisialisasi pesan input
	out : .asciiz "\nVolumenya adalah " #inisialisasi pesan output
.text
main :
	#Print pesan input
	li $v0, 4 #Service print string
	la $a0, in #Save in address in a0
	syscall
	
	#Read integer input
	li $v0, 5 #service read integer
	syscall
	
	#Check if  1<=$v0<=100
	L1 : slti $t0, $v0, 101 #Set less than 100
	     beq $t0, 0, Exit #if $v0 greater than 100, jump to Exit
	     slti $t0, $v0, 1 #check whether $v0 less than 1
	     beq $t0, 1, Exit #if $v0 less than 1, jump to Exit
	     move $s0, $v0 #if 1<=$v0<=100, move $v0 to $s0
	     mul $t1, $s0, $s0 #multiply $s0 and $s0, store in $t1
	     mul $t1, $t1, $s0 #multiply $t1 and $s0, store in $t1(This is the volume)
	     
	     #Print output message
	     li $v0, 4
	     la $a0, out
	     syscall
	     #Print volume stored in $t1
	     li $v0, 1
	     la $a0, ($t1)
	     syscall
	#Exit program
	Exit:
	
	li $v0, 10 #Exit Service
	syscall