section .text
global isr_keyboard

isr_keyboard:
    pusha
    in al, 0x60
    mov [key_pressed], al
    call handle_key_press
    mov al, 0x20
    out 0x20, al
    popa
    iret

handle_key_press:
    mov al, [key_pressed]
    cmp al, 0x0D
    je handle_enter
    cmp al, 0x08
    je handle_backspace
    ; Echo other keys
    call print_char
    ret

handle_enter:
    mov si, prompt
    call print_prompt
handle_backspace:
    mov al, 0x08
    call print_char
    mov al, ' ' 
    call print_char
    mov al, 0x08
    call print_char
    ret
    call print_char
    ret

print_char:
    mov ah, 0x0e
    int 0x10
    ret

print_prompt:
    lodsb
    or al, al
    jz done_prompt
    mov ah, 0x0e
    int 0x10
    jmp print_prompt

done_prompt:
    ret

print_space:
    mov al, 0x20
    call print_char
    ret

prompt db '>', 0
backspace db 0x08, 0x20, 0x08, 0x00

section .bss
    key_pressed resb 1
