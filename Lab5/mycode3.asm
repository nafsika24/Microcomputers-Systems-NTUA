
INCLUDE MACROS.ASM 

DATA_SEG SEGMENT
  NEWLINE DB 0AH,0DH,'$'
  FIRST   DB ?
  SECOND  DB ?
DATA_SEG ENDS

CODE_SEG    SEGMENT
    ASSUME CS:CODE_SEG, DS:DATA_SEG
    
    
    
MAIN PROC FAR
    MOV AX,DATA_SEG
    MOV DS,AX
    
ADR0: PRINT "X"
      PRINT "="
      CALL HEX_KEYB
      CMP AL,'Q'
      JE QUIT
      MOV BL,16D
      MUL BL
      
      CALL HEX_KEYB
      CMP AL,'Q'
      JE QUIT
      ADD BL,AL
      MOV FIRST,BL
      PRINT "y"
      PRINT "="
      
ADR2: CALL HEX_KEYB
      CMP AL,'Q'
      JE QUIT
      MOV BH,16D
      MUL BH
      
      CALL HEX_KEYB
      CMP AL,'Q'
      JE QUIT
      ADD BL,AL
      MOV SECOND,BL


    MOV AH,0
    MOV BH,0
    MOV AL,FIRST
    MOV BL,SECOND
    ADD AX,BX
MOV DX,AX 

 PRNT_STR NEWLINE     
 PRINT "X"
 PRINT "+"
 PRINT "Y"
 PRINT "="
 
CALL PRINT_DEC
JMP QUIT
      
       
       
       
       
      
     
QUIT:
    EXIT 
    MAIN ENDP      
      
      
      
      
      
      
      

PRINT_DEC PROC NEAR     ; input: DL
                        ; prints its decimal form
    
    PUSH AX     ; save registers
    PUSH CX
    PUSH DX    
        
    MOV CX,1    ; initialize digit counter
    
    MOV AL,DL
    MOV DL,10 
    
LD: 
    MOV AH,0    ; divide number by 10
    DIV DL
    PUSH AX     ; save quotient
    CMP AL,0    ; if quot = 0, start printing
    JE PRNT_10
    INC CX      ; increase counter (aka digits number)
    JMP LD      ; repeat dividing quotients by 10

PRNT_10:
    POP AX      ; get digit
    MOV AL,AH
    MOV AH,0
    ADD AX,'0'  ; ASCII coded
    PRINT AL    ; print
    LOOP PRNT_10   ; repeat till no more digits 
    
    PRINT 'd'    
    
    POP DX                         
    POP CX      ; restore registers
    POP AX
    RET  
PRINT_DEC ENDP  
 
  
  
      
      
      
HEX_KEYB PROC NEAR ; ? ???t??a d?aﬂ??e? ??a ??? ??f?? ap? t?
; p???t??????? ?a? t? ep?st??fe? ?? d?ad??? µ?s? t?? AL.
PUSH DX ; ? ?ata?. DX ep??e??eta? ap? t? macro PRINT
IGNORE:
READ ; ???ﬂase t?? ?a?a?t??a ap? t? p???t???????
CMP AL, 'Q' ; ?? e??a? ? ?a?a?t??a? 'Q' t???? ???t??a?
JE ADDR2


CMP AL,30H ; ???tase a? ? ?a?a?t??a? e??a? ??f??
JL IGNORE ; ?? ??? a????s? t?? ?a? d??ﬂase ?????
CMP AL,39H
JG ADDR1
PUSH AX
PRINT AL ; ??p?se t? ??f??
POP AX
SUB AL,30H ; ??a???? t?? ?a?a??? a???µ?? ('0'=30)
JMP ADDR2
ADDR1: CMP AL,'A'
JL IGNORE
CMP AL,'F'
JG IGNORE
PUSH AX
PRINT AL
POP AX
SUB AL,37H ; ?etat??p? t?? HEX ASCII se ?a?a??
ADDR2: POP DX ; a???µ?('A'=41, 41H-37H=0AH=10D)
RET
HEX_KEYB ENDP
CODE_SEG ENDS
END MAIN