.include "m8515def.inc"
LDI  R17, $0F
OUT  DDRA, R17
LDI  R18, $05
OUT PORTA, R18 

Forever:
IN R16, PINA
RJMP     Forever
