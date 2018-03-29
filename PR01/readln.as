EXTERN  readln


sav         IS      $0
b           IS      $1
c           IS      $2
m           IS      $3
n           IS      $4
k           IS      $5
kp          IS      $6


readln      SETW    rX, 1
read        INT     #80

            CMP     b, rA, 0
            JN      b, eof

            CMP     b, rA, 10
            JZ      b, nl
            CMP     b, rA, 13
            JZ      b, nl

            CMP     b, rA, 32
            JZ      b, sp
            CMP     b, rA, 9
            JZ      b, sp

            STBU    rA, m, 0
            ADD     m, m, 1
            ADD     k, k, 1
            ADD     kp, kp, 1
            OR      oc, rA, 0
            CMP     b, m, c
            JP      b, fullln
            JMP     read

sp          CMP     b, kp, 0
            JZ      b, read
            ADD     n, n, 1
            SUB     m, m, kp
            SUB     m, m, 1
            STB     kp, m, 0
            ADD     m, m, kp
            ADD     m, m, 2
            XOR     kp, kp, kp
            JMP     read

nl          CMP     b, m, 1
            JZ      b, empty
            CMP     b, oc, 10
            JZ      b, lastln
            CMP     b, oc, 13
            JZ      b, lastln
            OR      oc, rA, 0
            JMP     sp

eof         CMP     b, m, 1
            JP      b, lastln
            SETW    rA, #fffffffffffffffe
            RET     0

fullln      SUB     k, k, kp
            OR      rA, kp
            SUB     m, m, kp
            SUB     m, m, 1
            STB     kp, m, 0
            XOR     m, m, m
            RET     0
