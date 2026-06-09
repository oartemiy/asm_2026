extern printf, scanf, calloc, memcpy

; calle-safe: ebx esi edi ebp
; caller-sefe: eax ecx edx

section .bss
    cur resd 1
    pos resd 1
    res resd 1


section .text
global file_name
; char *file_name(const char *str, size_t pos);
file_name:
    push ebp
    mov ebp, esp

    mov eax, dword[ebp + 8]
    mov dword[cur], eax
    mov eax, dword[ebp + 12]
    mov dword[pos], eax

    mov eax, dword[pos]
    add dword[cur], eax

.Lwhile_shash_begin:
    mov eax, dword[cur]
    mov al, byte[eax]
    cmp al, '/'
    jne .Lnot_equal_shash
    mov esi, dword[cur]
    inc esi
    jmp .Lwhile_shash_end

.Lnot_equal_shash:
    inc dword[cur]
    jmp .Lwhile_shash_begin

.Lwhile_shash_end:

.Lwhile_space_begin:
    mov eax, dword[cur]
    mov al, byte[eax]
    cmp al, ' '
    jne .Lnot_equal_space
    mov edi, dword[cur]
    dec edi
    jmp .Lwhile_space_end

.Lnot_equal_space:
    inc dword[cur]
    jmp .Lwhile_space_begin

.Lwhile_space_end:
    mov eax, edi
    sub eax, esi
    add eax, 2

    push 1
    push eax
    call calloc
    add esp, 8

    mov dword[res], eax

    mov eax, edi
    sub eax, esi
    inc eax

    push eax
    push esi
    push dword[res]
    call memcpy
    add esp, 12

    mov esp, ebp
    pop ebp

    ret