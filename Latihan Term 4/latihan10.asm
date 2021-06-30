.include "m8515def.inc"
.def temp = r16
.def initReg = r17
.def setReg = r18
INIT:
	ldi temp, HIGH(RAMEND)
	out SPH, temp
	ldi temp, LOW(RAMEND)
	out SPL, temp

LED_INIT:
	ser initReg 
	out DDRA, initReg //SET DDRA AS OUTPUT

LED_SIGN:
	ldi setReg, 0b00011000
	rcall ON
	rcall delay
	
	ldi setReg, 0b00100100
	rcall ON
	rcall delay

	ldi setReg, 0b01000010
	rcall ON
	rcall delay

	ldi setReg, 0b10000001
	rcall ON
	rcall delay

NPM:
	ldi setReg, 0b11000011
	rcall ON
	rcall delay
	
	ldi setReg, 0b00000000
	rcall ON
	rcall delay

	ldi setReg, 0b10100101
	rcall ON
	rcall delay

	ldi setReg, 0b10000001
	rcall ON
	rcall delay

MESSAGE_LED:
	ldi XH, HIGH($81)
	ldi XL, LOW($81)
	ld setReg, X
	rcall ON

END_LED:
	ldi setReg, 0b10000001
	rcall ON
	rcall delay
	
	ldi setReg, 0b01000010
	rcall ON
	rcall delay

	ldi setReg, 0b00100100
	rcall ON
	rcall delay

	ldi setReg, 0b00011000
	rcall ON
	rcall delay

DONE:
	rjmp DONE
	

ON:
	out PORTA, setReg
	ret	

delay:
	ldi r18, 11
	ldi r19, 38
	ldi r20, 94
L1:
	dec r20
	brne L1

	dec r19
	brne L1

	dec r18
	brne L1
	nop
	ret
