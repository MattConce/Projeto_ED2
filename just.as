              EXTERN  main
MAX             IS      10000
MAX_W         IS      500
MAX_l         IS      300
sav           IS      $200
b             IS      $0
C             IS      $2
ret           IS      rA
ret2          IS      $103
text          IS      $100
p             IS      $101     *reservado para os paragrafos
tam           IS      $102     *reservado para o texto
n             IS      $105
k             IS      $106
hello         STR     "hello\n"


main          SUBU    C, rSP, 16
              LDOU    C, C, 0
              SAVE    sav, $1, $5
              PUSH    C
              CALL    atoi
              REST    sav, $1, $5
              OR      C, ret, 0
              SAVE    sav, $1, $5
              CALL    read
              REST    sav, $1, $5
              OR      text, ret, 0
              OR      tam, ret2, 0
              INT     #DB6464
              SUB     text, text, text
              SAVE    sav, $1, $5
              PUSH    text
              PUSH    tam
              CALL    puts
              REST    sav, $1, $5
while1        CMP     $0, text, tam
              JZ      $0, end
paragraph     SAVE    sav, $1, $10
              PUSH    text
              PUSH    tam
              CALL    readParagraph
              REST    sav, $1, $10
              OR      p, ret, 0
              OR      k, ret2, 0
              ADDU    n, n, k
              SUB     p, p, p
              SAVE    sav, $1, $5
              PUSH    p
              PUSH    k
              CALL    puts
              REST    sav, $1, $5
              SETW    rX, 2
              SETW    rY, 10
              INT     #80
              SETW    rX, 2
              SETW    rY, 10
              INT     #80
              SAVE    sav, $0, $8
              PUSH    p
              PUSH    C
              CALL    justificador
              REST    sav, $0, $8
while2        CMPU    $0, text, 10
              JNZ     $0, while1
              ADDU    text, text, 1
              JMP     while2
end           INT     1
