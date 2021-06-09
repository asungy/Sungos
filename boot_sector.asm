; Signify the video interrupt (int 0x10) to write contents of `al` in tty mode
mov ah, 0x0e

; Print 'Welcome to SungOS' to terminal
mov al, 'W'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'c'
int 0x10
mov al, 'o'
int 0x10
mov al, 'm'
int 0x10
mov al, 'e'
int 0x10
mov al, ' '
int 0x10
mov al, 't'
int 0x10
mov al, 'o'
int 0x10
mov al, ' '
int 0x10
mov al, 'S'
int 0x10
mov al, 'u'
int 0x10
mov al, 'n'
int 0x10
mov al, 'g'
int 0x10
mov al, 'O'
int 0x10
mov al, 'S'
int 0x10
mov al, 0x21 ; 0x21 == '!'
int 0x10

; Jump to current address
jmp $

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0

; Magic number to signify boot sector
dw 0xaa55
