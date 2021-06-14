disk_load:
  pusha

  ; Push number of requested sectors on stack
  push dx

  ; Set registers
  mov ah, 0x02    ; BIOS read sector function
  mov al, dh      ; Read number of sectors defined in DH
  mov ch, 0x00    ; Select cylinder 0
  mov dh, 0x00    ; Select head 0
  mov cl, 0x02    ; Start reading from second sector (starting index: 1)

  int 0x13        ; BIOS interrupt
                  ; Number of sectors read will be stored in al

  jc disk_error   ; Jump if error (indicated by carry flag)
  
  pop dx          ; Restore expected read sectors in dx
  cmp dh, al      ; Compare sectors read with expected value
  jne sector_error

  popa
  ret

disk_error:
  ; Print error message
  mov dx, DISK_ERROR_MSG
  call print_string
  call print_newline
  ; Print error code
  mov dx, ax
  call print_hex16
  ; Loop indefinitely
  jmp $

sector_error:
  ; Print error message
  mov dx, INCORRECT_SECTOR_MSG
  call print_string
  ; Loop indefinitely
  jmp $

; Variables
DISK_ERROR_MSG:
  db "Disk read error!",0x0

INCORRECT_SECTOR_MSG:
  db "Incorrect number of sectors read",0x0
