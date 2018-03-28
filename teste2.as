      EXTERN main



          text    IS    $1      *vetor guarda o texto inteiro
          c       IS    $2
          n       IS    $3
          tam     IS    $4
          p       IS    $5
          ln      IS    $6      *vetor de linhas
          pr      IS    $7
          d1      IS    $8
          d2      IS    $9
          tmp     IS    $10      *retgistrador temporario
          w       IS    $11      *vetor de palavras
          tmp1    IS    $12

*lê o texto inteiro e armazena em um vetor*

main          XOR     text, text, text
              SUBU    c, rSP, 16
              LDOU    c, c, 0
              LDBU    d1, c, 0
              LDBU    d2, c, 1
              STBU    c, d2, 0
              STBU    c, d1, 1
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
              JMP     paragraph
save_p        SETW    rX, 2
              SETW    rY, 10
              INT     #80
              SETW    rX, 2
              SETW    rY, 10
              INT     #80
              JMP     just
while2        CMPU    $0, text, 10
              JNZ     $0, while1
              ADDU    text, text, 1
              JMP     while2
end           INT     1

paragraph    CMPU    $0, text, tam
             JZ      $0, ret_p
             CMPU    $0, text, 10
             JNZ     $0, continue
             ADDU    tmp, text, 1
             CMPU    $0, tmp, 10
             JZ      $0, ret_p
             LDBU    p, text, 0
             ADDU    text, text, 1
             ADDU    p, p, 1
ret_p        SETB    p, 0x00
             ADDU    p, p, 1
             JMP     save_p

just         JMP    breakInWords
             OR     tmp, w, 0
             SUBU   w, w, w
             JMP    breakInLines
             CMPU   $0, ln, 0x00
             JZ     $0, ret_just
             JMP    formatLine
ret_just     JMP    while1
