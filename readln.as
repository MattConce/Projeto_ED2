EXTERN  readln


b           IS      $0
c           IS      $1
m           IS      $2
n           IS      $3
k           IS      $4
kp          IS      $5
oc          IS      $6
bp          IS      $7


readln      SETW    rX, 1
            SUBU    bp, rSP, 24
            LDOU    c, bp, 0
            LDOU    kp, bp, 8

read        INT     #80

            JN      rA, eof

            CMP     b, rA, 10
            JZ      b, nl
            CMP     b, rA, 13
            JZ      b, nl

            CMP     b, rA, 32
            JZ      b, sp
            CMP     b, rA, 9
            JZ      b, sp

            STBU    rA, m, 0
            ADD     k, k, 1
            ADD     kp, kp, 1
            OR      oc, rA, 0
            CMP     b, m, c
            JP      b, fullln
            ADD     m, m, 1
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
            JZ      b, endnl
            CMP     b, oc, 10
            JZ      b, endnl
            CMP     b, oc, 13
            JZ      b, endnl
            OR      oc, rA, 0
            JMP     sp
endnl       OR      rA, kp, 0
            JMP     end

eof         CMP     b, m, 1
            JZ      b, endeof
            CMP     b, kp, 0
            JZ      b, end
            ADD     n, n, 1
            SUB     m, m, kp
            SUB     m, m, 1
            STB     kp, m, 0
            XOR     kp, kp, kp
            JMP     end
endeof      SUB     rA, rA, 1
            JMP     end

fullln      SUB     k, k, kp
            OR      rA, kp, 0
            SUB     m, m, kp
            STB     kp, m, 0

end         XOR     m, m, m
            RET     2
