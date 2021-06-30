.include "m8515def.inc" //definisi tipe processor(ATM8515)
.def result = r2 //define register r2 as result


main:

	ldi ZH, HIGH(2*SOMETHING) // Memuat base address something untuk bisa mengakses byte by byte
	ldi ZL, LOW(2*SOMETHING) // Memuat base address something untuk bisa mengakses byte by byte
	//perubahan terjadi di r30 sebagai pointer Z

loop:
	lpm // load data yg ditunjuk pointer Z pada label something ke r0
	tst r0 //Menguji jika data yang diload bernilai nol
	breq stop // jika data pada r0=0, maka branch ke label stop
	mov r16, r0 // menyalin data dari r0 ke r16

funct1: //function mod 3
	cpi r16, 3 //compare r16 dengan imm, dan set flag (OP : Rd -K)
	brlt funct2 // brach ke funct2 jika r16 < 3
	subi r16, 3 //subtract content r16 by 3 and store it in r16
	rjmp funct1

funct2: //menjumlahkan semua sisa pembagian dengan 3
	add r1, r16 // r1 <-- r1+r16
	adiw ZL, 1 // add immmediate word, mov Z pointer to next byte address
	rjmp loop // jump to label loop

stop:
	mov result, R1 // copy the result from r1 to r2(result)

forever:
	rjmp forever //end of program

SOMETHING:
.db 2, 11, 7, 8 // store data by byte in program memory
.db 0, 0
