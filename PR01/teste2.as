      EXTERN main



          text    IS    $1
          c       IS    $2
          n       IS    $3
          tam     IS    $4
          p       IS    $5
          len     IS    $6

*lê o texto inteiro e armazena em um vetor*

main          XOR     text, text, text
              SUBU    c, rSP, 16
              LDOU    c, c, 0
read          SETW    rX, 1
              INT     #80
              CMPU    $0, rA, 0
              JN      $0, paragraph
              STBU    rA, text, 0
              ADDU    text, text, 1
              JMP     read
start         OR      tam, text, 0
              SUBU    text, text, text
while1        CMPU    $0, text, tam
              JZ      $0, end
              PUSH    text
              PUSH    tam
              CALL    paragraph
              SETW    rX, 2
              SETW    rY, 10
              int     #80
              SETW    rX, 2
              SETW    rY, 10
              int     #80
              OR      p, rA, 0
              PUSH    p
              CALL    strlen
              OR      len, rA, 0
              PUSH    p
              PUSH    c
              PUSH    len
              CALL    just
while2        CMPU    $0, text, 10
              JNZ     $0, while1
              ADDU    text, text, 1
              JMP     while2
end           int     1
