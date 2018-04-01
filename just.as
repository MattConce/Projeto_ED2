              EXTERN  main
MAX             IS      10000
MAX_W         IS      500
MAX_l         IS      300
sav           IS      $200
b             IS      $0
C             IS      $107
ret           IS      rA
ret2          IS      $103
text          IS      $100
p             IS      $101     *reservado para os paragrafos
tam           IS      $102     *reservado para o texto
n             IS      $105
k             IS      $106
len_w         IS      $107
hello         STR     "hello\n"


main          SUBU    C, rSP, 16
              LDOU    C, C, 0
              SAVE    rSP, $1, $5
              PUSH    C
              CALL    atoi
              REST    rSP, $1, $5
              OR      C, ret, 0
              SAVE    rSP, $1, $5
              CALL    read
              REST    rSP, $1, $5
              OR      text, ret, 0
              OR      tam, ret2, 0
              SUB     text, text, text
while1        CMP     $0, text, tam
              JZ      $0, end
paragraph     SAVE    rSP, $1, $10
              PUSH    tam
              CALL    readParagraph
              REST    rSP, $1, $10
              INT     #DB6B6B
              OR      p, ret, 0
              OR      k, ret2, 0
              ADDU    n, n, k
              SUB     p, p, p
              SAVE    rSP, $1, $7
              PUSH    p
              PUSH    k
              CALL    puts
              REST    rSP, $1, $7
              SETW    rX, 2
              SETW    rY, 10
              INT     #80
              SETW    rX, 2
              SETW    rY, 10
              INT     #80
              SUB     p, p, p
              SAVE    rSP, $0, $11
              PUSH    C
              PUSH    k
              CALL    justificador
              REST    rSP, $0, $11
while2        CMPU    $0, text, 10
              JNZ     $0, while1
              ADDU    text, text, 1
              JMP     while2
end           INT     1
