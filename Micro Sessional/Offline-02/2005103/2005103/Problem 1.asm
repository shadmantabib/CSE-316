.MODEL SMALL
.STACK 100h
.DATA
    PROMPT_CHOCOLATES DB 'Enter number of chocolates: $'
    PROMPT_WRAPPERS DB 'Enter wrappers required for exchange: $'
    RESULT_MSG DB 13, 10, 'Total chocolates: $'
    NUM_CHOCOLATES DW 0  
    NUM_WRAPPERS DW 0    
    NET_TOTAL_CHOCOLATE DW 0
    TEMP DW 0 

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    
    MOV DX, OFFSET PROMPT_CHOCOLATES
    MOV AH, 09h
    INT 21h
    CALL READ_NUMBER
    MOV NUM_CHOCOLATES, BX
    MOV BX, 0

    ; New line before next prompt
    MOV DL, 13       
    MOV AH, 02h
    INT 21h
    MOV DL, 10      
    INT 21h

    
    MOV DX, OFFSET PROMPT_WRAPPERS
    MOV AH, 09h
    INT 21h
    CALL READ_NUMBER
    MOV NUM_WRAPPERS, BX 
    MOV BX, 0

    
    MOV AX, NUM_CHOCOLATES
    MOV NET_TOTAL_CHOCOLATE, AX

  

NET_TOTAL_CHOCOLATE_LOOP:
    MOV AX, NUM_CHOCOLATES
    SUB AX, NUM_WRAPPERS   
    JNC EXCHANGE         
    JMP PRINT_TOTAL       

EXCHANGE:
    INC NET_TOTAL_CHOCOLATE  
    MOV NUM_CHOCOLATES, AX   
    INC NUM_CHOCOLATES       
    JMP NET_TOTAL_CHOCOLATE_LOOP   

PRINT_TOTAL:
    MOV DX, OFFSET RESULT_MSG
    MOV AH, 09h
    INT 21h
    MOV AX, NET_TOTAL_CHOCOLATE
    CALL PRINT_NUMBER
    MOV AX, 4C00h
    INT 21h
MAIN ENDP

READ_NUMBER PROC
    XOR AX, AX          
    XOR CX, CX          

READ_LOOP:
    MOV AH, 01h         
    INT 21h               
    MOV AH, 0
    CMP AL, 13        
    JE  DONE_READING    

    CMP AL, '0'         
    JB  READ_LOOP
    CMP AL, '9'
    JA  READ_LOOP

    SUB AL, '0'        
         
    CMP CX, 0          
    JE  FIRST_DIGIT      

    MOV bx,AX
    MOV AX, 10
    MUL TEMP
    ADD ax,bx
    MOV TEMP,AX             
    MOV BX, AX
    JMP READ_LOOP 
FIRST_DIGIT:
    ADD AX, BX         
    MOV TEMP, AX
    INC CX
    MOV BX,TEMP              
    JMP READ_LOOP        

DONE_READING:
    RET
READ_NUMBER ENDP

PRINT_NUMBER PROC
   
    MOV BX, 10         
    MOV CX, 0          
    OR AX, AX         
    JZ PRINT_ZERO      

REVERSE_DIGITS:
    XOR DX, DX         
    DIV BX             
    PUSH DX            
    INC CX             
    OR AX, AX          
    JNZ REVERSE_DIGITS  

PRINT_DIGITS:
    POP AX             
    ADD AX, '0'       
    MOV DX, AX         
    MOV AH, 02h       
    INT 21h            
    LOOP PRINT_DIGITS   

    RET               

PRINT_ZERO:            
    MOV DX, '0'
    MOV AH, 02h
    INT 21h
    RET
PRINT_NUMBER ENDP
END MAIN
