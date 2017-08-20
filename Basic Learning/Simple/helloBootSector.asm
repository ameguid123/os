;
; Boot sector to print "Hello world!" to the screen w/ BIOS routine
;
mov ah, 0x0e ; tty mode (tele-type mode)
mov al, 'H'
int 0x10
mov al, 'e' 
int 0x10
mov al, 'l'
int 0x10
int 0x10 ; We can just raise the interrupt 0x10 again since l is still on al
mov al, 'o'
int 0x10
mov al, ' '
int 0x10
mov al, 'w'
int 0x10
mov al, 'o'
int 0x10
mov al, 'r'
int 0x10
mov al, 'l'
int 0x10
mov al, 'd'
int 0x10
mov al, '!'
int 0x10

jmp $ ; jumping to the current address is an infinite loop

; pad rest of boot sector w/ 0's + add 0xAA55 magic number for little-endian
times 510 - ($-$$) db 0
dw 0xaa55