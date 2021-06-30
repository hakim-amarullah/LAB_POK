.include "m8515def.inc"

main:
	ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16
	
	LDI ZH, HIGH(2*PM)
	LDI ZL, LOW(2*PM)

	ldi r26, $27
	ldi r27, $02

	st -X, r26
	ld r18, X

	LDI XH, HIGH(0x60)
	LDI XL, LOW(0x60)
	rcall copyToData
	end:
		rjmp end
	
copyToData:
	lpm
	inc ZL
	mov r17, r0
	tst r17
	breq return
	inc r17
	st X+, r17
	rjmp copyToData
	return :
	ret
PM:
.db 'A','I','S','D','A','R'
.db 0
