bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;A3. A string of bytes A is given. Construct string B such that each element from B represent the remainder for the division of two consecutive elements from string A.

    ;If A = 16, 8, 3 => B = 0, 2
     A db 16, 8, 3    ; Define array A

; our code starts here
segment code use32 class=code
    start:
        mov ecx, 0       ; Initialize loop counter

    compute_remainders:
        mov al, [A + ecx]   ; Load the current element from A into al
        mov bl, [A + ecx + 1] ; Load the next element from A into bl

        xor ah, ah          ; Clear ah register for division
        div bl              ; Divide al by bl, result in al, remainder in ah

        mov [B + ecx], ah   ; Store the remainder in B

        inc ecx             ; Move to the next pair of elements in A

        cmp ecx, 2          ; 3 elements - 1
        jl compute_remainders  ; If ecx < 2, continue looping

        ; Terminate the program using exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

    section .bss
        B resb 2          ; Reserve space for array B