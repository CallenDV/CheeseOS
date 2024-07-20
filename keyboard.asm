section .text
global isr_keyboard

isr_keyboard:
    pusha           ; Save general-purpose registers
    in al, 0x60     ; Read key from keyboard controller
    mov [key_pressed], al  ; Store pressed key
    call handle_key_press
    popa            ; Restore general-purpose registers
    iret            ; Return from interrupt

handle_key_press:
    mov al, [key_pressed]
    cmp al, 0x0D    ; Check if Enter key pressed
    je handle_enter
    cmp al, 0x08    ; Check if Backspace key pressed
    je handle_backspace
    ; Echo other keys
    call print_char
    ret

handle_enter:
    mov si, prompt
    call print_prompt
    ret

handle_backspace:
    mov si, backspace
    call print_char
    call print_space
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
backspace db 0x08, 0x20, 0x08, 0x00  ; Backspace sequence: erase, space, erase, null terminator

section .bss
    key_pressed resb 1  ; Reserve space to store pressed key
