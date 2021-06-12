[org 0x7c00]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Main
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov dx, WELCOME_STRING
call print_string

call print_newline
call print_newline

mov dx, MESSAGE
call print_string

call print_newline
call print_newline

mov dx, 0xab34
call print_hex16

; Jump to current address (causes an infinite loop)
jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Includes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
%include "source/print_functions.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WELCOME_STRING:
  db 'Welcome to SungOS',0x21,0x0

MESSAGE:
  db 'This OS is barren...',0x0

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0

; Magic number to signify boot sector
dw 0xaa55
