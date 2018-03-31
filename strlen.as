        EXTERN strlen

        b   IS  $0
        c   IS  $105
        bp  IS  $106
        str IS  $107
        len IS  $108
        ret IS  rA


strlen  XOR    c, c, c
        SUBU   bp, rSP, 16
        LDOU   str, bp, 0
        SUB    str, str, str
loop    CMP    b, str, 0
        JN     b, end
        ADDU   c, c, 1
        ADDU   str, str, 1
        JMP    loop
end     OR     ret, c, 0
        RET    1
