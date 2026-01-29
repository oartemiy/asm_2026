section .data
    msg db 'Hello, World!', 0x0A ; Строка для вывода и символ новой строки
    len equ $ - msg             ; Длина строки

section .text
    global _start              ; Точка входа для компоновщика

_start:
    ; Вызов sys_write (системный вызов 4)
    mov eax, 4                 ; Номер системного вызова write
    mov ebx, 1                 ; Файловый дескриптор 1 (stdout)
    mov ecx, msg               ; Адрес строки
    mov edx, len               ; Длина строки
    int 0x80                   ; Вызов ядра

    ; Вызов sys_exit (системный вызов 1)
    mov eax, 1                 ; Номер системного вызова exit
    mov ebx, 0                 ; Код возврата 0 (успех)
    int 0x80   
