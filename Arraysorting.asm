.MODEL SMALL
.STACK 100H
.DATA
msg1  DW  'Enter size of array :$'
msg2  DW  ,0AH,0DH,'Array elements are :$'  
msg3  DW  ,0AH,0DH,'size of array must be positive interger:  $'
msg4  DW  'please,choose Array type for sort (enter 1 for Bubble sort)$'
msg5  DW  'OR (enter 2 for SELECTION sort) OR(enter 3 for Insertion sort)$' 
msg6  DW  'OR (enter 4 for Quick sort) OR (enter 5 to display array)$'  
msg7  DW  'OR (enter 6 to reverse array):$'
msg8  DW  'you can only choose 1 for bubble or 2 for Selection OR 3 OR 4 OR 5 OR 6 :$'
msg9  DW  ,0AH,0DH,'your sorted array in ascending order is:$'
msg10 DW  ,0AH,0DH,'your sorted array in descending order is:$'
msg11 DW  ,0AH,0DH,'your Array has no elements,please enter POSITIVE integer from 0 to 255:$'
msg12 DW  ,0AH,0DH,'your array is:$'
msg13 DW  ,0AH,0DH,'your reversed array is: $'
msg14 DW   ,0AH,0DH,'size of array can not be greater than 255.please enter POSITIVE integer from 0 to 255:$'
ARRAY DW 255 DUP(?)  
i     DW  ? 
j     DW  ?
p     DW  0                           
r     DW  ?                          
q     DW  ?
x     DW  ?
SIZE  DW ?
TEMP  DW ?  
.CODE

MAIN PROC

	MOV AX, @DATA                	; initialize DS
     	MOV DS, AX
     	LEA DX, msg1             	; load address of msg1 in DX
     	MOV AH, 9                    	; AH value for dos interrupt to print msg1
     	INT 21H                      	; interrupt dos that takes input from user
     	LEA SI, ARRAY              	; load adderss of ARRAY in SI
@IF_No_Elements:
     CALL Get_Size                ; call the procedure GET_Size
     AND AX, 00FFH                ; to get the value of only AL as the size of array
     MOV BX,AX                    ; put value of AL in to BX register BX=AX
     CMP BX,0                     ; IF input==0
     je @IF_NO_ELEMENTS1         ; JUMP to IF_NO_ELEMENTES1 lable if the input equals(0)
     LEA DX, msg2             ; load and display the string msg2, user interface(UI), to take the farray elements from user.
     MOV AH, 9                    ; AH value for dos interrupt output a message
     INT 21H
     MOV dl, 10
     MOV ah, 02h
     INT 21h
     MOV dl, 13
     MOV ah, 02h
     INT 21h                      ; interrupt dos that takes input from user
     CALL GET_ARRAY              ; call the procedure GET_ARRAY
   @CHOOSE:  
     LEA DX, msg4             ; load and display the string msg4 to get the value of the condition variable (1,2).
     MOV AH, 9                    ; AH value for dos interrupt output a message
     INT 21H
     MOV dl, 10
     MOV ah, 02h
     INT 21h
     MOV dl, 13
     MOV ah, 02h
     INT 21h                      ; interrupt dos that takes input from user 
     LEA DX, msg5             ; load and display the string msg5 to get the value of the condition variable (1,2).
     MOV AH, 9                    ; AH value for dos interrupt output a message
     INT 21H
     MOV dl, 10
     MOV ah, 02h
     INT 21h
     MOV dl, 13
     MOV ah, 02h
     INT 21h         
     LEA DX, msg6             ; load and display the string msg6 to get the value of the condition variable (1,2).
     MOV AH, 9                    ; AH value for dos interrupt output a message
     INT 21H
     MOV dl, 10
     MOV ah, 02h
     INT 21h
     MOV dl, 13
     MOV ah, 02h
     INT 21h     
     LEA DX, msg7             ; load and display the string msg7 to get the value of the condition variable (1,2).
     MOV AH, 9                    ; AH value for dos interrupt output a message
     INT 21H  
     LEA SI,ARRAY                 ; load array offset to SI
     CALL validation_check               ; call validation_check function to make a decision of sort type to use 
 
    @IF_NO_ELEMENTS1:
     LEA DX, msg11             ; load and display the string msg11
     MOV AH, 9                    ; AH value for dos interrupt output a message
     INT 21H                      ; interrupt dos that takes input from user
     jmp @IF_No_Elements             ; jump IF_No_Elements label 
     MOV AH, 4CH                  ; AH Value for dos interrupt exit program
     INT 21H                      ; interrupt dos             
 
  MAIN ENDP


validation_check PROC 
    push bx                       ; push BX inthe STACK
   
    lable_READ0:
 
     XOR CX,CX                    ; put CX register equals to zero, CX==0
     XOR BX,BX                    ; put BX register equals to zero, BX==0
     XOR AX,AX                    ; put AX register equals to zero, AX==0
     
     Mov AH,1                     ; read a character
     INT 21h                      ; interrupt dos that takes input from user
     
     cmp    al, '-'               ; compare input with -
     JE lable_NEGATIVE                 ; JUMP to NEGATIVE lable if the input equals(-)
     
     cmp al,'+'                   ;compare input with +
     jE lable_POSITIVE                 ; JUMP to POSITIVE lable if the input equals(+)       
     jmp lable_input0                  ; JUMP to input0 lable        
              
    lable_NEGATIVE:                    ; NEGATIVE lable
     INC CL                       ; CL=CL+1
     JMP lable_ERROR0                  ; JUMP to ERROR0 lable
   
    lable_POSITIVE:                    ; POSITIVE lable
     INC CL                       ; CL=CL+1
     JMP lable_ERROR0                  ; JUMP to ERROR0 lable 
     
            
      lable_INPUT0:                      ; INPUT0 lable
     MOV BL,AL                    ; BL=AL
     MOV AH, 1                    ; read a character
     INT 21H                      ; interrupt dos that takes input from user

    lable_SKIP_INPUT0:                 ; SKIP_INPUT0 label
     CMP AL, 0DH                  ; compare AL with Return (enter)
     JE lable_END_INPUT0               ; jump to label lable_END_INPUT if the input equals (enter)  

     CMP AL, 8H                   ; compare AL with 8H   (backspace)
     JNE lable_NOT_BACKSPACE0          ; jump to label lable_NOT_BACKSPACE if AL!=8
 
    lable_MOVE_BACK0:                  ; MOVE_BACK0 label
     MOV AH, 2                    ; put output function
     MOV DL, 20H                  ; put DL=' '
     INT 21H                      ; print a character
     MOV DL, 8H                   ; put DL=8H
     INT 21H                      ; print a character
     XOR DX, DX                   ; clear DX
     DEC CL                       ; put CL=CL-1
     JMP lable_INPUT0                  ; jump to label lable_INPUT0     

    lable_NOT_BACKSPACE0:              ; NOT_BACKSPACE0 label
     INC CL                       ; put CL=CL+1
     CMP AL, 30H                  ; compare AL with 0
     JL lable_ERROR0                   ; jump to label lable_ERROR0if AL<0
     CMP AL, 39H                  ; compare AL with 9
     JG lable_ERROR0                   ; jump to label lable_ERROR0if AL>9
     AND AX, 000FH                ; convert ascii to decimal code  

     PUSH AX                      ; push AX inthe STACK
     MOV AX, 10                   ; put AX=10
     MUL BX                       ; put AX=AX*BX
     MOV BX, AX                   ; put BX=AX
     POP AX                       ; pop a value from STACK into AX
     ADD BX, AX                   ; put BX=AX+BX
     JS lable_ERROR0                   ; jump to label lable_ERROR if SF=1
     JMP lable_INPUT0                  ; jump to label lable_INPUT0    
                       
    lable_ERROR0:                      ; ERROR0 label
     MOV AH, 2                    ; put output function
     MOV DL, 7H                   ; put DL=7H  (beep sound)
     INT 21H                      ; print a character
     
    lable_CLEAR0:                      ; CLEAR0 label  
     MOV DL, 8H                   ; put DL=8H (backspace in ascii)
     INT 21H                      ; print a character
     MOV DL, 20H                  ; put DL=' '(Space in ascii)
     INT 21H                      ; print a character
     MOV DL, 8H                   ; put DL=8H (backspace in ascii)
     INT 21H                      ; print a character 
    LOOP lable_CLEAR0                  ; jump to label lable_CLEAR0 if CX!=0
    JMP lable_READ0                    ; jump to label lable_READ0
       
   lable_END_INPUT0:                   ; END_INPUT0 label  


 @CHECK_BUBBLE:                 ; CHECK_BUBBLE label
    CMP BL,31h                    ; check if input equals to ASCII(1)
    JE @BUBBLE_SORT               ; JUMP to BUBBLE_SORT if input equals to ASKII(1)
    JNE @CHECK_SELECT             ; JUMP to CHECK_SELECT if input not equals to ASKII(1)

   @CHECK_SELECT:                 ; CHECK_SELECT label
    CMP BL,32h                    ; check if input equals to ASCII(2)
    JE @SELECT_SORT               ; JUMP to SELECT_SORT if input equals to ASCII(2)
    JNE @CHECK_INSERTION
  @CHECK_INSERTION: 
     CMP BL,33h 
     JE @INSERTION_SORT
     JNE @CHECK_QUICK  
   @CHECK_QUICK: 
     CMP BL,34h 
     JE @QUICK_INIT
     JNE @PRINT
   @QUICK_INIT:
     POP BX
     MOV SIZE,BX
     PUSH BX 
     MOV  CX,SIZE
     DEC  CX
     MOV  R,CX  
     CALL QUICK_SORT
     PUSH SIZE
     JMP @ENDSORT
   @PRINT:
     CMP BL,35H
     POP BP
     JE  PRINT_ARRAYS
     JNE @RPRINT
   @RPRINT:
     CMP BL,36H
     JE  PRINT_ARRAY_REVERSES
     LEA DX, msg8                  ; load and display the string msg8, user interface(UI), to take a nother input from user.
     MOV AH, 9                     ; AH value for dos interrupt output a message
     INT 21H                       ; interrupt dos that takes input from user
     MOV CX,1                      ; CX=1              
     Jne lable_ERROR0                   ; JUMP to ERROR0 if input not equals to ASCII(2)            
   PRINT_ARRAYS:
      LEA DX, msg12               ; load and display the string msg12
      MOV AH, 9                   ; AH value for dos interrupt output a message
      INT 21H 
      CALL DISPLAY_ARRAY            ; call the procedure PRINT_ARRAY
      MOV AH, 4CH                 ; return control to DOS
      INT 21H
   PRINT_ARRAY_REVERSES: 
      LEA DX, msg13               ; load and display the string msg13 
      MOV AH, 9                   ; AH value for dos interrupt output a message
      INT 21H 
      CALL DISPLAY_ARRAY_REVERSE    ; call the procedure PRINT_ARRAY_REVERSE
      MOV AH, 4CH                 ; return control to DOS
      INT 21H
      RET 


   @BUBBLE_SORT:
    POP BX                        ; pop a value from STACK into BX
    MOV AX, SI                    ; put AX=SI
    MOV CX, BX                    ; put CX=BX
    PUSH BX                       ; push BX onto the STACK  
    CMP CX,1                      ; IF CX<=1
    JLE  @ENDSORT                ; JUMP TO Skip_Dec lable
    DEC CX                        ; put CX=CX-1
   
   @FIRST_LOOP:                   ; loop label
    MOV BX, CX                    ; put BX=CX
    MOV SI, AX                    ; put SI=AX
    MOV DI, AX                    ; put DI=AX
    INC DI
    INC DI                        ; put DI=DI+2
     @SECOND_LOOP:                 ; loop label 
       MOV DX, [SI]               ; put DL=[SI]
       CMP DX, [DI]               ; compare DL with [DI]
       JNG @SKIP_EXCHANGE         ; jump to label @SKIP_EXCHANGE if DL<[DI]
       XCHG DX, [DI]              ; put DL=[DI], [DI]=DL
       MOV [SI], DX               ; put [SI]=DL
     @SKIP_EXCHANGE:              ; SKIP_EXCHANGE label
      INC SI 
      INC SI                      ; put SI=SI+2
      INC DI
      INC DI                      ; put DI=DI+2
      DEC BX                      ; put BX=BX-1
     JNZ @SECOND_LOOP              ; jump to label @SECOND_LOOP if BX!=0
    LOOP @FIRST_LOOP              ; jump to label @FIRST_LOOP while CX!=0
    JMP @ENDSORT
   

 @SELECT_SORT:
     POP BX                       ; pop a value from STACK into BX   
     CMP BX, 1                    ; compare BX with 1
     PUSH BX                      ; push BX onto the STACK                      
     JLE @ENDSORT            ; jump to label @ENDSORT if BX<=1
     PUSH BX                      ; push BX onto the STACK    
     DEC BX                       ; put BX=BX-1
     MOV CX, BX                   ; put CX=BX
     MOV AX, SI                   ; put AX=SI
     
     @FIRST_LOOP2:                ; loop label
      MOV BX, CX                  ; put BX=CX
      MOV SI, AX                  ; put SI=AX
      MOV DI, AX                  ; put DI=AX
      MOV DX, [DI]                ; put DL=[DI]
      @SECOND_LOOP2:               ; loop label
       INC SI                     ; put SI=SI+1
       INC SI                     ; put SI=SI+1
       CMP [SI], DX               ; compare [SI] with DL
       JNG @SKIP2                 ; jump to label @SKIP if [SI]<=DL
       MOV DI, SI                 ; put DI=SI
       MOV DX, [DI]               ; put DL=[DI]
       @SKIP2:                    ; SKIP2 label
       DEC BX                     ; put BX=BX-1
     JNZ @SECOND_LOOP2             ; jump to label @SECOND_LOOP2 if BX!=0
     MOV DX, [SI]                 ; put DL=[SI]
     XCHG DX, [DI]                ; put DL=[DI] , [DI]=DL
     MOV [SI], DX                 ; put [SI]=DL
    LOOP @FIRST_LOOP2
     jmp @ENDSORT 
    @INSERTION_SORT:  
     POP AX                       ; pop a value from STACK(SIZE) into AX 
     CMP AX,1                     ; compare AX with 1
     PUSH AX                      ; push AX onto the STACK                                               
     JLE @ENDSORT            ; jump to label @ENDSORT if AX<=1(ONE ELEMENT IN ARRAY --NO NEED TO SORT--)  
     MOV BX,1                     ; put i=1
    @I_FIRST_LOOP:
		CMP  BX,AX				            ;the outer loop condition(i<size)
		JGE  @ENDSORT
		MOV  DX,0
		SHL  BX,1
		MOV  DX,[SI+BX]               ;dx = Array[i]
		SHR  BX,1			      
		MOV  TEMP, DX                 ;storing the element (i) into the temporary variable, temp
		PUSH BX					              ;saving the outer loop counter
     @I_SECOND_LOOP:
		CMP  BX,0				              ;inner loop first condition (i>0)
		JLE  @EXIT_I_SECOND_LOOP 
		DEC  SI
		DEC  SI
		SHL  BX,1 
		MOV  DX,TEMP
		CMP  [SI+BX],DX            ;inner loop second condition (temp<Array[j-1])
		JLE  @EXIT_SECOND_LOOP
		SHR  BX,1
		INC  SI 
		INC  SI		
		MOV  DX,0
		SHL  BX,1
		DEC  SI
		DEC  SI					
		MOV  DX,[SI+BX]            ;dx = Array[j-1]
		INC  SI
		INC  SI		  
		MOV  [SI+BX], DX           ;Array[j] = dx
		SHR  BX,1		
		DEC  BX					           ;bx-- (j--)
		JMP  @I_SECOND_LOOP
	@EXIT_SECOND_LOOP:
		SHR  BX,1
		INC  SI 
		INC  SI
		JMP  @EXIT_I_SECOND_LOOP 
     @EXIT_I_SECOND_LOOP:
		MOV  DX,0					
		MOV  DX,TEMP              ;dx = temp
		SHL  BX,1	
		MOV  [SI+BX],DX		       ;Array[j] = dx
		POP  BX					         ;restore the outer loop counter
		INC  BX				           ;bx++ (i++)
		JMP  @I_FIRST_LOOP


QUICK_SORT: 
        mov  ax, p
        cmp  ax, r                  ;COMPARE P WITH R
        jge  @IS_BIGGER                ;IF P = R, SORT IS DONE.
    
        ;CALL PARTITION(A, P, R).
        call partition
    
        ;GET Q = PARTITION(A, P, R).
        mov  q, ax
    
        ;PUSH Q+1, R INTO STACK FOR LATER USAGE.
        inc  ax
        push ax
        push r
    
        ;CALL QUICKSORT(A, P, Q-1).
        mov  ax, q
        mov  r, ax
        dec  r
        call QUICK_SORT
    
        ;CALL QUICKSORT(A, Q+1, R).
        pop  r
        pop  p 
        call QUICK_SORT 
    
        
        @IS_BIGGER:                 ;WHEN SORT IS DONE.
          RET 
        
                
     @ENDSORT:                    ; ENDSORT label                                      
      LEA DX, msg9                ; load and display the string PROMPT_6 
      MOV AH, 9                   ; AH value for dos interrupt output a message
      INT 21H           
      LEA SI, ARRAY               ; set SI=offset address of ARRAY
      POP BP                      ; pop a value from STACK into BX
      call DISPLAY_ARRAY            ; call the procedure PRINT_ARRAY
      LEA DX, msg10               ; load and display the string PROMPT_7 
      MOV AH, 9                   ; AH value for dos interrupt output a message
      INT 21H
      CALL DISPLAY_ARRAY_REVERSE    ; call the procedure PRINT_ARRAY_REVERSE
      MOV AH, 4CH                 ; return control to DOS
      INT 21H
      RET 
 validation_check ENDP
partition proc

                                  ;GET X = ARR[ R ].
            LEA SI, ARRAY
            mov  ax, r
            shl  ax, 1            ;R * 2, BECAUSE EVERY COUNTER IS 2 BYTES.
            add  si, ax
            mov  ax, [ si ]       
            mov  x,  ax           ;X = ARR[ R ].              
            mov  ax, p            ;GET I = P - 1.
            mov  i,  ax
            dec  i
                 
            mov  ax, p            ;INITIALISE J WITH P.
            mov  j,  ax

       @for_j:                    ;LOOP J FROM P TO R-1.
                 
            LEA SI, ARRAY         ;GET ARR[ J ].
            mov  ax, j
            shl  ax, 1            ;J * 2, BECAUSE EVERY COUNTER IS 2 BYTES.
            add  si, ax
            mov  ax, [ si ]       ;AX = ARR[ J ]

            cmp  ax, x            ;COMPARE A[ J ] WITH X.
            jg   @GREATER          ;IF A[ J ] > X, NO SWAP
    
            inc  i                ;GET I = I + 1.
            ;GET ARR[ I ].
                LEA  di, ARRAY
                mov  cx, i
                shl  cx, 1              ;I * 2, BECAUSE EVERY COUNTER IS 2 BYTES.
                add  di, cx
                mov  cx, [ di ]         ;CX = ARR[ I ].

                ;EXCHANGE ARR[ I ] WITH ARR[ J ].
                mov  [ di ], ax
                mov  [ si ], cx
            
                ;GET NEXT J.
               @GREATER:

                    inc  j              ;J = J + 1.
                    mov  ax, r
                    cmp  j,  ax         ;COMPARE J WITH R.
                    jl   @for_j          ;IF J = R-1 CONTINUE LOOP.

            ;GET ARR[ i+1 ].
            inc  i
            LEA  si, ARRAY
            mov  ax, i
            shl  ax, 1                  ;(I+1) * 2, BECAUSE EVERY COUNTER IS 2 BYTES.
            add  si, ax
            mov  ax, [ si ]             ;AX = ARR[ I+1 ].

            ;GET ARR[ R ].
            LEA  di, ARRAY
            mov  cx, r
            shl  cx, 1                  ;R * 2, BECAUSE EVERY COUNTER IS 2 BYTES.
            add  di, cx
            mov  cx, [ di ]             ;CX = ARR[ R ].

            ;EXCHANGE ARR[ I+1 ] WITH ARR[ R ].
            mov  [ di ], ax
            mov  [ si ], cx  

            ;RETURN I+1.
            mov  ax, i
            ret
partition endp   


Get_Size PROC		; function to take array size from user (must be positive number from 0 to 255)
        
    
   PUSH BX                        ; push BX in the STACK0
   PUSH CX                        ; push CX in the STACK
   PUSH DX                        ; push DX in the STACK
   

   JMP Label_READ1                     ; jump to label Label_READ
   Label_SKIP_BACKSPACE1:              ; SKIP_BACKSPACE1 label
   MOV AH, 2                      ; output function
   MOV DL, 20H                    ; DL=' ' (space)
   INT 21H                        ; print a character
   Label_READ1:                        ; READ1 label

   XOR BX, BX                     ; clear BX
   XOR CX, CX                     ; clear CX
   XOR DX, DX                     ; clear DX
   MOV AH, 1                      ; input function
   INT 21H                        ; read input
 
 CMP AL, "-"                    ; compare AL with "-"
 ;INC CL
 JE Label_ERROR2                     ; jump to label Label_ERROR2 if AL="-"
 CMP AL, "+"                    ; compare AL with "+"
 JE Label_PLUS1                      ; jump to label Label_PLUS if AL="+"
 JMP Label_SKIP_INPUT1               ; jump to label Label_SKIP_INPUT
Label_PLUS1:                        ; PLUS1 label
  MOV CH, 2                      ; set CH=2
  INC CL                         ; set CL=CL+1
  Label_INPUT1:                       ; jump label
  MOV AH, 1                    ; set input function
  INT 21H                      ; read a character
Label_SKIP_INPUT1:                ; jump label

  CMP AL, 0DH                    ; compare AL with enter

JE Label_END_INPUT1               ; jump to label Label_END_INPUT
     CMP AL, 8H                   ; compare AL with 8H
     JNE Label_NOT_BACKSPACE1          ; jump to label Label_NOT_BACKSPACE if AL!=8
     CMP CH, 0                    ; compare CH with 0
     JNE Label_CHECK_REMOVE_PLUS1      ; jump to label Label_CHECK_REMOVE_MINUS if CH!=0
     CMP CL, 0                    ; compare CL with 0
     JE Label_SKIP_BACKSPACE1          ; jump to label Label_SKIP_BACKSPACE if CL=0
     JMP Label_MOVE_BACK1              ; jump to label Label_MOVE_BACK
     CMP CL, 1                    ; compare CL with 1
     JE Label_REMOVE_PLUS1             ; jump to label Label_REMOVE_PLUS_MINUS if CL=1
     Label_CHECK_REMOVE_PLUS1:         ; jump label
     CMP CL, 1                    ; compare CL with 1
     JE Label_REMOVE_PLUS1             ; jump to label Label_REMOVE_PLUS_MINUS if CL=1
     JMP Label_MOVE_BACK1              ; jump to label Label_MOVE_BACK
     Label_REMOVE_PLUS1:               ; jump label
       MOV AH, 2                  ; set output function
       MOV DL, 20H                ; set DL=' '
       INT 21H                    ; print a character
       MOV DL, 8H                 ; set DL=8H
       INT 21H                    ; print a character
       JMP Label_READ1                 ; jump to label Label_READ
                                  
     Label_MOVE_BACK1:                 ; MOVE_BACK1 label
     MOV AX, BX                   ; set AX=BX
     MOV BX, 10                   ; set BX=10
     DIV BX                       ; set AX=AX/BX
     MOV BX, AX                   ; set BX=AX
     MOV AH, 2                    ; set output function
     MOV DL, 20H                  ; set DL=' '
     INT 21H                      ; print a character
     MOV DL, 8H                   ; set DL=8H
     INT 21H                      ; print a character
     XOR DX, DX                   ; clear DX
     DEC CL                       ; set CL=CL-1
     JMP Label_INPUT1                  ; jump to label Label_INPUT
     Label_NOT_BACKSPACE1:             ; jump label
     INC CL                       ; set CL=CL+1
     CMP AL, 30H                  ; compare AL with 0
     JL Label_ERROR1                   ; jump to label Label_ERROR if AL<0
     CMP AL, 39H                  ; compare AL with 9
     JG Label_ERROR1                   ; jump to label Label_ERROR if AL>9
     AND AX, 000FH                ; convert ascii to decimal code
     PUSH AX                      ; push AX onto the STACK
     MOV AX, 10                   ; set AX=10
     MUL BX                        ; set AX=AX*BX
     
     MOV BX, AX                   ; set BX=AX
     POP AX                       ; pop a value from STACK into AX
     ADD BX, AX                   ; set BX=AX+BX        
     JS Label_ERROR1                   ; jump to label Label_ERROR if SF=1
     CMP BX,255                           ;///////////////////////////////////////////////////////////////////////
     JA Label_if_more_255                  ;////////////////////////////////////////
     
   JMP Label_INPUT1                    ; jump to label Label_INPUT

 Label_ERROR1:                       ; jump label
   MOV AH, 2                      ; output function
   MOV DL, 7H                     ; DL=7H
   INT 21H                        ; print a character
   XOR CH, CH                     ; clear CH
    Label_ERROR2:                      ; jump label
   LEA DX, msg3
   MOV AH, 9
   INT 21H
   JMP Label_READ1                         
 Label_if_more_255:                    ;////////////////////////////////////
   ; pop ax                            ;'''''///////////////////////////
    LEA DX, msg14
   MOV AH, 9
   INT 21H
   JMP Label_READ1
 
Label_CLEAR1:                       ; jump label
     MOV DL, 8H                   ; set DL=8H   (backspace in ascii)
     INT 21H                      ; print a character
     MOV DL, 20H                  ; set DL=' '         (Space in ascii)
     INT 21H                      ; print a character
     MOV DL, 8H                   ; set DL=8H          (backspace in ascii)
     INT 21H                      ; print a character
   LOOP Label_CLEAR1                   ; jump to label Label_CLEAR if CX!=0

   jmp Label_READ1

Label_END_INPUT1:                   ; jump label
   CMP CH, 1                      ; compare CH with 1   
   JNE Label_EXIT1                     ; jump to label Label_EXIT if CH!=1
   NEG BX                         ; negate BX
   Label_EXIT1:                        ; jump label

   MOV AX, BX                     ; AX=BX
   POP DX                         ; pop from STACK to DX
   POP CX                         ; pop from STACK to CX
   POP BX                         ; pop from STACK to BX
   RET                            ; return to CALL 
   Get_Size ENDP   



GET_ARRAY PROC ; to get array elements size in BX , address of ARRAY[0] in SI

   PUSH AX                        ; push AX in the STACK
   PUSH CX                        ; push CX in the STACK
   PUSH DX                        ; push DX in the STACK
   
   MOV CX, BX                     ;  CX=BX
   Label_GET_ARRAY:               ; loop label
     CALL ASCI_2_DECIMAL         ; call  ASCII_2_DECIMAL
     MOV [SI], AX                 ; put [SI]=AX
     ADD SI, 2                    ; SI=SI+2
     MOV DL, 0AH                  ; new line
     MOV AH, 2                    ; for print 
     INT 21H                      ; print a character
   LOOP Label_GET_ARRAY           ; jump to label --> Label_GET_ARRAY while CX!=0
   POP DX                         ; pop  from STACK to DX
   POP CX                         ; pop  from STACK to CX
   POP AX                         ; pop  from STACK to AX
   RET                            ; return to CALL
   GET_ARRAY ENDP






 ASCI_2_DECIMAL PROC
  
 

   PUSH BX                        ; push BX in the STACK
   PUSH CX                        ; push CX in the STACK
   PUSH DX                        ; push DX in the STACK
   
  
JMP Label_READ                    ; jump to label Label_READ 
 Label_SKIP_BACKSPACE:            ; label
   MOV AH, 2                      ; output function
   MOV DL, 20H                    ; put DL=' '
   INT 21H                        ; print 

 Label_READ:                      ; jump label
   XOR BX, BX                     ; BX = 0
   XOR CX, CX                     ; CX = 0
   XOR DX, DX                     ; DX = 0
   MOV AH, 1                      ; input function
   INT 21H                        ; read a character
   CMP AL, "-"                    ; compare AL with "-"
   JE Label_MINUS                 ; jump to Label_MINUS if AL="-"

   CMP AL, "+"                    ; compare AL with "+"
   JE Label_PLUS                  ; jump to Label_PLUS if AL="+"
   JMP Label_SKIP_INPUT           ; jump to Label_SKIP_INPUT
   Label_MINUS:                   ; jump label
   MOV CH, 1                      ; set CH=1
   INC CL                         ; CL = CL + 1
   JMP Label_INPUT                ; jump to Label_INPUT
 
 Label_PLUS:                      ; jump label
   MOV CH, 2                      ; put CH=2
   INC CL                         ; CL=CL+1
   
Label_INPUT:                      ; jump label
   MOV AH, 1                      ; input function
   INT 21H                        ; read a character

Label_SKIP_INPUT:                 ; jump label
   CMP AL, 0DH                    ; compare AL with CR (if i entered enter button)
   JE Label_END_INPUT             ; jump to Label_END_INPUT
   CMP AL, 8H                     ; compare AL with 8H
   JNE Label_NOT_BACKSPACE        ; jump to Label_NOT_BACKSPACE if AL!=8
   CMP CH, 0                      ; compare CH with 0
   JNE Label_CHECK_REMOVE_MINUS   ; jump to Label_CHECK_REMOVE_MINUS if CH!=0
   CMP CL, 0                      ; compare CL with 0
   JE Label_SKIP_BACKSPACE        ; jump to Label_SKIP_BACKSPACE if CL=0
   JMP Label_MOVE_BACK            ; jump to Label_MOVE_BACK                   
   

Label_CHECK_REMOVE_MINUS:         ; jump label
   CMP CH, 1                      ; compare CH with 1
   JNE Label_CHECK_REMOVE_PLUS    ; jump to Label_CHECK_REMOVE_PLUS if CH!=1
   CMP CL, 1                      ; compare CL with 1
   JE Label_REMOVE_PLUS_MINUS     ; jump to Label_REMOVE_PLUS_MINUS if CL=1
Label_CHECK_REMOVE_PLUS:          ; jump label
   CMP CL, 1                      ; compare CL with 1
   JE Label_REMOVE_PLUS_MINUS     ; jump to Label_REMOVE_PLUS_MINUS if CL=1
   JMP Label_MOVE_BACK            ; jump to Label_MOVE_BACK

Label_REMOVE_PLUS_MINUS:          ; jump label
       MOV AH, 2                  ; set output function
       MOV DL, 20H                ; set DL=' '
       INT 21H                    ; print a character
       MOV DL, 8H                 ; set DL=8H
       INT 21H                    ; print a character
       JMP Label_READ             ; jump to label Label_READ
                                  
     Label_MOVE_BACK:             ; jump label
     MOV AX, BX                   ; set AX=BX
     MOV BX, 10                   ; set BX=10
     DIV BX                       ; set AX=AX/BX
     MOV BX, AX                   ; set BX=AX
     MOV AH, 2                    ; set output function
     MOV DL, 20H                  ; set DL=' '
     INT 21H                      ; print a character
     MOV DL, 8H                   ; set DL=8H
     INT 21H                      ; print a character
     XOR DX, DX                   ; clear DX
     DEC CL                       ; set CL=CL-1
     JMP Label_INPUT              ; jump to label Label_INPUT
     Label_NOT_BACKSPACE:         ; jump label
     INC CL                       ; set CL=CL+1 (count the num of numbers )
     CMP AL, 30H                  ; compare AL with 0
     JL Label_ERROR               ; jump to label Label_ERROR if AL<0
     CMP AL, 39H                  ; compare AL with 9
     JG Label_ERROR               ; jump to label Label_ERROR if AL>9
     AND AX, 000FH                ; convert ascii to decimal code
     PUSH AX                      ; push AX onto the STACK
     MOV AX, 10                   ; set AX=10
     MUL BX                       ; set AX=AX*BX
     MOV BX, AX                   ; set BX=AX
     POP AX                       ; pop a value from STACK into AX
     ADD BX, AX                   ; set BX=AX+BX
     JS Label_ERROR               ; jump to label Label_ERROR if SF=1
   JMP Label_INPUT                ; jump to label Label_INPUT

Label_ERROR:                      ; jump label
     MOV AH, 2                    ; set output function
     MOV DL, 7H                   ; put DL=7H
     INT 21H                      ; print a character
     XOR CH, CH                   ; clear CH
Label_CLEAR:                      ; jump label(if user entered 6 numbers , it will clear all)(MAX num of numbers = 5)
     MOV DL, 8H                   ; put DL=8H (backspace in ascii)
     INT 21H                      ; print a character
     MOV DL, 20H                  ; put DL=' '    (Space in ascii)
     INT 21H                      ; print a character
     MOV DL, 8H                   ; put DL=8H          (backspace in ascii)
     INT 21H                      ; print a character
     LOOP Label_CLEAR             ; jump to  Label_CLEAR if CX!=0
     JMP Label_READ               ; jump to  Label_READ
Label_END_INPUT:                  ; jump label
     CMP CH, 1                    ; compare CH with 1   
     JNE Label_EXIT               ; jump to  Label_EXIT if CH!=1
     NEG BX                       ; negate BX
Label_EXIT: 
  MOV AX, BX                      
   POP DX                         ; pop  from STACK into DX
   POP CX                         ; pop  from STACK into CX
   POP BX                         ; pop  from STACK into BX
   
RET   
                                  ; return control to the calling procedure
 
ASCI_2_DECIMAL ENDP


DECIMAL_2_ASCII PROC

   PUSH BX                        ; push BX into the STACK
   PUSH CX                        ; push CX into the STACK
   PUSH DX                        ; push DX into the STACK

   CMP AX, 0                      ; compare AX with 0
   JGE LABEL_START                     ; jump to label @START if AX>=0

   PUSH AX                        ; push AX into the STACK

   MOV AH, 2                      ; set output function
   MOV DL, "-"                    ; set DL='-'
   INT 21H                        ; print the character

   POP AX                         ; pop a value from STACK into AX

   NEG AX                         ; take 2's complement of AX

   LABEL_START:                        ; jump label

   XOR CX, CX                     ; clear CX
   MOV BX, 10                     ; set BX=10

   
   LABEL_OUTPUT:                       ; loop label
     XOR DX, DX                   ; clear DX
     DIV BX                       ; divide AX by BX
     PUSH DX                      ; push DX onto the STACK
     INC CX                       ; increment CX
     OR AX, AX                    ; take OR of Ax with AX
   JNE LABEL_OUTPUT                    ; jump to label @OUTPUT if ZF=0

   MOV AH, 2                      ; set output function

   PRINT:                      ; loop label
     POP DX                       ; pop a value from STACK to DX
     OR DL, 30H                   ; convert decimal to ascii code
     INT 21H                      ; print a character
   LOOP PRINT                  ; jump to label @PRINT(DISPLAY) if CX!=0


   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP BX                         ; pop a value from STACK into BX

   RET                            ; return control to the calling procedure
 DECIMAL_2_ASCII ENDP


DISPLAY_ARRAY PROC 		  ; function to display array elements	, address of ARRAY[0] in SI , size in BX 
  
   
   PUSH AX                        ; push AX in the STACK   
   PUSH CX                        ; push CX in the STACK
   PUSH DX                        ; push DX in the STACK

   MOV CX, BP                     ;  CX=BX
   LABEL_PRINT_ARRAY:             ; loop label
     XOR AH, AH                   ; AH = 0
     MOV AX, [SI]                 ; AL=[SI]
     CALL DECIMAL_2_ASCII         ; call DECIMAL_2_ASCII
     MOV AH, 2                    ; output function
     MOV DL, 20H                  ; DL=20H (space)
     INT 21H                      ; print 

     ADD SI,2			  ; SI = SI + 2
   LOOP LABEL_PRINT_ARRAY         ; jump to LABEL_PRINT_ARRAY while CX!=0
   POP DX                         ; pop  from STACK into DX
   POP CX                         ; pop  from STACK into CX
   POP AX                         ; pop  from STACK into AX

   RET                            ; return control to the calling procedure
 DISPLAY_ARRAY ENDP
 
 DISPLAY_ARRAY_REVERSE PROC
    ; this procedure will print reverse the elements of a given array(Descending order)
   ; input : SI=offset address of the array
   ;       : BX=size of the array  
   ; output : none 
   PUSH AX                        ; push AX onto the STACK   
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK 
   LEA SI,ARRAY                    
   MOV CX,BP
   MOV BX,BP                      ; set CX=BX
   MOV DI,SI                      ; set DI=SI
   SUB BX,1                       ; set bx=bx-1 
   ADD BX,BX                      ; BX=BX*2
   ADD SI,BX                      ; set SI=BX
   @DISPLAY_ARRAY_REVERSE:          ; loop label
     XOR AH, AH                   ; clear AH
     MOV AX, [SI]                 ; set AL=[SI]
     CALL DECIMAL_2_ASCII                  ; call the procedure OUTDEC
     MOV AH, 2                    ; set output function
     MOV DL, 20H                  ; set DL=20H
     INT 21H                      ; print a character
     DEC SI                       ; set SI=SI-2
     DEC SI  
   LOOP @DISPLAY_ARRAY_REVERSE      ; jump to label @PRINT_ARRAY while CX!=0
   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP AX                         ; pop a value from STACK into AX
   RET                            ; return control to the calling procedure   
  
 DISPLAY_ARRAY_REVERSE ENDP

END MAIN
