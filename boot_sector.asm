; Signify the video interrupt (int 0x10) to write contents of `al` in tty mode
mov ah, 0x0e

; Index counter
mov cx, 0x0

; Prints 'Welcome to SungOS' to terminal
L1:
  ; Print character to terminal
  mov bx, 0x7c00
  add bx, welcome_string
  add bx, cx
  inc cx
  mov al, [bx]
  int 0x10
  ; Check if encounter null-terminator
  cmp [bx], BYTE 0x0
  jne L1


welcome_string:
  db 'Welcome to SungOS!',0

; Jump to current address
jmp $

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0

; Magic number to signify boot sector
dw 0xaa55
