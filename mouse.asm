section .text
global isr_mouse, setup_mouse

setup_mouse:
    mov ax, 0
    int 0x33
    mov ax, 0xC2
    int 0x33
    ret

isr_mouse:
    pusha
    mov ax, 0xB4
    int 0x33
    call clear_cursor
    mov [mouse_x], cx
    mov [mouse_y], dx
    call draw_cursor
    popa
    iret

clear_cursor:
    mov ax, [old_mouse_x]
    mov bx, [old_mouse_y]
    call draw_cursor_shape
    ret

draw_cursor:
    mov ax, [mouse_x]
    mov bx, [mouse_y]
    mov [old_mouse_x], ax
    mov [old_mouse_y], bx
    call draw_cursor_shape
    ret

draw_cursor_shape:
    mov cx, 3
draw_vertical_line:
    push ax
    push bx
    mov ah, 0x0c
    mov al, 0x0f
    int 0x10
    pop bx
    pop ax
    dec bx
    loop draw_vertical_line

    mov cx, 3
draw_horizontal_line:
    push ax
    push bx
    mov ah, 0x0c
    mov al, 0x0f
    int 0x10
    pop bx
    pop ax
    inc ax
    loop draw_horizontal_line
    ret

print_number:
    push ax
    push bx
    push cx
    mov cx, 10
    xor bx, bx
print_digit:
    xor dx, dx
    div cx
    add dl, '0'
    push dx
    inc bx
    or ax, ax
    jnz print_digit
print_digit_loop:
    pop dx
    mov ah, 0x0e
    int 0x10
    dec bx
    jnz print_digit_loop
    pop cx
    pop bx
    pop ax
    ret

section .bss
mouse_x resw 1
mouse_y resw 1
old_mouse_x resw 1
old_mouse_y resw 1

section .data
mouse_msg db 'Mouse Position: ', 0