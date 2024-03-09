bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; declare variables
    a db 10
    b dw 5
    ; fara semn

; our code starts here
segment code use32 class=code
    start:
        ; codul care solutioneaza o problema 
        ; adunarea add opd, ops;
                               ;opd = opd+ops
                               ;restrictii:
                                    ;1. ops nu poate fi constanta 
                                    ;2. opd, ops sa fie de aceasi dimensiune (acelasi tip de data)
                                    ;3. cel putin un operand sa fie reg sau constanta
                                    ;add 3,4 - nu se poate
                                    ;add 5, al - nu se poate
        ;e = a + b
        ; a trebuie sa fie word
        mov al, [a]
        ;[] pentru a acesa valoarea unei variabile
        ;ax = ah|al
        mov ah, 0
        ;ax = a 
        add ax, [b] 
        ;ax = 10 + 5
        
        ;scadere sub opd, ops
        ;opd = opd-ops
        ;restrictii:
                        ;1. opd nu poate fi constanta
                        ;2. opd, ops sa fie de aceasi dimensiune(acelasi tip de data)
                        ;3. cel putin un operand sa fie reg sau constanta
                        
        ; a + b = ax
            ; -c
            ; ax - c
            ;word - doubleword
            ;16 biti - 32 biti
            ; ax trebuie sa devina doubleword
        ; movzx op1, op2
        ; op1 se completeaza la stanga cu valoarea 0 prin extinderea op2 la dim opl
        ; op1 este intotdeauna de dim mai mare decat op2
        ; op1 este intotdeauna registru
        ; op2 poate sa fie registru sau variabia ( nu poate sa fie constanta)
        
        ;extindem ax la eax folosind movzx
        movzx eax, ax; se completeaza partea high a lui eax cu valoarea 0
        
        sub eax, [c];eax = eax - c
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
