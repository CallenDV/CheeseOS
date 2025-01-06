[org 0x7c00]

mov ax, 0x07c0
mov ds, ax
mov es, ax

mov ax, 0x9000
mov ss, ax
mov sp, 0xFFFF

mov si, boot_message
call print

mov bx, kernel_start
mov dh, 0
mov ch, 0
mov cl, 2
mov al, 1
mov ah, 0x02
mov dl, 0

mov di, 3
.retry:
    pusha
    int 0x13
    jnc .success
boot_message db 'Booting CheeseOS...', 0
disk_error db 'Disk read error!', 0

kernel_start equ 0x7e00
kernel_size equ 0x2000
    call print
    jmp $

.success:
    popa
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