;
; A boot sector program that uses the stack.
; Expected result: 'ABC CB?AA' where ? is garbage

; NOTE: "higher" memory addresses are those closer to 0x0000.
; NOTE: stack grows "down." i.e. base pointer is largest address, rest of 
; addresses get smaller (i.e. closer to 0x0000, "higher"). 
; Growing towards 0x0000 (and our boot sector!)

; tty mode
mov ah, 0x0e

; Setting base of stack away from 0x7c00 so stack does not overwrite boot sector
mov bp, 0x8000

; If stack is empty, sp points to bp
; "sp"~stack pointer, points to top of stack
; "bp"~base pointer, points to base of stack
mov sp, bp

; Push characters onto stack as 16-bit vals.
; Most significant byte added by assembler as 0x00
push 'A'
push 'B'
push 'C'

; Show how the stack grows down, 0x7ffe = 0x8000 - 2. 
; Below should print A
mov al, [0x7ffe]
int 0x10

; Below should print B
mov al, [0x7ffc]
int 0x10

; Below should print C
mov al, [0x7ffa]
int 0x10

; Nothing at the base of the stack
mov al, [0x8000]
int 0x10

; Recover our characters with pop.
; Can only pop full "words" so need extra register to manipulate the lower byte
; "word" = size of max processing unit of current mode of CPU 
; (for 16-bit real mode this = 16-bit val)
; To summarize: pop to bx then copy bl, an 8-bit char, to al, and print al
; Below should pop and print C
pop bx
mov al, bl
int 0x10

; Below should pop and print B
pop bx
mov al, bl
int 0x10

; Below should NOT print B, but prints garbage (we popped B already)
mov al, [0x7ffc]
int 0x10

; Below should print A 
mov al, [0x7ffe]
int 0x10

; Below should pop and print A
pop bx
mov al, bl
int 0x10

; Jump forever
jmp $
; Padding and magic number
times 510-($-$$) db 0
dw 0xaa55