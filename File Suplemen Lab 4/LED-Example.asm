.include "m8515def.inc"
.def sem =r18
.def temp=r16

INIT:		
	ldi	temp,low(RAMEND) 	
	out	SPL,temp	 		
	ldi	temp,high(RAMEND)
	out	SPH,temp

Led_init:
	ser sem
	out DDRE,sem	; Init PORT E

Led_phase1:
	ldi sem, 0x01
	out PORTE, sem	; output to PORT E
	rcall DELAY

	ldi sem, 0x02
	out PORTE, sem
	rcall DELAY

	ldi sem, 0x04
	out PORTE, sem
	rcall DELAY

	ldi sem, 0x08
	out PORTE, sem
	rcall DELAY

	ldi sem, 0x0F
	out PORTE, sem
	rcall DELAY

	ldi sem, 0x10
	out PORTE, sem
	rcall DELAY

	ldi sem, 0x20
	out PORTE, sem
	rcall DELAY

	ldi sem, 0x40
	out PORTE, sem
	rcall DELAY

	ldi sem, 0x80
	out PORTE, sem
	rcall DELAY

	ldi sem, 0xF0
	out PORTE, sem
	rcall DELAY

	ldi sem, 0xFF
	out PORTE, sem
	rcall DELAY

Led_FinalPhase:
	ldi sem, 0x55
	out PORTE, sem
	rcall DELAY

	ldi sem, 0xAA
	out PORTE, sem
	rcall DELAY

	rjmp Led_FinalPhase


; Delay 400 000 cycles
; 100ms at 4 MHz

DELAY:
    ldi  r18, 3
    ldi  r19, 8
    ldi  r20, 120
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
	ret
