[org 0x7c00]

    mov ax, 0x07c0
    mov ds, ax

    mov si, boot_message
    call print

    ; Load kernel
    mov bx, kernel_start
    mov es, ax
    mov cx, kernel_size
    mov ah, 0x02
    mov al, 1
    mov dl, 0
    int 0x13

    jmp 0x0000:0x7e00

print:
    lodsb
    or al, al
    jz done
    mov ah, 0x0e
    int 0x10
    jmp print

done:
    ret

boot_message db 'Booting CheeseOS...', 0

kernel_start equ 0x7e00
kernel_size equ 0x2000

times 510 - ($ - $$) db 0
dw 0xaa55
