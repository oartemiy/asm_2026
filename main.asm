%include "io.inc"

section .bss
N resd 1
M resd 1
K resd 1
A resd 10000
B resd 10000
C resd 10000
cur_res resd 1

section .text
global main
main:
    GET_UDEC 4, [N]
    GET_UDEC 4, [M]
    GET_UDEC 4, [K]
    mov ecx, dword 0
    mov eax, dword[N]
    mul dword[M]
input_A_begin:
    cmp ecx, eax
    jz input_A_end
    GET_DEC 4, [A + 4 * ecx]
    inc ecx
    jmp input_A_begin
input_A_end:
    mov ecx, dword 0
    mov eax, dword [M]
    mul dword [K]
input_B_begin:
    cmp ecx, eax
    jz input_B_end
    GET_DEC 4, [B + 4 * ecx]
    inc ecx
    jmp input_B_begin
input_B_end:
    mov eax, dword 0 ; i
    mov ebx, dword 0 ; j
    mov ecx, dword 0 ; k
    mov dword[cur_res], dword 0
; DOTO: movsx
multiply_begin_1:
    cmp eax, dword [N]
    jz multiply_end_1
    push eax
    imul eax, dword [M]
    imul eax, dword 4
    multiply_begin_2:
        cmp ebx, dword [K]
        jz multiply_end_2

        multiply_begin_3:
            cmp ecx, dword [M]
            jz multiply_end_3
            mov edx, ecx

            imul edx, dword 4
            push eax
            add eax, edx

            mov edx, ecx
            imul edx, dword [K]
            imul edx, dword 4
            push eax
            mov eax, ebx
            imul eax, dword 4
            add edx, eax
            pop eax
            push ebx

            mov ebx, edx
            mov edx, dword [A + eax]
            imul edx, dword[B + ebx]

            ; PRINT_DEC 4, eax
            ; PRINT_CHAR ' '
            ; PRINT_DEC 4, ebx
            ; NEWLINE
            
            add dword[cur_res], edx

            pop ebx
            pop eax
            inc ecx
            jmp multiply_begin_3


        multiply_end_3:
            mov edx, dword[cur_res]
            push eax
            push ebx
            imul ebx, dword 4
            mov eax, [esp+8]  ; eax = i
            imul eax, dword [K]
            imul eax, dword 4
            add eax, ebx
            mov dword[C + eax], edx
            pop ebx
            pop eax
            mov dword[cur_res], 0
            inc ebx
            mov ecx, dword 0
            jmp multiply_begin_2

    multiply_end_2:
        pop eax
        inc eax
        mov ebx, dword 0
        jmp multiply_begin_1



multiply_end_1:
    mov eax, dword 0
    mov ebx, dword 0
print_C_begin_1:
    cmp eax, dword[N]
    jz print_C_end_1
    mov ebx, dword 0
    print_C_begin_2:
        cmp ebx, dword[K]
        jz print_C_end_2
        push eax
        imul eax, dword[K]
        imul eax, dword 4
        PRINT_DEC 4, [C + eax + 4 * ebx]
        PRINT_CHAR ' '
        pop eax
        inc ebx
        jmp print_C_begin_2


    print_C_end_2:
        NEWLINE
        inc eax
        jmp print_C_begin_1


print_C_end_1:
    xor eax, eax
    ret