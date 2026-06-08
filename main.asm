extern printf, scanf

section .data
    fmt_input_triple db "%lf %lf %lf", 0
    fmt_input_n_s db "%d %lf", 0
    fmt_output_idx db "%d", 10, 0
    fmt_double db "%lf", 10, 0

section .bss
    n resd 1
    s resq 1
    a resq 1
    b resq 1
    y resq 1
    result resq 1

section .text
global main
main:
    push ebp
    mov ebp, esp

    push s
    push n
    push fmt_input_n_s
    call scanf
    add esp, 12

    xor ecx, ecx
.Lfor_begin:
    cmp ecx, dword [n]

    je .Lfor_end

    push ecx

    push y
    push b
    push a
    push fmt_input_triple
    call scanf
    add esp, 16

    fld qword[a]
    fld qword[b]
    fmulp
    fld qword[y]
    fsin
    fmulp
    fld qword[s]
    fcomip st0, st1
    fstp qword[result]

    jbe .Lprint
    pop ecx
    jmp .Lskip


.Lprint:
    pop ecx
    push ecx
    push fmt_output_idx
    call printf
    add esp, 4
    pop ecx

    

.Lskip:
    inc ecx
    jmp .Lfor_begin

.Lfor_end:
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret