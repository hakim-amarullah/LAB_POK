.include "m8515def.inc"

MAIN:

	sbi PORTA,1 ; RS = 1
	cbi PORTA,2 ; R/W = 0
	ldi r16,0x41 ;
	out PORTB,r16; DB = 0x59
	sbi PORTA,0 ; EN = 1
	cbi PORTA,0 ; EN = 0
	rjmp MAIN
end:
	rjmp end
