        EXTERN strlen

        c   IS  $105
        bp  IS  $106
        str IS  $107
        len IS  $108


strlen  XOR   c, c, c
        SUBU  bp, rSP, 0
        LDOU  str, bp, 0
        OR    len, str
        SUBU  str, str, str
loop    CMPU  b, str, len
        JZ    b, ret
        ADDU  c, c, 1
        ADDU  str, str, 1
        JMP   loop
ret     OR    ret, c, 0
        RET   1