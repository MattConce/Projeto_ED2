EXTERN  readParagraph

* receives the last byte's memory adress
* returns the memory adress of the first consecutive new line occurrence

l_mem      IS        $0          *input last byte's memory adress
mem        IS        $1          *current byte's mem adress
byte       IS        $2          *current byte's value

readParagraph   XOR    l_mem, l_mem, l_mem
                XOR    mem, mem, mem
                SUBU   rX, rSP, 16
                LDOU   l_mem, rX, 0       *loading len from stack
                SETW   mem, 10000         *manual input for mem

while           CMP    rX, l_mem, mem
                JZ     rX, end            *happens if whole text is a paragraph
                LDBU   byte, mem, 0
                CMP    rX, byte, 10
                JZ     rX, found_nl       *found a new line
                ADDU   mem, mem, 1
                JMP    while

found_nl        ADDU   mem, mem, 1      
                LDBU   byte, mem, 0
                CMP    rX, byte, 10
                JZ     rX, end            *found a consecutive new line
                JMP    while
                
end             OR     rA, mem, 0         *return mem (second new line's adress)
                RET    1