.include "m8515def.inc"
.def result = r1
.def absHigher = r16
.def absLower = r17
.def temp = r18

main :
	ldi	temp,low(RAMEND)				// Set stack pointer to -
	out	SPL,temp						// -- last internal RAM location
	ldi	temp,high(RAMEND)
	out	SPH,temp

	ldi ZH, HIGH(2*INPUT)
	ldi ZL, LOW(2*INPUT)

	rcall load
	mov r16, r0 // SET R16 AS FIRST INPUT

	rcall load
	mov r17, r0 // SET R17 AS SECOND INPUT

	rcall absFunct // Find the absolute value for all input before calculate LCM
	rcall maxAbs // Find the maximum value of 2 input
	rcall LCM // call LCM funct 
	rjmp end // infinite loop

load:
	lpm // load data from program memory into r0
	adiw ZL, 1 // move Z pointer to next byte
	ret

absFunct:
	mov temp, r16
	add temp, temp //try to set the flag to check minus
	brmi abs1
	next:
		mov temp, r17
		add temp, temp //try to set the flag to check minus
		brmi abs2

	return: ret

	abs1: neg r16
		  rjmp next // check next value

	abs2: neg r17
		  rjmp return

maxAbs:
	cp r16, r17
	brlt swap_higher
	ret
	swap_higher:
			mov temp, r17
			mov absLower, r16
			mov absHigher, temp //Set the maxValue
			rjmp maxAbs
LCM:
	tst r16
	breq return0 // return zero if one or both of input are zero
	tst r17
	breq return0
	start:
		tst temp // -----------the Algorithm in java
		rcall mod // ---------while (temp % absLower != 0){
		breq return3// ------------temp += absHigher;
		add absHigher, absHigher//}
		rjmp start

	return3 :
			  mov result, absHigher //store result in r1
			  ret
	return0:
			sub temp, temp // just to find zero and store as the result
			mov result, temp // in r1
			ret

mod :
	mov temp, r16
	startMod:
		cp temp, absLower // function absHigher mod absLower
		brlt return2 
		sub temp, r17
		rjmp startMod
	return2 : ret

end:
	rjmp end		  
		
INPUT:
.db 2, 3
.db 0, 0
