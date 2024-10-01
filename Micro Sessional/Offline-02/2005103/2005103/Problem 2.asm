.model small
    .stack 100h
    
    .data 
        PROMPT_NUMBER DB 'Enter number: $'        
        number dw ? 
        output db 'The sum of digits is: $' 
        TEMP DW 0
        final dw 0
    .code
    main proc
        mov ax, @data
        mov ds, ax
    
        
        MOV DX, OFFSET PROMPT_NUMBER
        MOV AH, 09h
        INT 21h
        CALL READ_NUMBER
        MOV number, BX ;  
        
        
            ; New line before next prompt
        MOV DL, 13       
        MOV AH, 02h
        INT 21h
        MOV DL, 10      
        INT 21h 
       
    
        mov ax, number ; Initialize AX to store the sum of digits
        mov dx, 0
        mov bx, 10
        div bx
        push dx
        PUSH   AX
        CALL   sumdigit
        mov ax, final 
        call PRINT_NUMBER

  
        mov ax, 4C00h
        int 21h
      
    
        MAIN ENDP 
    
    
    
          sumdigit PROC
        PUSH BP
        MOV BP, SP
        cmp word ptr[BP+4],0  
                 
        JZ zero_case      
        
      
        mov dx,0
        mov ax,[bp+4]
        mov bx,10
        div bx
        push dx
        push ax
        call sumdigit
        
        
        
      ;  MOV CX, 10
       ; XOR DX, DX        
       ; DIV CX            ; AX now has num / 10, DX has num % 10
      ;  MOV CX, AX       
        
        
       ; PUSH CX
      ;  CALL sumdigit
        
        
        
        
       ; ADD AX, word ptr[bp+4]       
        ;JMP end_function 
        
    zero_case:
        MOV AX, 0       
        mov dx,[bp+6]
        add final,dx
        POP BP
        RET 4           
    sumdigit ENDP
    
       
      
     
    
    READ_NUMBER PROC
        XOR AX, AX          
        XOR CX, CX          
    
    READ_LOOP:
        MOV AH, 01h         
        INT 21h               
        MOV AH, 0
        CMP AL, 32        
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
    
    end main