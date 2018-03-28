*****JUSTIFICADOR DE ESJPAÇO*****
********************************************************
        EXTERN  main

****Variáveis*******************************************

        k     IS      $1       *contador de caracteres marcará também o indice do vetor de chars
        n     IS      $2       *futuro contador de palavras
        ln    IS      $3
        i     IS      $4
        c     IS      $5       *argumento da linha de comando
        N     IS      $6
        s     IS      $7
     text     IS      $8   

main      XOR     k, k, k
          SUBU    c, rSP, 16
          LDOU    c, c, 0        *lê o argumentos da linha de comando
read      SETW    rX, 1
          INT     #80
          CMPU    $0, rA, 0      *verifica se chegou ao final do arquivo
          JN      $0, end
          XOR     $0, $0, $0
          CMPU    $0, rA, 10
          JZ      $0, write
          OR      ln, rA, 0
          STBU    ln, k, 0
          CMPU    $0, rA, 32
          JNP     $0, continue
          STOU    ln, n, 0
          ADDU    n, n, 8
continue  ADDU    k, k, 1
          JMP     read
write     SETW    rX, 2
          OR      i, k, 0
          SUBU    N, c, n           *calcula N
          ADDU    N, N, 1
          SUBU    n, n, 1           *calcula N
          SUBU    k, k, k           *volta ao início do vetor
next      LDBU    rY, k, 0
          CMPU    $0, rY, 32
          JNZ     $0, n_space
          SETW    rY, 32
          XOR     s, s, s
          DIVU    s, N, n
          ADDU    s, s, 1
next_s    INT     #80
          SUBU    s, s, 1
          CMPU    $0, s, 0
          JNZ     $0, next_s
n_space   XOR     $0, $0, $0
          INT     #80
          ADDU    k, k, 1
          CMPU    $0, i, k
          JZ      $0, end
          JMP     next
end       SETW    rY, 10
          INT     #80
          INT     0
