[bits 16]           ; tell assembler that working in real mode(16 bit mode)
[org 0x7c00]        ; organize from 0x7C00 memory location where BIOS will load us


jmp start

times (510 - ($ - $$)) db 0x00      ;set 512 bytes for boot sector which are necessary
dw 0xAA55                           ; boot signature 0xAA & 0x55
