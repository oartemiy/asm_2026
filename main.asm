%include "io.inc"

section .bss
a resd 1

section .text
global main
main:
    GET_DEC 4, [a]
    mov eax, [a]
    
    mov ebx, eax
    sar ebx, 31 ; signed shift, shl - unsigned shift
    ; sar: 10000...1 -> 11111....1000

    xor eax, ebx
    sub eax, ebx

    mov [a], eax

    PRINT_DEC 4, [a]
    NEWLINE

    xor eax, eax
    ret