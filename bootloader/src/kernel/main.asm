ORG 0x00
BITS 16

main:
    mov ax, 0
    mov dx, ax 
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00

    mov si, os_boot_message
    call print

    HLT

halt:
    JMP halt

print:
    push si
    push ax
    push bx

print_loop:
    lodsb     ; load first byte pointed by si
    or al, al ; check whether we reached string terminator or not
    jz done_print

    mov ah, 0x0E
    mov bx, 0 ; page number
    int 0x10
    jmp print_loop

done_print:
    pop si
    pop ax
    pop bx
    ret

os_boot_message DB 'OS booted successfully', 0x0D, 0x0A, 0

TIMES 510-($-$$) DB 0
DW 0AA55h
