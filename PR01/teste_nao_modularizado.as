        EXTERN  main
        k     IS      $1       *contador de caracteres marcará também o indice do vetor de chars
        n     IS      $2
        ln    IS      $3
        i     IS      $4
*##########################################
main    XOR     $0, $0, $0
        XOR     k, k, k
        SETW    rX, 1
read     INT     #80
        CMPU    $0, rA, 10
        JZ      $0, write
        STBU    rA, ln, k
        ADDU    k, k, 1
        JMP     read
write   SETW    rX, 2
        SUBU    rR, ln, k          *volta ao início do vetor
        OR      i, k, 0            *condição de parada
        XOR     k, k, k
next    LDBU    rY, rR, k
        INT     #80
        ADDU    k, k, 1
        CMP     $0, k, i
        JZ      $0, end
        JMP     next
end     INT     0
