
*****
* Instância que recebe a quantidade de espaços para imprimir (n) e os imprime
*****

EXTERN  printsp


b           IS      $0              * variável booleana
n           IS      $1              * quantidade de espaços para se imprimir


printsp     SETW    rX,2            * inicializando as variáveis
            SETW    rY, 32
            SUBU    n, rSP, 16
            LDOU    n, n, 0

print       CMP     b, n, 0         * impressão dos n espaços
            JZ      b, end
            INT     #80
            SUB     n, n, 1
            JMP     print

end         RET     1
