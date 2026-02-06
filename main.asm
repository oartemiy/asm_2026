%include "io.inc"

section .bss
a11 resd 1
a12 resd 1
a21 resd 1
a22 resd 1
b1 resd 1
b2 resd 1
x resd 1
y resd 1
m00 resd 1
m01 resd 1
m10 resd 1
m11 resd 1
s00 resd 1
s01 resd 1
s10 resd 1
s11 resd 1

section .text
global main
main:
    GET_UDEC 4, [a11]
    GET_UDEC 4, [a12]
    GET_UDEC 4, [a21]
    GET_UDEC 4, [a22]
    GET_UDEC 4, [b1]
    GET_UDEC 4, [b2]

    mov eax, dword [b1]
    not eax
    mov ebx, dword [b2]
    not ebx
    and eax, ebx
    mov dword [m00], eax

    mov eax, dword [a12]
    xor eax, dword [b1]
    not eax
    mov ebx, dword [a22]
    xor ebx, dword [b2]
    not ebx
    and eax, ebx
    mov dword [m01], eax

    mov eax, dword [a11]
    xor eax, dword [b1]
    not eax
    mov ebx, dword [a21]
    xor ebx, dword [b2]
    not ebx
    and eax, ebx
    mov dword [m10], eax

    mov eax, dword [a11]
    xor eax, dword [a12]
    xor eax, dword [b1]
    not eax
    mov ebx, dword [a21]
    xor ebx, dword [a22]
    xor ebx, dword [b2]
    not ebx
    and eax, ebx
    mov dword [m11], eax

    mov eax, dword [m00]
    mov dword [s00], eax

    mov eax, dword [m00]
    not eax
    and eax, dword [m01]
    mov dword [s01], eax

    mov eax, dword [m00]
    not eax
    mov ebx, dword [m01]
    not ebx
    and eax, ebx
    and eax, dword [m10]
    mov dword [s10], eax

    mov eax, dword [m00]
    not eax
    mov ebx, dword [m01]
    not ebx
    and eax, ebx
    mov ebx, dword [m10]
    not ebx
    and eax, ebx
    and eax, dword [m11]
    mov dword [s11], eax

    mov eax, dword [s10]
    or eax, dword [s11]
    mov dword [x], eax

    mov eax, dword [s01]
    or eax, dword [s11]
    mov dword [y], eax

    PRINT_UDEC 4, [x]
    PRINT_CHAR ' '
    PRINT_UDEC 4, [y]
    NEWLINE

    xor eax, eax
    ret