EXTERN      main

b           IS      $0
c           IS      $1


main        SUBU    c, rSP, 16
            LDOU    c, c, 0
            SAVE    rSP, $0, $1
            PUSH    c
            CALL    atoi
            REST    rSP, $0, $1
            OR      c, rA, 0

            SAVE    rSP, $0, $1
            PUSH    c
            CALL    just
            REST    rSP, $0, $1

            INT     0
