.MODEL SMALL 
.STACK 100H
.DATA 
PROMPT DB 'TYPE A CHARACTER TO DETECT THE TYPE.',0DH,0AH,'$'
UPPERCASE DB 'Uppercase letter ',0DH,0AH,'$'
LOWERCASE DB 'Lowercase letter ',0DH,0AH,'$'
NUMBER DB 'Number ',0DH,0AH,'$'
OTHERS DB 'Not an alphanumeric value ',0DH,0AH,'$'
NEWLINE DB 0Dh, 0Ah, '$'  ;

.CODE
.STARTUP  



MOV AX,@DATA 
MOV DS,AX


MOV AH,9
LEA DX,PROMPT
INT 21H 

MOV AH,1
INT 21H 
PUSH AX
LEA DX, NEWLINE
MOV AH, 9
INT 21H

POP AX   
MOV BL,AL

CMP BL,'A'
JB NOTUPPER
CMP BL,'Z'
JA NOTUPPER
LEA DX,UPPERCASE 
JMP PRINT

NOTUPPER:
CMP BL,'a'
JB CHECKNUMBER
CMP BL,'z'
JA CHECKNUMBER
LEA DX,LOWERCASE
JMP PRINT

CHECKNUMBER:
CMP BL,'0'
JB OTHER
CMP BL,'9'
JA OTHER
LEA DX,NUMBER
JMP PRINT 

OTHER:
LEA DX,OTHERS

PRINT:
MOV AH,9
INT 21H

 





