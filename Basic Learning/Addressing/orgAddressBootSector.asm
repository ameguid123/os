;
; A boot sector program that uses addressing (with org directive)
;

; Corrects LABEL references during assemblege (does not modify typed addresses
; like 0x7c2d)
[org 0x7c00]


mov ah, 0x0e

; Still fails, attempts to print memory address, not its contents
mov al, "1"
int 0x10
mov al, theSecret
int 0x10

; Succeeds! Prints content at memory address, which is now correct with org 
; directive. 
mov al, "2"
int 0x10
mov al, [theSecret]
int 0x10

; Fails (with org directive). Adds the BIOS offset 0x7c00 to the (now correct 
; b/c org directive) address of theSecret, then dereferences contents of new 
; pointer. 
mov al, "3"
int 0x10
mov bx, theSecret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Still works, since we know where X is stored in our binary, we get it out 
; right here. 
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10

jmp $ ; Infinite jump to current address

; X stored before 0 padding
theSecret:
    db "X"

; Zero padding and end with magic number
times 510-($-$$) db 0
dw 0xaa55