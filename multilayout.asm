section .text
global switch_layout

; QWERTY layout
qwerty_layout db 'abcdefghijklmnopqrstuvwxyz', 0

; Dvorak layout
dvorak_layout db 'axje.uidchtnmbrl\'wfgv/qozs;', 0

current_layout db 'qwerty', 0  ; Default layout

; Switch layout function
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

; Handle key press and map it according to the current layout
handle_key_press:
mov al, [key_pressed]
; Map key according to the current layout
mov si, current_layout
cmp byte [si], 'q'
je qwerty_mapping
cmp byte [si], 'd'
je dvorak_mapping
ret

qwerty_mapping:
; Map key using QWERTY layout
ret

dvorak_mapping:
; Map key using Dvorak layout
ret
