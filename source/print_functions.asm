; Prints a null-terminated string whose address is stored in the di register
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

; Prints a newline
print_newline:
  pusha
  ; Print newline
  mov ah, 0x0e
  mov al, 0x0a
  int 0x10
  ; Print carriage retrun
  mov al, 0x0d
  int 0x10
  popa
  ret

