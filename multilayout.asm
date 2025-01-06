section .data
qwerty_layout db 'abcdefghijklmnopqrstuvwxyz', 0
dvorak_layout db 'axje.uidchtnmbrl\'wfgv/qozs;', 0
current_layout db 'qwerty', 0  ; Default layout
key_pressed db 0

section .text
global switch_layout
global handle_key_press

switch_layout:
cmp byte [current_layout], 'q'
je set_dvorak
cmp byte [current_layout], 'd'
je set_qwerty
ret

set_dvorak:
mov byte [current_layout], 'd'
mov si, dvorak_layout
jmp switch_done

set_qwerty:
mov byte [current_layout], 'q'
mov si, qwerty_layout

switch_done:
call print
ret

handle_key_press:
mov al, [key_pressed]
mov si, current_layout
cmp byte [si], 'q'
je qwerty_mapping
cmp byte [si], 'd'
je dvorak_mapping
ret
qwerty_mapping:
mov bl, [key_pressed]
sub bl, 'a'
cmp bl, 26
jae .done
mov bx, qwerty_layout
mov al, [bx]
.done:
ret

dvorak_mapping:
mov bl, [key_pressed]
sub bl, 'a'
cmp bl, 26
jae .done
mov bx, dvorak_layout
mov al, [bx]
.done:
retrak_mapping:
ret