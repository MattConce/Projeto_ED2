            EXTERN  main
MAX         IS      10000
MAX_W       IS      500
MAX_l       IS      300
sav         IS      $255
ret         IS      $0
b           IS      $1
C           IS      $2
main        SUBU    C, rSP, 16
            LDOU    C, C, 0
            PUSH    C
            SAVE    sav, $1, $5
            CALL    atoi
            REST    sav, $1, $5
            OR      C, ret, 0
end         INT     0
