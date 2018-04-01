        EXTERN strlen

        b   IS  $1
        c   IS  $2
        bp  IS  $3
        str IS  $4
        len IS  $5
        ret IS  rA


strlen  XOR    c, c, c
        SUBU   bp, rSP, 16
        LDOU   str, bp, 0
        *SUBU    str, str, str
loop    LDB    b, str, 0
        JN     b, end
        ADDU   c, c, 1
        ADDU   str, str, 1
        JMP    loop
end     OR     ret, c, 0
        RET    1
