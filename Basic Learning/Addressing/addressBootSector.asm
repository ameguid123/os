;
; A boot sector program that uses addressing
;

mov ah, 0x0e

; Fails, attempts to print memory address, not its contents
mov al, "1"
int 0x10
mov al, theSecret
int 0x10

; Fails, prints content at memory address, but BIOS puts our bootsector at the 
; address 0x7c00, so need to add that padding.
mov al, "2"
int 0x10
mov al, [theSecret]
int 0x10

; Succeeds! adds the BIOS offset 0x7c00 to address of theSecret, then
; dereferences contents of new pointer. 
; Must use different register, as "mov al, [ax]" is not allowed; a register 
; can't be used as a source and destination.
mov al, "3"
int 0x10
mov bx, theSecret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Because we know where X is stored in our binary, we get it out right here. 
; Works, but not efficient (would have to modify every time changed code)
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