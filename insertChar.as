            EXTERN  insertChar

            b             IS      $29
            bp            IS      $30
            pos           IS      $31
            s             IS      $32
            ret           IS      rA
            ret2          IS      $33
            N             IS      $34
            str           IS      $35
            r             IS      $36
            aux           IS      $37
            len           IS      $38
            cop           IS      $39
            tmp           IS      $40
            sav           IS      $255

insertChar  SUBU   bp, rSP, 32
            LDOU   str, bp, 0
            LDOU   pos, bp, 8
            LDOU   s, bp, 16
            PUSH   str
            SAVE   sav, $38, $41
            CALL   strlen
            OR     len, ret, 0
            SUBU   r, len, 1
            SUBU   str, str, str
for         CMPU   b, r, pos
            JN     b, end
            LDBU   aux, str, r
            ADDU   str, r, 1
            STBU   aux, str, 0
            JMP    for
end         SETW   cop, 32
            SETW   tmp, 0
            STBU   cop, str, 0
            ADDU   str, str, len
            ADDU   str, str, 1
            STBU   tmp, str, 0
            OR     ret, str, 0
            RET    3
