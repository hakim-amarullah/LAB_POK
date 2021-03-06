.include "m8515def.inc"

.org $00
	rjmp RESET
.org $06
	rjmp ISR_TOV1

RESET:
	ldi	r16,low(RAMEND)
	out	SPL,r16	            ;init Stack Pointer		
	ldi	r16,high(RAMEND)
	out	SPH,r16

	ldi r16, (1<<CS10)	;
	out TCCR1B,r16			
	ldi r16,1<<TOV1
	out TIFR,r16		; Interrupt if overflow occurs in T/C0
	ldi r16,1<<TOIE1
	out TIMSK,r16		; Enable Timer/Counter0 Overflow int
	ser r16
	out DDRB,r16		; Set port B as output
	sei

forever:
	rjmp forever

ISR_TOV1:
	push r16
	in r16,SREG
	push r16
	in r16,PORTB	; read Port B
	com r16			; invert bits of r16 
	out PORTB,r16	; write Port B
	pop r16
	out SREG,r16
	pop r16
	reti
