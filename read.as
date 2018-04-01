EXTERN  read

mem    IS    $0

read        XOR     mem, mem, mem
            SETW    mem, 10000         *input bytes will be stored from M[1000] onwards

loop        SETW    rX, 1
            INT     #80
            CMP     rX, rA, 0         *using rX as a temp register
            JN      rX, end
            STBU    rA, mem, 0        *store byte onto M[mem] 
            ADDU    mem, mem, 1       *go to next memory adress
            JMP     loop

end         SUBU    mem, mem, 1
            OR      rA, mem, 0        *returns the last stored byte's memory adress
            RET     0
