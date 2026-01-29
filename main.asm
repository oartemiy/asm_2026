%include "io.inc"

section .text
global main
main:
    push ebp
    mov ebp, esp
    sub esp, 12

    GET_DEC 4, [ebp - 4] ; a
    GET_DEC 4, [ebp - 8] ; b

    sub [ebp - 4], dword 1

    mov eax, [ebp - 4]

    imul eax, dword 41

    mov [ebp - 12], eax

    mov edx, 0
    mov eax, [ebp - 4]
    mov ebx, 2

    div ebx

    add eax, [ebp - 12]
    add eax, [ebp - 8]

    PRINT_DEC 4, eax
    NEWLINE

    xor eax, eax
    leave
    ret