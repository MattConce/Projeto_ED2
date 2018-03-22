        EXTERN  main
        *variáveis
        k     IS      $1       *contador de caracteres marcará também o indice do vetor de chars
        n     IS      $2       *futuro contador de palavras
        ln    IS      $3
        i     IS      $4

main    XOR     k, k, k
read    SETW    rX, 1
        INT     #80
        CMPU    $0, rA, 10
        JZ      $0, write
        OR      ln, rA, 0
        STBU    ln, k, 0
        ADDU    k, k, 1
        JMP     read
write   SETW    rX, 2
        OR      i, k, 0           *condição de parada
        SUBU    k, k, k           *volta ao início do vetor
next    LDBU    rY, k, 0
        INT     #80
        ADDU    k, k, 1
        XOR     $0, $0, $0
        CMPU    $0, k, i
        JZ      $0, end
        JMP     next
end     SETW    rY, 10
        INT     #80
        INT     0
