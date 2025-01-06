[bits 16]
[org 0x7e00]

section .text
    mov si, msg
    call print

    mov ax, 0
    mov ds, ax
    mov si, idt
    lidt [si]

    cli
    mov al, 0x20
    out 0x21, al
    sti

        mov si, prompt
        call print_prompt
    
    command_loop:
        mov ah, 0x00
        int 0x16
        mov [key_pressed], al
        
        cmp al, 0x0D
        je process_command
        
        mov ah, 0x0e
        int 0x10
        jmp command_loop
    
    process_command:
        call handle_command
        jmp command_loop

print:
    lodsb
    or al, al
    jz done
    mov ah, 0x0e
    int 0x10
    jmp print

done:
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

handle_command:
    mov si, command_buffer
    call execute_command
    mov si, prompt
    call print_prompt
    ret

execute_command:
    mov di, echo_command
    call compare_command
    jc echo_found
    mov di, read_command
    call compare_command
    jc read_found
    mov di, write_command
    call compare_command
    jc write_found
    jmp command_not_found

echo_found:
    ; Execute echo command
    mov si, echo_message
    call print_prompt
    mov si, si_command_buffer
    call print_prompt
    ret

read_found:
    ; Execute read command
compare_command:
    push si
    push di
    mov cx, 4
    cld
    repe cmpsb
    je .match
    clc
    jmp .done
.match:
    stc
.done:
    pop di
    pop si
    ret

write_found:
    mov si, write_message
    call print_prompt
    mov si, si_command_buffer
    call write_file
    ret

compare_command:
    mov cx, 0
    cld
    rep cmpsb
    ret

msg db 'Welcome to CheeseOS!', 0
prompt db '>', 0
echo_command db 'echo', 0
echo_message db 'You typed: ', 0
read_command db 'read', 0
read_message db 'File content:', 0
write_command db 'write', 0
write_message db 'Writing to file...', 0

section .data
    idt:
        dw 256 * 8 - 1  ; IDT limit
        dd idt_entries   ; IDT base address

section .text
idt_entries:
    times 256 dd isr_default  ; Fill IDT with default handler addresses

isr_default:
    cli
    hlt

section .bss
    key_pressed resb 1  ; Reserve space to store pressed key
    command_buffer resb 64  ; Reserve space for command buffer
    si_command_buffer resb 64  ; Reserve space for command buffer
    file_content resb 1024  ; Reserve space for file content

section .data
    file_system:
        directory:
            file1 db 'File1', 0
            file2 db 'File2', 0
        file1_content db 'Content of File1', 0
        file2_content db 'Content of File2', 0

read_file:
    mov cx, 0
    mov dx, si  ; Move file name pointer to DX
    mov si, file_system
    mov di, directory
    jmp compare_file_names

find_file:
    mov cx, 0
    mov dx, si  ; Move file name pointer to DX
    mov si, di
    call compare_file_names

compare_file_names:
    lodsb
    cmp al, [dx]
    jne next_file
    cmp al, 0
    je file_found
    inc cx
    jmp compare_file_names

next_file:
    lodsb
    cmp al, 0
    jne next_file
    mov si, di
    add si, cx
    mov cx, 0
    lodsb
    cmp al, 0
    je no_file_found
    add si, cx
    jmp find_file

file_found:
    lodsb
    cmp al, 0
    jne file_found
    mov si, file_system
    add si, 32
    mov cx, 0
    jmp read_file_content

read_file_content:
    lodsb
    or al, al
    jz file_content_read
    stosb
    jmp read_file_content

file_content_read:
    ret

no_file_found:
    mov si, no_file_message
    call print_prompt
    ret

no_file_message db 'File not found!', 0

write_file:
    mov cx, 0
    mov dx, si
    mov si, file_system
    mov di, directory
    jmp compare_file_names_write

find_file_write:
    mov cx, 0
    mov dx, si
    mov si, di
    call compare_file_names_write

compare_file_names_write:
    lodsb
    cmp al, [dx]
    jne next_file_write
    cmp al, 0 
    je file_found_write
    inc cx
    jmp compare_file_names_write

next_file_write:
    lodsb
    cmp al, 0
    jne next_file_write
    mov si, di
    add si, cx
    mov cx, 0
    lodsb
    cmp al, 0
    je no_file_found_write
    add si, cx
    jmp find_file_write

file_found_write:
    lodsb
    cmp al, 0
    jne file_found_write
    mov si, file_system
    add si, 32
    mov cx, 0
    jmp write_file_content

write_file_content:
    lodsb
    or al, al
    jz file_content_written
    stosb
    jmp write_file_content

file_content_written:
    ret

no_file_found_write:
    mov si, no_file_message
    call print_prompt
    ret

command_not_found:
    mov si, unknown_command
    call print_prompt
    ret

unknown_command db 'Unknown command!', 0