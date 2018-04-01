EXTERN  splitWords

* receives the paragraph's first and last memory adress
* returns the last memory adress of the "words" memory segment

p_last     IS        $0          *paragraph's last byte's memory adress
mem        IS        $1          *current byte's mem adress (starts as first memadress)
byte       IS        $2          *current byte's value
mem2       IS        $3          *2nd memory segment's current adress
valid      IS        $4          *"boolean" - indicates an valid byte was found prev 

splitWords      XOR    p_last, p_last, p_last
                XOR    mem, mem, mem
                XOR    byte, byte, byte
                XOR    mem2, mem2, mem2
                XOR    valid, valid, valid
                SUBU   rX, rSP, 24
                LDOU   mem, rX, 0
                LDOU   p_last, rX, 8
                SETW   valid, 0
                SETW   mem2, 60000

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
                SETW   valid, 1
                STBU   byte, mem2, 0       *didn't find a space, store byte on 2nd mem segment
                ADDU   mem2, mem2, 1
                ADDU   mem, mem, 1

found_sp        CMP    rX, valid, 0        *found a space
                JZ     rX, invalid         *if a valid byte was not found, go back
                SETW   byte, 0             *else, a word has been found, separate with NULL
                STBU   byte, mem2, 0
                ADDU   mem2, mem2, 1
                ADDU   mem, mem, 1
                SETW   valid, 0            *reset boolean
                JMP    while
                
invalid         ADDU   mem, mem, 1
                JMP    while

end             SUBU   mem2, mem2, 1
                OR     rA, mem2, 0
                RET    2