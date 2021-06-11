mov di, welcome_string
call print_string

mov di, hello_world
call print_string

welcome_string:
  db 'Welcome to SungOS',0x0

hello_world:
  db 'Hello world',0x0

print_string:
  pusha
  ; Signify the video interrupt (int 0x10) to write contents of `al` in tty mode
  mov ah, 0x0e
  ; Index counter
  mov cx, 0x0
  L1:
    ; Print character to terminal
    mov bx, 0x7c00
    add bx, di
    add bx, cx
    inc cx
    mov al, [bx]
    int 0x10
    ; Check if encounter null-terminator
    cmp [bx], BYTE 0x0
    jne L1
  popa
  ret

; Jump to current address
jmp $

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0

; Magic number to signify boot sector
dw 0xaa55
