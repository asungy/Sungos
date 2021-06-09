; Signify the video interrupt (int 0x10) to write contents of `al` in tty mode
mov ah, 0x0e

; Printing 'hello' to terminal
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10

; Jump to current address
jmp $

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0

; Magic number to signify boot sector
dw 0xaa55
