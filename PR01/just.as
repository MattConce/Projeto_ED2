EXTERN  main


MAX         IS      10000
MAX_W       IS      500
MAX_l       IS      300

sav         IS      $0
b           IS      $1
c           IS      $2
text        IS      $3
n           IS      $4
curr        IS      $5
tam         IS      $6


main        SUBU    c, rSP, 16
            LDOU    c, c, 0
            PUSH    c
            SAVE    sav, $1, $5
            CALL    atoi
            REST    sav, $1, $5
            OR      c, rA, 0

            XOR     n, n, n
            SETW    text, 300
            CALL    read
            SUB     text, text, n
            OR      tam, n, 0
            XOR     n, n, n

while1      CMP     b, n, tam
            JZ      b, end
            PUSH    text
            PUSH    p
            SAVE    sav, $1, $6
            CALL    readParagraph
            REST    sav, $1, $6
            SETW    rX, 2
            SETW    rY, 10
            INT     #80
            INT     #80
            PUSH    p
            PUSH    c
            SAVE    sav, $1, $10
            CALL    justificador
            REST    sav, $1, $10
while2      CMPU    b, text, 10
            JNZ     b, while1
            ADDU    text, text, 1
            JMP     while2

end         INT     0
