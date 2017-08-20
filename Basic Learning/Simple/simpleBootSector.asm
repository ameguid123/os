;
; A boot sector program that loops forever.
;

; Defining label "loop" that we can jump back to forever
loop:
    jmp loop

; Compiled boot sector must be 512 bytes, with last 2 bytes as the magic number.
; This tells assembly compiler to pad rest of the program with 0 bytes (db 0)
; "db" stands for "declare byte(s) of dataå"
; until at 510th byte.
times 510-($-$$) db 0
; 0xAA55 magic number to identify this as a boot sector
dw 0xaa55

; Can view the .bin created by assembler with:
; $od -t x1 -A n simpleBootSector.bin  (displays in hex)
