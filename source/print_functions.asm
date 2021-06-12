;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Macros
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
%macro print_char 1
  mov al, %1
  int 0x10
%endmacro

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Prints a null-terminated string 
;
; Params:
;   dx - address of data string to be printed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_string:
  pusha
  ; Signify the video interrupt (int 0x10) to write contents of `al` in tty mode
  mov ah, 0x0e
  ; Index counter
  mov cx, 0x0000
  print_string_loop:
    ; Print character to terminal
    mov bx, dx
    add bx, cx
    inc cx
    print_char [bx]
    ; Check if encounter null-terminator
    cmp [bx], BYTE 0x0
    jne print_string_loop
  popa
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Prints a newline
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_newline:
  pusha
  mov ah, 0x0e
  print_char 0x0a ; newline
  print_char 0x0d ; carriage return
  popa
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Prints 16-bit hexidecimal value as string
;
; Params: 
;   dx - hex value to be printed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_hex16:
  pusha
  mov ah, 0x0e
  ; Print '0x'
  print_char 0x30
  print_char 0x78
  ; Counter
  mov cx, 0x0004
  ; Push hex values on stack from right to left
  print_hex16_push:
    mov bx, dx
    and bx, 0x000f
    cmp bx, 0x000a
    jl byte_is_digit
    ; Add offset and push to stack
    add bl, 0x57
    push bx
    jmp print_hex16_check
    byte_is_digit:
      add bl, 0x30
      push bx
    ; Check counter
    print_hex16_check:
      dec cx
      cmp cx, 0x0000
      ; If: counter is 0; Then: pop values
      je print_hex16_pop_prelude
      ; Else: Shift to next byte and loop
      shr dx, 4
      jmp print_hex16_push
  ; Pop hex values and print to terminal
  print_hex16_pop_prelude:
    ; Reset counter
    mov cx, 0x0004
    print_hex16_pop:
      pop bx
      print_char bl
      dec cx
      cmp cx, 0x0000
      jne print_hex16_pop
      popa
      ret


