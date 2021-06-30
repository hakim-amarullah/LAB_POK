.include "m8515def.inc"

.def temp = r16
.def speed = r17
.def counter = r24

.org $00
	rjmp MAIN
.org $01
	rjmp EXT_INT0;Jump to INT0 when button0 pressed
.org $05
	rjmp ISR_TCOM0

MAIN:
	ldi counter, 0 ;Counter to conditioning which LED to be activated
	ldi speed, 0

INIT_STACK:
	ldi	temp,low(RAMEND)	;init Stack Pointer
	out	SPL,temp
	ldi	temp,high(RAMEND)
	out	SPH,temp

INIT_INT0: ;BUTTON INT0
	ldi temp,0b00000010
	out MCUCR,temp ;GENERATES INT0 REQUEST ON FALLING EDGE
	ldi temp,0b01000000 
	out GICR,temp ;SET INT0



INIT_TIMER_INTERRUPT:
	ldi temp, 1<<CS11
	out TCCR1B,temp ;Pck/8
	ldi temp,1<<OCF1B
	out TIFR,temp		; Interrupt if compare true in T/C0
	ldi temp,1<<OCIE1B
	out TIMSK,temp		; Enable Timer/Counter0 compare int
	ldi temp,0b01111111
	out OCR1BH,temp		; Set compared value
	ldi temp,0b00000000
	out OCR1BL,temp		; Set compared value

INIT_LED:
	ser temp
	out DDRB,temp		; Set port B as output

SET_INITIAL_LED:
	push temp
	in temp,SREG
	push temp
	ldi temp, 0b10000001
	out PORTB,temp	; TURN ON RED LED
	pop temp
	out SREG,temp
	pop temp
	sei

END:
	rjmp END


// Interrupt Button latihan 13-2 button INT0
EXT_INT0:
	subi speed, -1
	cpi speed, 2
	breq SPEED_TO_ZERO
	rjmp EXT_INT0_CONTINUE

SPEED_TO_ZERO:
	ldi speed, 0

EXT_INT0_CONTINUE:
	cpi speed, 1
	breq SPEED_FAST

SPEED_SLOW:
	ldi temp, 1<<CS11
	rjmp EXT_INT0_FINISHED

SPEED_FAST:
	ldi temp, 1<<CS10

EXT_INT0_FINISHED:
	out TCCR1B,temp
	reti



	
// Interrupt Timer (using compare OCR1)
ISR_TCOM0:
	push temp
	in temp,SREG
	push temp
	
	adiw counter, 1
	

	cpi counter, 8
	breq COUNTER_TO_ZERO

	
	rjmp CONTINUE_ISR
	

COUNTER_TO_ZERO:
	ldi counter, 0


CONTINUE_ISR:
	cpi counter, 0
	breq LED_RED

	cpi counter, 1
	breq LED_GREEN

	cpi counter, 2
	breq LED_YELLOW

	cpi counter, 3
	breq LED_BLUE

	cpi counter, 4
	breq LED_YELLOW

	cpi counter, 5
	breq LED_GREEN

	cpi counter, 6
	breq LED_RED

	cpi counter, 7
	breq LED_OFF

LED_RED:
	ldi temp, 0b10000001
	rjmp LAST_ISR ;TURN OUT LED USING PORTB AS OUTPUT PORT

LED_GREEN:
	ldi temp, 0b01000010
	rjmp LAST_ISR

LED_YELLOW:
	ldi temp, 0b00100100
	rjmp LAST_ISR

LED_BLUE:
	ldi temp, 0b00011000
	rjmp LAST_ISR

LED_OFF:
	ldi temp, 0b00000000
	rjmp LAST_ISR

LAST_ISR:
	out PORTB,temp	; write to Port B
	pop temp
	out SREG,temp
	pop temp
	reti

