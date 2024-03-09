bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...200/b-c/(d+1)+e; a,b-word; c,d-byte; e-doubleword;
    a dw 0
    b dw 10
    c db 8
    d db 10
    e dd 23
    
   

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax, 200; move in ax register 200
        cwd; ax->dx:ax
        mov bx, [b]; move in bx register bx
       idiv bx; dx:ax/bx = ax- cat, dx- rest
       ;salvare ax in bx
       mov bx, ax
        
        
        mov al, [c]
        movsx ax, al
        mov cl, [d]
        add cl, 1
        idiv cl;al-cat, ah -rest 
        
        ;200/b-c/(d+1)+e;
        ;bx-al+dd
        ;bx-al
        ;al->ax
        movsx ax, al
        sub bx, ax
        movsx ebx, bx
        add ebx, [e]
        
        
        
        
        
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
