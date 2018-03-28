            EXTERN  main


MAX         IS      10000
MAX_W       IS      500
MAX_l       IS      300

sav         IS      $0
ret         IS      $1
b           IS      $2
C           IS      $3
text        IS      $4
n           IS      $5
curr        IS      $6


main        SUBU    C, rSP, 16
            LDOU    C, C, 0
            PUSH    C
            SAVE    sav, $2, $6
            CALL    atoi
            REST    sav, $2, $6
            OR      C, ret, 0
            XOR     n, n, n
end         INT     0
