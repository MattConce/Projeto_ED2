EXTERN  println


b           IS      $0
c           IS      $1
m           IS      $2
k           IS      $3
n           IS      $4
N           IS      $5
f           IS      $6
l           IS      $7
kp          IS      $8
bp          IS      $9
lln         IS      $10


println     SETW    rX, 2
            SUBU    bp, rSP, 40
            LDOU    n, bp, 0
            LDOU    c, bp, 8
            LDOU    k, bp, 16
            LDOU    kp, bp, 24

            XOR     lln, lln, lln

            CMP     b, n, 0
            JZ      b, end

            CMP     b, kp, 0
            JZ      b, lastln

            CMP     b, n, 1
            JZ      b, lastw

            SUB     n, n, 1
            SUB     N, c, k
            DIV     N, N, n
            SUB     f, n, rR
            OR      l, rR, 0

start       SAVE    rSP, $3, $6
            PUSH    f
            PUSH    N
            CALL    printws
            REST    rSP, $3, $6

            ADD     N, N, 1

            SAVE    rSP, $3, $6
            PUSH    l
            PUSH    N
            CALL    printws
            REST    rSP, $3, $6

lastw       LDB     kp, m, 0
            ADD     m, m, 1
            SAVE    rSP, $3, $3
            PUSH    kp
            CALL    printw
            REST    rSP, $3, $3

end         SETW    rY, 10
            INT     #80
            JZ      lln, ret
            INT     #80
ret         RET     4

lastln      SETW    N, 1
            SUB     f, n, 1
            SAVE    rSP, $3, $6
            PUSH    f
            PUSH    N
            CALL    printws
            REST    rSP, $3, $6
            SETW    lln, 1
            JMP     lastw
