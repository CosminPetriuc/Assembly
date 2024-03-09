bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 3. if a >= (12-c) then e = c/7 else e = (a+3)*2 – c
        a db 5 ;byte
        b dw 4 ;word
        c dw 6 ;word
        d db 2 ;byte
        e dd 7 ;doubleword
        f db 1 ;byte
; our code starts here
segment code use32 class=code
    start:
        ;Compare a with (12- c)
        mov al, [c]
        sub al, 12
        cmp al, [a]
        jae greater_then_or_equal
        
        ;If a < (12-c), calculate e = (a+3)*2-c
        movzx eax, byte [a]
        add eax, 3
        shl eax, 1
        sub eax, [c]
        mov [e], eax
        jmp end_if
        
    greater_then_or_equal:
        ;If a >= (12 -c), calculate e = c/7
        movzx eax, word [c]
        mov edx, 0
        mov ecx, 7
        div ecx
        mov [e], eax
    end_if:
        ;Output the result (e) to demonstrate the calculation
        mov eax, 4      ;syscall number for write
        mov ebx, 1      ;file descriptor 1 (stdout)
        mov ecx, [e]    ;address of the doubleword e
        mov edx, 4      ;number of bytes to write
        int 0x80        ;call kernel
        
        ;Exit the program
        mov eax, 1      ;syscall number for exit
        xor ebx, ebx    ;exit code 0
        int 0x80        ;call kernel   
      