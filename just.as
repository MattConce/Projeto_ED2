EXTERN  just


b           IS      $0
c           IS      $1
m           IS      $2
n           IS      $3
k           IS      $4
kp          IS      $5
a1          IS      $6
a2          IS      $7
a3          IS      $8


just        XOR     b, b, b
            SETW    m, 1

            SUBU    c, rSP, 16
            LDOU    c, c, 0

            XOR     kp, kp, kp

read        XOR     n, n, n
            OR      kp, a3, 0
            OR      k, kp, 0
            XOR     a3, a3, a3

            SAVE    rSP, $5, $7
            PUSH    c
            PUSH    kp
            CALL    readln
            REST    rSP, $5, $7
            OR      kp, rA, 0

            XOR     a1, a1, a1
            SUB     a1, a1, 1
            CMP     b, kp, a1
            JZ      b, eof
            JN      b, end

print       SAVE    rSP, $1, $1
            SAVE    rSP, $3, $8
            PUSH    n
            PUSH    c
            PUSH    k
            PUSH    kp
            CALL    println
            REST    rSP, $3, $8
            REST    rSP, $1, $1
            OR      a1, m, 0
            XOR     m, m, m
            OR      a3, kp, 0
reset       CMP     b, kp, 0
            JN      b, read
            LDBU    a2, a1, 0
            STBU    a2, m, 0
            SUB     kp, kp, 1
            ADD     m, m, 1
            ADD     a1, a1, 1
            JMP     reset

eof         XOR     kp, kp, kp
            SAVE    rSP, $1, $1
            SAVE    rSP, $3, $8
            PUSH    n
            PUSH    c
            PUSH    k
            PUSH    kp
            CALL    println
            REST    rSP, $3, $8
            REST    rSP, $1, $1

end         SETW    rX, 2
            SETW    rY, 0
            INT     #80
            RET     1
