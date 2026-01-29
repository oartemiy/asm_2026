%include "io.inc"

section .text
global main
main:
    GET_UDEC 4, eax
    GET_UDEC 4, ebx

    ror dword eax, [ebx]

    PRINT_UDEC 4, eax
    NEWLINE
    xor eax , eax
    ret