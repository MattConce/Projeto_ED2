EXTERN  printws


b           IS      $0
m           IS      $2
n           IS      $3
sp          IS      $4
bp          IS      $5
kp          IS      $6


printws     SETW    rX, 2
            SUBU    bp, rSP, 24
            LDOU    n, bp, 0
            LDOU    sp, bp, 8

            CMP     b, n, 0
            JZ      b, end

print       CMP     b, n, 0
            JZ      b, end
            LDB     kp, m, 0
            ADD     m, m, 1
            SAVE    rSP, $3, $3
            PUSH    kp
            CALL    printw
            REST    rSP, $3, $3
            PUSH    sp
            CALL    printsp
            SUB     n, n, 1
            JMP     print

end         RET     2
