EXTERN  justify

* receives ()
* returns ()

w_last     IS        $0          *paragraph's last byte's memory adress
mem        IS        $1          *current byte's mem adress (starts as first word memadress)
byte       IS        $2          *current byte's value
mem2       IS        $3          *justified paragraph memory segment's current adress
arg        IS        $4          *cmd line argument ('C')
l_len      IS        $5          *current line's length
wcount     IS        $6          *current line's word count ('n')
spaces     IS        $7          *used when calculating how many spaces have to be inserted
i          IS        $8          *counter used for calculating spaces
wl_mem     IS        $9          *memory adress for words' length

justify        XOR    w_last, w_last, w_last
               XOR    mem, mem, mem
               XOR    byte, byte, byte
               XOR    mem2, mem2, mem2
               XOR    arg, arg, arg
               XOR    l_len, l_len, l_len
               XOR    wcount, wcount, wcount
               XOR    spaces, spaces, spaces
               XOR    i, i, i
               XOR    wl_mem, wl_mem, wl_mem
               SUBU   rX, rSP, 32
               LDOU   mem, rX, 0
               LDOU   w_last, rX, 8
               LDOU   arg, rX, 16
               SETW   rX, 50000
               ADDU   mem, mem, rX        *manually adding 50k to mem (10k becomes 50k)
               ADDU   mem2, mem, rX       *manually adding 50k to mem2 (50k becomes 110k)
               SETW   l_len, 1
               SETW   wcount, 0
               SETW   wl_mem, 200000

while          CMP    rX, w_last, mem
               JZ     rX, end

while2         CMP    rX, arg, l_len
               JZ     rX, maxline         *maximum line length reached
               LDBU   byte, mem, 0
               CMP    byte, 0
               JZ     byte, found_null    *NULL was found, add space instead
               STBU   byte, mem2, 0
               ADDU   mem, mem, 1
               ADDU   mem2, mem2, 1
               ADDU   l_len, l_len, 1
               JMP    while2

found_null     SETW   byte, 32
               STBU   byte, mem2, 0
               ADDU   mem, mem, 1
               ADDU   mem2, mem2, 1
               ADDU   l_len, l_len, 1
               ADDU   wcount, wcount, 1
               JMP    while2

maxline        LDBU   byte, mem, 0        *check next byte
               CMP    byte, 0             *if it's NULL, the line is correct
               JNZ    byte, insert_sp     *it it's not, insert spaces accordingly
               SETW   byte, 10
               STBU   byte, mem2, 0       *add new line feed to line's end
               SETW   wcount, 0           *reset variables

insert_sp      SUBU   mem, mem, 1         *first, fix mem and mem2 adresses for next operations
               STBU   rX, mem, 0
               CMP    rX, rX, 0
               JNZ    rX, insert_sp
               ADDU   mem, mem, 1         *[mem now points to next line's first char]
fix_mem2       SUBU   mem2, mem2, 1
               STBU   rX, mem2, 0
               CMP    rX, rX, 32
               JNZ    fix_mem2
               SUBU   mem2, mem2, 1       *[mem2 now points to last word's char]
               ADDU   spaces, arg, 0      *start calculating how many spaces need to be inserted
               SETW   i, 1
ins_while      CMP    rX, wcount, i
               JZ     rX, added           *jump after all current line's words' length have been added
               LDBU   rX, wl_mem, 0
               SUBU   spaces, spaces, rX
               ADDU   wl_mem, wl_mem, 1
               JMP    ins_while
added          SUBU   spaces, spaces, wcount
               ADDU   spaces ,spaces, 1   *spaces calculation finished
                *start inserting spaces

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
               ADDU   mem2, mem2, 1
               ADDU   mem, mem, 1

end            ***SUBU   mem2, mem2, 1
               ***OR     rA, mem2, 0
               RET    2