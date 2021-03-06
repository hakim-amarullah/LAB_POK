.include "m8515def.inc"

.def res = r1
.def bil1= r16
.def bil2 = r17

main :
		ldi ZL,LOW(2*angka)
		ldi ZH, HIGH(2*angka)
		
		lpm
		inc ZL
		mov bil1, r0

		lpm
		inc ZL
		mov bil2, r0
calc :
		cpi bil2, 1
		breq done
		add bil1, bil1
		subi bil2, 1
		rjmp calc
done:
		mov res, bil1
forever :
		rjmp forever
angka :
.db 7, 2
.db 0, 0
		
