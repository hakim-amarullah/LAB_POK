.include "m8515def.inc"
		rjmp RESET
.equ BLOCK1 = $60
.def tempchar=r17
.def constant = r18
.def flashsize = r16

flash2ram:
	lpm			;get constant
	mov tempchar,r0
	cpi tempchar, $20 ;CHECKING SPACE
	brne save
	;SAVE SPACE
	ldi constant, 0
	add tempchar,constant
	st	Y+, tempchar	;store in SRAM and increment Y-pointer
	adiw ZL,1		;increment Z-pointer
	dec	flashsize
	brne flash2ram	;if not end of table, loop more
	ret

	save:
	cpi tempchar, $5A ;CHECK 'Z' in string
	breq save3
	cpi tempchar, $7A
	breq save2
	ldi constant, 1 ;SAVE other char except Z,z,and whitespace
	add tempchar,constant
	st	Y+, tempchar	;store in SRAM and increment Y-pointer
	adiw ZL,1		;increment Z-pointer
	dec	flashsize
	brne flash2ram	;if not end of table, loop more
	ret

	save2:
	ldi tempchar, 97 ;SET z to a
	st	Y+, tempchar	;store in SRAM and increment Y-pointer
	adiw ZL,1		;increment Z-pointer
	dec	flashsize
	brne flash2ram	;if not end of table, loop more
	ret

	save3:
	ldi tempchar, 65 ;SET Z to a
	st	Y+, tempchar	;store in SRAM and increment Y-pointer
	adiw ZL,1		;increment Z-pointer
	dec	flashsize
	brne flash2ram	;if not end of table, loop more
	ret

	
.def temp=r19
RESET:
	ldi	temp,low(RAMEND)
	out	SPL,temp	;init Stack Pointer		
	ldi	temp,high(RAMEND)
	out	SPH,temp

;***** Copy text flash -> SRAM

	ldi	ZH,high(2*SESUATU)
	ldi	ZL,low(2*SESUATU);init Z-pointer
	ldi	YH,high(BLOCK1)
	ldi	YL,low(BLOCK1)	;init Y-pointer
	rcall	flash2ram	



.def sem =r20
.def temp=r21

INIT:		
	ldi	temp,low(RAMEND) 	
	out	SPL,temp	 		
	ldi	temp,high(RAMEND)
	out	SPH,temp

Led_init:
	ser sem
	out DDRA,sem	; Init PORT A

START:
	ldi sem, 0b00001000
	out PORTA, sem	; output to PORT A
	rcall DELAY

	ldi sem, 0b00000100
	out PORTA, sem
	rcall DELAY

	ldi sem, 0b00000010
	out PORTA, sem
	rcall DELAY

	ldi sem, 0b00000001
	out PORTA, sem
	rcall DELAY

	ldi sem, 0b00000001
	out PORTA, sem
	rcall DELAY

	ldi sem, 0b00000010
	out PORTA, sem
	rcall DELAY

	ldi sem, 0b00000100
	out PORTA, sem
	rcall DELAY
	
	ldi sem, 0b00001000
	out PORTA, sem	; output to PORT A
	rcall DELAY


NPM:
	ldi sem, 0b00000011 //3
	out PORTA, sem
	rcall DELAY

	ldi sem, 0b00000000//0
	out PORTA, sem
	rcall DELAY

	ldi sem, 0b00000101//5
	out PORTA, sem
	rcall DELAY

	ldi sem, 0b00000001//1
	out PORTA, sem
	rcall DELAY

forever:
    rjmp forever
; Delay 400 000 cycles
; 100ms at 4 MHz

DELAY:
    ldi  r20, 3
    ldi  r21, 8
    ldi  r22, 120
L1: dec  r22
    brne L1
    dec  r21
    brne L1
    dec  r20
    brne L1
	ret


SESUATU:
.db "czm"
.db 0, 0
