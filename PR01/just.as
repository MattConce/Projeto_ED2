EXTERN  just

sav         IS      $0
b           IS      $1
c           IS      $2
m           IS      $3
n           IS      $4
k           IS      $5
N           IS      $6
kp          IS      $7
a1          IS      $9


just        XOR     b, b, b
            SETW    m, 1
            XOR     oc, oc, oc
            XOR     a1, a1, a1

            SUBU    c, rSP, 16
            LDOU    c, c, 0

readPrint   XOR     n, n, n
            XOR     N, N, N

            CALL    readln
            OR      kp, rA, 0

            CMP     b, kp, #fffffffffffffffe
            JZ      b, end
            CMP     b, kp, #ffffffffffffffff
            JZ      b, eof

            CMP     b, n, 0
            JNZ     b, nempty
            SETW    N, 0
            SETW    rR, 0
            PUSH    n
            PUSH    N
            PUSH    rR
            CALL    println
            JMP     readPrint

nempty      CMP     b, kp, 0
            JZ      lastln
            SUB     N, c, k
            DIV     N, N, n
            JMP     println
lastln      SETW    N, 1
            SETW    rR, 0
println     PUSH    N
            PUSH    n
            PUSH    rR
            CALL    println
            JMP     readPrint

eof         SETW    N, 1
            SETW    rR, 0
            PUSH    N
            PUSH    n
            PUSH    rR
            CALL    println

end         SETW    rX, 2
            SETW    rY, 0
            INT     #80
            RET     1
