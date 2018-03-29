EXTERN  println


sav         IS      $0
b           IS      $1
m           IS      $3
f           IS      $4
l           IS      $5
n           IS      $6
bp          IS      $7


println     SETW    rX, 2
            SUBU    bp, rSP, 32
            LDOU    n, bp, 0
            LDOU    f, bp, 8
            LDOU    l, bp, 16

            CMP     b, n, 0
            JZ      b, end

            PUSH    f
            PUSH    n
            CALL    printws

            ADD     n, n, 1

            PUSH    l
            PUSH    n
            CALL    printws

end         SETW    rY, 10
            INT     #80
            RET     3
