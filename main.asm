extern printf, scanf, calloc, memcpy, fread, fprintf, fopen, fclose

; calle-safe: ebx esi edi ebp
; caller-sefe: eax ecx edx

section .rodata
    file_in_name db "input.bin", 0
    file_out_name db "output.txt", 0
    fmt_out db "%lld", 10, 0
    binary db "rb", 0

section .bss
    file_in resd 1
    file_out resd 1
    cur resb 1
    ans resq 1


section .text
global main
main:
    push ebp
    mov ebp, esp
    push binary
    push file_in_name
    call fopen
    add esp, 8

    mov dword[file_in], eax

    xor eax, eax
    xor edx, edx

    mov dword[ans], dword 0
    mov dword[ans + 4], dword 0

.Lread_byte_begin:
    push dword[file_in]
    push 1
    push 1
    push cur
    call fread
    add esp, 16
    
    cmp eax, dword 0
    je .Lread_byte_end
    
    movsx eax, byte[cur]

    cdq

    add dword[ans], eax
    adc dword[ans + 4], edx

    jmp .Lread_byte_begin


.Lread_byte_end:

    push dword[ans + 4]
    push dword[ans]
    push fmt_out
    call printf
    add esp, 12

    push dword[file_in]
    call fclose
    add esp, 4

    mov esp, ebp
    pop ebp
    xor eax, eax
    ret