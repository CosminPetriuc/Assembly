bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; B7. A string of doublewords T is given. Compute string R containing only high bytes from high words from each doubleword from string S.

    ;If S = 12345678h, 1a2b3c4dh => D = 12h, 1ah
    s dd 12345678h, 1a2b3c4dh 
    ls equ ($-s)/4 ; 1 doubleword = 4 bytes
    r resw ls ; Result array
    
; our code starts here
segment code use32 class=code
    start:
        mov esi, 0 ; Index for source string S
        mov edi, 0 ; Index for destination string R
        mov ecx, ls ; Number of doublewords

    repeta:
        mov eax, [s + esi] ; Load a doubleword from S into eax
        shr eax, 16 ; Shift right to get the high word
        and eax, 0FF00h ; Mask to keep only the high byte

        cmp eax, 12h ; Compare with 12h
        jne NEXT ; Jump to NEXT if not equal

        ; If equal, store the doubleword in R
        mov [r + edi], eax
        add edi, 4 ; Move to the next position in R (4 bytes per doubleword)

    NEXT:
        add esi, 4 ; Move to the next doubleword in S
        loop repeta ; Repeat for the next doubleword
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
