.include "m8515def.inc"

.org $00
	rjmp RESET
.org $01
	rjmp EXINT0	; INT0 vector (ext.interrupt from pin D2)
.org $02
	rjmp EXINT1
.org $05
	rjmp ISR_TCOM1
.org $06
	rjmp ISR_TOV1

RESET:
	ldi	r16,low(RAMEND)
	out	SPL,r16	            ;init Stack Pointer		
	ldi	r16,high(RAMEND)
	out	SPH,r16

	ldi r16, 1<<CS10 ; 
	out TCCR1B,r16			
	ldi r16,(1<<TOV1)|(1<<OCF1B)
	out TIFR,r16		; Interrupt if compare true in T/C0
	ldi r16,(1<<TOIE1)|(1<<OCIE1B)
	out TIMSK,r16		; Enable Timer/Counter0 compare int
	ldi r16,0b11111111
	out OCR1BH,r16		; Set compared value
	ldi r16,0b00000000
	out OCR1BL,r16		; Set compared value
	ser r16
	out DDRA,r16		; Set port A as output
	out DDRB,r16		; Set port B as output
	out PORTD,r16

	ldi r16, $00
	out DDRD,r16
	ldi r16,0b00001010
	out MCUCR,r16

	ldi r16,0b11000000
	out GICR,r16

	sei

forever:
	rjmp forever

EXINT0:
	push r16
	in r16,sreg
	push r16

	ldi r16,$33
	out PORTB,r16

	pop r16
	out sreg,r16
	pop r16
	reti

EXINT1:
	push r16
	in r16,sreg
	push r16

	ldi r16,$CC
	out PORTB,r16

	pop r16
	out sreg,r16
	pop r16
	reti

ISR_TCOM1:
	push r16
	in r16,SREG
	push r16
	in r16,PORTA	; read Port B
	com r16			; invert bits of r16 
	out PORTA,r16	; write Port B
	pop r16
	out SREG,r16
	pop r16
	reti

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
