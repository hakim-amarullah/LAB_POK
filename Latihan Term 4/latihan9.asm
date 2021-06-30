.include "m8515def.inc"
.def temp = r16
.def tempDiv = r21
.def divVar = r17
.def divRes = r18
.def less1 = r19
.def less2 = r20
.def. result = r22
.def input = r23
.def two = r25

RESET:
	ldi temp,low(RAMEND)
	out SPL,temp ;init Stack Pointer
	ldi temp,high(RAMEND)
	out SPH,temp

	ldi ZH, HIGH(DATA*2)
	ldi ZL, LOW(DATA*2)
	ldi two, 2

main:
	rcall load
	mov input, r0
	rcall POKnacci
	rcall save
	rjmp end

load:
	lpm
	ret
save:
	ldi YH, HIGH($81)
	ldi YL, LOW($81)
	st Y, result
	ret
end:
	rjmp end

POKnacci:
	push input
	push less1
	push less2
	push temp

	cpi input, 2
	brlt one // return 1 if input >= 1 or <=2
	breq one

	mov less1, input
	dec less1
	mov less2, input
	subi less2, 2

	mov input, less1
	rcall POKnacci
	mov divVar, result
	mov result, divRes
	mov temp, result
	
	mov input, less2
	rcall POKnacci
	mul two, result
	mov result, r0
	add result, temp
	rjmp done


	one:
		ldi result, 1
		rjmp done
	done:
		pop temp
		pop less2
		pop less1
		pop input
		ret

divide:
	mov tempDiv, divVar
	ldi divRes, 0
	startMod:
		cpi tempDiv, 2
		brlt return
		inc divRes
		subi tempDiv, 2
		rjmp startMod
	return : ret

DATA:
.db 5, 0 ; input
