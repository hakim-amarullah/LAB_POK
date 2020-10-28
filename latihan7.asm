
.include "m8515def.inc"			; Memasukkan definisi processor

.def result = r1				; Rename r1 sebagai result
.def bil1 = r16					; Rename r16 sebagai bil1
.def bil2 = r17					; Rename r17 sebagai bil2
.def temp = r18					; Rename r18 sebagai temp

main:
	ldi ZL, LOW(2*SESUATU)		; Load SESUATU ke Z Low
	ldi ZH, HIGH(2*SESUATU)		; Load SESUATU ke Z High
	
	lpm							; Load memory
	inc ZL						; Menggeser index Z Low selanjutnya
	mov bil1, r0				; Pindahkan nilai r0 ke bil1

	lpm							; Load memory
	inc ZL						; Menggeser index Z Low selanjutnya
	mov bil2, r0				; Pindahkan nilai r0 ke bil2

cari:
	cp bil1, bil2				; Bandingkan bil1 dan bil2
	brlt tukar					; Jika bil1 < bil2, ke 'tukar'
	sub bil1, bil2				; Kalau tidak bil1 -= bil2
	tst bil1					; Cek apakah bil1 = 0
	breq stop					; Jika bil1 = 0, ke 'stop'
	rjmp cari					; Kalau tidak ulangi ke 'cari'

tukar:
	mov temp, bil2				; Intinya menukar 
	mov bil2, bil1				; bil1 dan bil2
	mov bil1, temp				; menggunakan bantuan temp
	rjmp cari					; Balik lagi ke 'cari'
	
stop:
	mov result,bil2				; Pindahkan bil2 ke result

forever:
	rjmp forever				; Infinite loop

SESUATU:						; Input dua bilangan
.db 8, 3						; untuk mencari fpb
.db 0, 0
