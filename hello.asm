; hello.asm
BITS 16
START:
    mov ax, 0x07C0      ; Set up stack segment
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov si, message     ; Load address of message
    call print_string   ; Call our print function

    cli                 ; Clear interrupts
    hlt                 ; Halt CPU

print_string:           ; Label definition (note the colon here)
    mov ah, 0x0E        ; BIOS teletype function

.loop:
    lodsb               ; Load next character from string
    or al, al           ; Test for end of string (zero)
    jz .done
    int 0x10            ; Print character
    jmp .loop

.done:
    ret                 ; Return from function

message:
    db 'Hello, World!', 0

times 510 - ($ - $$) db 0   ; Pad remainder of boot sector with zeros
dw 0xAA55                     ; Boot signature