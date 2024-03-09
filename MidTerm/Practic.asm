bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 11.(-12+c)-d/a
    a db 1
    b dw 2
    c db 3
    d dd 4

; our code starts here
segment code use32 class=code
    start:
        ; (-12+c)
        mov ax, 12
        mov bx, byte[c]
        add bx, ax
        
        ;d/a
        movsx eax, byte[a]
        mov ecx, dword[d]
        cdq 
        idiv ecx;
        
        ;(-12+c)-d/a
        movsx ebx, bx
        sub eax, ebx;
        
        
        ;a diff word
        ;c diff word
        movzx ax, word[a]
        
        mov bx, word[c]
        ;dx:ax/ cx:bx 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
