bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;declarare variabile
    a dw 7
    b db 6
    c dw 3
    d db 4
    ; e = a-b+7-(c+d)
    
    
    

; our code starts here
segment code use32 class=code
    start:
        ;e = a-b+7-(c+d)
        ;a-b
        ;word - byte
        ;b trebuie sa devina word
        mov bl, [b]
        ;[] pentru a accesa valoarea unei variabile
        ;bx = bh|bl
        mov bh, 0
        ;bx = b
        mov ax, [a]
        sub ax, bx; ax = a - b
        
        
        add ax, 7; ax = 1+7
        
        ; c+d
        ;word + byte
        ;d trebuie sa devina word
        mov dl, [d]
        ;[] pentru a accesa valoarea unei variabile
        ;dx = dh|dl
        mov dh, 0 
        ; dx = d
        add dx , [c] ; dx = 3 + 4
        
        sub ax, dx; e = 8-7
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
