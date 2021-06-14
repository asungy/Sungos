[org 0x7c00]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Main
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Set BOOT_DRIVE variable. BIOS stores boot drive in DL.
mov [BOOT_DRIVE], dl

mov dx, WELCOME_STRING
call print_string

call print_newline
call print_newline

; Move stack pointer to safe address
mov bp, 0x8000
mov sp, bp

; Define address of buffer: [es:bx]
mov bx, 0x9000

; Load 5 sectors to buffer
mov dh, 2

; Set drive number
mov dl, [BOOT_DRIVE]

; Attempt to read from disk
call disk_load

; Print first loaded word from first sector(expected: 0xdada)
mov dx, [0x9000]
call print_hex16

call print_newline

; Print second loaded word from first sector(expected: 0xface)
mov dx, [0x9000 + 512]
call print_hex16

; Jump to current address (causes an infinite loop)
jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Includes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
%include "source/print_functions.asm"
%include "source/disk_load.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WELCOME_STRING:
  db 'Welcome to SungOS',0x21,0x0

MESSAGE:
  db 'This OS is barren...',0x0

BOOT_DRIVE:
  db 0x0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; End of Boot Sector
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0

; Magic number to signify boot sector
dw 0xaa55

; Load dummy test data in adjacent sector
times 256 dw 0xdada
times 256 dw 0xface
