extern scanf, printf, malloc, free

section .data
    iformat db `%d`, 0
    oformat db `%d `, 0
    space db ` `, 0
    newline db 10, 0

section .bss
    ans_trace resq 1
    ans_arr resd 1
    tmp_trace resq 1
    tmp_arr resd 1
    ans_M resd 1
    N resd 1
    M resd 1
    temp_M resd 1

section .text
global main
main:
    push ebp
    mov ebp, esp
    and esp, -16

    push N
    push iformat
    call scanf
    add esp, 8

    xor esi, esi
.Lfor_begin:
    cmp esi, dword [N]
    je .Lfor_end

    push esi
    push M
    push iformat
    call scanf
    add esp, 8
    pop esi

    mov eax, dword [M]
    mov dword [temp_M], eax
    imul eax, eax
    mov dword [M], eax
    imul eax, dword 4

    push eax
    call malloc
    add esp, 4
    mov dword [tmp_arr], eax
    mov edi, eax
    xor ecx, ecx
.Lread_begin:
    cmp ecx, dword [M]
    je .Lread_end
    push ecx
    push edi
    push iformat
    call scanf
    add esp, 8
    pop ecx
    add edi, 4
    inc ecx
    jmp .Lread_begin
.Lread_end:

    xor ecx, ecx
    mov edi, dword [tmp_arr]
    mov dword [tmp_trace], 0
    mov dword [tmp_trace+4], 0
.Ltrace_calc_begin:

    cmp ecx, dword [M]
    jge .Ltrace_calc_end
    mov eax, dword [edi + 4*ecx]
    cdq
    add dword [tmp_trace], eax
    adc dword [tmp_trace+4], edx ; with carry flag
    add ecx, dword [temp_M]
    inc ecx
    jmp .Ltrace_calc_begin
.Ltrace_calc_end:

    cmp esi, 0
    jne .Lno_first

    mov eax, dword [tmp_trace]
    mov edx, dword [tmp_trace+4]
    mov dword [ans_trace], eax
    mov dword [ans_trace+4], edx
    mov eax, dword [tmp_arr]
    mov dword [ans_arr], eax
    mov eax, dword [temp_M]
    mov dword [ans_M], eax
    inc esi
    jmp .Lfor_begin

.Lno_first:
    mov eax, dword [tmp_trace]
    mov edx, dword [tmp_trace+4]
    cmp edx, dword [ans_trace+4]
    jl .Lfree
    je .Lequal

    push dword [ans_arr]
    call free
    add esp, 4
    mov eax, dword [tmp_arr]
    mov dword [ans_arr], eax
    mov eax, dword [tmp_trace]
    mov edx, dword [tmp_trace+4]
    mov dword [ans_trace], eax
    mov dword [ans_trace+4], edx
    mov eax, dword [temp_M]
    mov dword [ans_M], eax
    inc esi
    jmp .Lfor_begin

.Lequal:
    cmp eax, dword [ans_trace]
    jbe .Lfree ; eax - unsigned part of tmp_trace
    push dword [ans_arr]
    call free
    add esp, 4
    mov eax, dword [tmp_arr]
    mov dword [ans_arr], eax
    mov eax, dword [tmp_trace]
    mov edx, dword [tmp_trace+4]
    mov dword [ans_trace], eax
    mov dword [ans_trace+4], edx
    mov eax, dword [temp_M]
    mov dword [ans_M], eax
    inc esi
    jmp .Lfor_begin

.Lfree:
    push dword [tmp_arr]
    call free
    add esp, 4
    inc esi
    jmp .Lfor_begin

.Lfor_end:

    xor ecx, ecx
    mov edi, dword [ans_arr]
.Lprint_begin_1:
    cmp ecx, dword [ans_M]
    je .Lprint_end_1
    push ecx
    xor ecx, ecx
.Lprint_begin_2:
    cmp ecx, dword [ans_M]
    je .Lprint_end_2
    push ecx
    push dword [edi]
    push oformat
    call printf
    add esp, 8
    pop ecx
    add edi, 4
    inc ecx
    jmp .Lprint_begin_2
.Lprint_end_2:
    push newline
    call printf
    add esp, 4
    pop ecx
    inc ecx
    jmp .Lprint_begin_1
.Lprint_end_1:

    push dword [ans_arr]
    call free
    add esp, 4

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret