EXTERN  printws


sav         IS      $0
b           IS      $1
m           IS      $3
n           IS      $4
sp          IS      $5
bp          IS      $6
kp          IS      $7


printws     SETW    rX, 2
            SUBU    bp, rSP, 24
            LDOU    n, bp, 0
            LDOU    sp, bp, 8

            CMP     b, n, 0
            JZ      b, end

print       CMP     b, n, 0
            JZ      b, gol
            LDB     kp, m, 0
            ADD     m, m, 1
            PUSH    kp
            CALL    printw
            PUSH    N
            CALL    printsp
            SUB     n, n, 1
            JMP     print

end         RET     2
