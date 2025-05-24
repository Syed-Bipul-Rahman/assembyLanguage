; pm.asm - A simple bootloader that switches to protected mode and prints a message
BITS 16
ORG 0x7C00

start:
    ; Setup segments
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00      ; Set stack pointer below bootloader in memory

    ; Enable A20 Line (to access more than 1MB memory)
    call enable_a20

    ; Load Global Descriptor Table (GDT)
    lgdt [gdt_descriptor]

    ; Set protected mode bit in CR0
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    ; FAR jump to flush instruction pipeline and start executing in protected mode
    jmp 0x08:protected_mode

; ========== GDT ==========
gdt_null:
    dd 0                ; null descriptor
    dd 0

gdt_code:
    dw 0xFFFF           ; limit low
    dw 0                ; base low
    db 0                ; base middle
    db 10011010b        ; flags (code segment, executable, conforming, readable)
    db 11001111b        ; flags (granularity, 32-bit)
    db 0                ; base high

gdt_data:
    dw 0xFFFF           ; limit low
    dw 0                ; base low
    db 0                ; base middle
    db 10010010b        ; flags (data segment, writable)
    db 11001111b        ; flags (granularity, 32-bit)
    db 0                ; base high

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_null - 1   ; size
    dd gdt_null                 ; offset

CODE_SEG equ gdt_code - gdt_null
DATA_SEG equ gdt_data - gdt_null

; ========== Protected Mode Code ==========
BITS 32
protected_mode:
    ; Update segment registers
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; Set stack pointer to top of 16-bit segment
    mov ebp, 0x90000
    mov esp, ebp

    ; Call our print function
    mov ebx, msg_pm
    call print_string_pm

.hang:
    hlt
    jmp .hang

; ========== Functions ==========

; void print_string_pm(char *str);
print_string_pm:
    push ebx
    mov edx, 0xb8000       ; VGA text buffer starts at 0xB8000
.loop:
    mov al, [ebx]
    test al, al
    jz .done
    mov ah, 0x0F           ; attribute: white on black
    mov word [edx], ax
    add edx, 2
    inc ebx
    jmp .loop
.done:
    pop ebx
    ret

; ========== Enable A20 ==========
enable_a20:
    ; Try BIOS method first
    in al, 0x92
    test al, 2
    jnz .a20_ok
    or al, 2
    out 0x92, al
.a20_ok:
    ret

msg_pm db "Now in PM!", 0

; ========== Boot Sector Padding ==========
times 510 - ($ - $$) db 0
dw 0xAA55