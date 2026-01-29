%include "io.inc"

section .text
global main
main:
    GET_UDEC 4, eax
    GET_UDEC 4, ecx

    ror eax, cl

    PRINT_UDEC 4, eax
    NEWLINE
    
    xor eax , eax
    ret