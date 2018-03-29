              EXTERN  main
MAX             IS      10000
MAX_W         IS      500
MAX_l         IS      300
sav           IS      $255
ret           IS      rA
b             IS      $0
C             IS      $2
ret2          IS      $4
text          IS      $100
p             IS      $101     *reservado para os paragrafos
tam           IS      $102     *reservado para o texto


main          SUBU    C, rSP, 16
              LDOU    C, C, 0
              *INT     #DB0202
              PUSH    C
              SAVE    sav, $1, $5
              CALL    atoi
              REST    sav, $1, $5
              OR      C, ret, 0
              SAVE    sav, $1, $5
              CALL    read
              INT     #DB0202
              OR      text, ret, 0
              REST    sav, $1, $5
start         OR      tam, text, 0
              SUBU    text, text, text
while1        CMPU    $0, text, tam
              JZ      $0, end
paragraph     PUSH    text
              PUSH    p
              SAVE    sav, $0, $5
              CALL    readParagraph
              OR      p, ret, 0
              OR      text, ret2, 0
              REST    sav, $0, $5
              SETW    rX, 2
              SETW    rY, 10
              INT     #80
              SETW    rX, 2
              SETW    rY, 10
              INT     #80
              PUSH    p
              PUSH    C
              SAVE    sav, $0, $8
              CALL    justificador
              REST    sav, $0, $8
while2        CMPU    $0, text, 10
              JNZ     $0, while1
              ADDU    text, text, 1
              JMP     while2
end           INT     1
