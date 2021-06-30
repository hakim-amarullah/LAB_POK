.include "m8515def.inc"


INIT:
	ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16

LED_INIT:
	ser r17
	out DDRA, r17

LED_ON:
	ldi r17, 0b00000001
	out PORTA, r17
	rcall delay

	ldi r17, 0b00000010
	out PORTA, r17
	rcall delay

	ldi r17, 0b00000100
	out PORTA, r17
	rcall delay

delay:
	ldi r18, 2
	ldi r19, 4
	ldi r20, 187
L1:
	dec r20
	brne L1

	dec r19
	brne L1

	dec r18
	brne L1
	nop
	ret

