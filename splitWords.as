EXTERN  splitWords

* receives the paragraph's first and last memory adress
* returns the last memory adress of the "words" memory segment

p_last     IS        $0          *paragraph's last byte's memory adress
mem        IS        $1          *current byte's mem adress (starts as first memadress)
byte       IS        $2          *current byte's value
mem2       IS        $3          *2nd memory segment's current adress
valid      IS        $4          *"boolean" - indicates an valid byte was found prev 
wlen       IS        $5          *counter that indicates the current word's length
wl_mem     IS        $6          *memory adress that stores the word's length

splitWords      XOR    p_last, p_last, p_last
                XOR    mem, mem, mem
                XOR    byte, byte, byte
                XOR    mem2, mem2, mem2
                XOR    valid, valid, valid
                XOR    wlen, wlen, wlen
                XOR    wl_mem, wl_mem, wl_mem
                SUBU   rX, rSP, 24
                LDOU   mem, rX, 0
                LDOU   p_last, rX, 8
                SETW   valid, 0
                SETW   rX, 50000
                ADDU   mem2, mem, rX
                SETW   wlen, 1
                SETW   wl_mem, 200000

while           CMP    rX, p_last, mem
                JZ     rX, end
                LDBU   byte, mem, 0
                CMP    rX, byte, 9
                JZ     rX, found_sp
                CMP    rX, byte, 10
                JZ     rX, found_sp
                CMP    rX, byte, 13
                JZ     rX, found_sp
                CMP    rX, byte, 32
                JZ     rX, found_sp
                SETW   valid, 1            *set boolean
                STBU   byte, mem2, 0       *didn't find a space, store byte on 2nd mem segment
                ADDU   wlen, wlen, 1
                ADDU   mem2, mem2, 1
                ADDU   mem, mem, 1

found_sp        CMP    rX, valid, 0        *found a space
                JZ     rX, invalid         *if a valid byte was not found, go back
                SETW   byte, 0             *else, a word has been found, separate with NULL
                STBU   byte, mem2, 0
                STBU   wlen, wl_mem, 0     *store the word's length on the corresponding segment
                ADDU   mem2, mem2, 1
                ADDU   mem, mem, 1
                ADDU   wl_mem, wl_mem, 1
                SETW   valid, 0            *reset boolean
                SETW   wlen, 1             *reset wlen
                JMP    while
                
invalid         ADDU   mem, mem, 1
                JMP    while

end             STBU   wlen, wl_mem, 0     *store the last word's length before returning
                SUBU   mem2, mem2, 1
                OR     rA, mem2, 0
                RET    2