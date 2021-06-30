.include "m8515def.inc"

.def bil1 = r16
.def bil2 = r17
.def temp = r23
.def ans = r1

main :
	ldi	temp,low(RAMEND)				// Set stack pointer to -
	out	SPL,temp						// -- last internal RAM location
	ldi	temp,high(RAMEND)
	out	SPH,temp
	
	ldi ZL, LOW(2*SESUATU)
	ldi ZH, HIGH(2*SESUATU)

	rcall load
	mov bil1, r0

	rcall load
	mov bil2, r0

	rjmp cari_fpb

load:
	lpm
	inc ZL
	ret

cari_fpb:
	tst bil2
	breq fpb_finished

	cp bil1, bil2
	brlt swap_bil

	sub bil1, bil2
	rjmp cari_fpb

	swap_bil:
		mov temp, bil1
		mov bil1, bil2
		mov bil2, temp
		rjmp cari_fpb

	fpb_finished:
		mov ans, bil1
		rjmp forever

forever :
    rjmp forever


// Penjelasan cari_fpb:
//
// algoritma fpb euclid
// fpb(a, b)	= a					jika b = 0
//				= fpb(b, a mod b)	jika b != 0
//
// dapat kita ubah menjadi
// fpb(a, b)	= a					jika b = 0
//				= fpb(b, a)			jika b != 0 dan a < b
//				= fpb(a - b, b)		jika b != 0 dan a >= b
//
// Alternate solution:
//
// selain cara ini bisa juga pake looping dan cek modulo
// menggunakan pengurangan berulang


SESUATU:
.db 120, 75 // akan diubah ubah oleh asdos
