.include "m8515def.inc"
.def res =r1
.def temp = r16
.def m = r2
.def n = r3

main:
	ldi temp, HIGH(RAMEND)
	out SPH, temp
	ldi temp, LOW(RAMEND)
	out SPL, temp

	ldi ZH, HIGH(2*INPUT)
	ldi ZL, LOW(2*INPUT)

	rcall load
	mov m, r0

	rcall load
	mov n, r0
	
	rcall recAdd

	rjmp end

load:
	lpm
	inc ZL
	ret

recAdd:
	tst n
	brne notZero
	mov res, m
	ret
	
	notZero:
		dec n
		rcall recAdd
		inc res
		ret

end:
	rjmp end

INPUT:
.db 2, 3
