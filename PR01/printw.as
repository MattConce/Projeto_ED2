EXTERN  printw


sav         IS      $0
b           IS      $1
m           IS      $3
kp          IS      $4


printw      SETW    rX,2
            SUBU    kp, rSP, 16
            LDOU    kp, kp, 0

print       CMP     b, kp, 0
            JZ      b, end
            LDBU    rY, m, 0
            INT     #80
            ADD     m, m, 1
            SUB     kp, kp, 1
            JMP     print

end         RET     1
