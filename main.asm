extern printf, scanf

section .data
    fmt_input_triple db "%lf %lf %lf", 0
    fmt_input_n_s db "%d %lf", 0
    fmt_output_idx db "%d", 10, 0
    fmt_double db "%lf", 10, 0
    double_two dq 2.0

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

    xor esi, esi
.Lfor_begin:
    cmp esi, dword [n]

    je .Lfor_end

    push y
    push b
    push a
    push fmt_input_triple
    call scanf
    add esp, 16

    fld qword[y]
    fsin
    fmul qword[a]
    fmul qword[b]
    fdiv qword[double_two]

    fld qword[s]
    fcomip st0, st1
    fstp qword[result]

    ; no pop no push nothing, that chages eflags

    jbe .Lprint
    jmp .Lskip


.Lprint:
    push esi
    push fmt_output_idx
    call printf
    add esp, 8

    
.Lskip:
    inc esi
    jmp .Lfor_begin

.Lfor_end:

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret