EXTERN      main

sav         IS      $0
b           IS      $1
c           IS      $2


main        SUBU    c, rSP, 16
            LDOU    c, c, 0
            PUSH    c
            SAVE    sav, $1, $1
            CALL    atoi
            REST    sav, $1, $1
            OR      c, rA, 0

            PUSH    c
            SAVE    sav, $1, $1
            CALL    just
            REST    sav, $1, $1

            INT     0
