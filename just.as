
*****
* Programa que recebe na entrada padrão um texto e imprime na saída padrão o
* mesmo texto, justificado, com c colunas (c é passado como argumento)
*****


EXTERN      main

b           IS      $0              * variável booleana
c           IS      $1              * número de colunas


main        SUBU    c, rSP, 16      * pega o valor de c
            LDOU    c, c, 0

            SAVE    rSP, $0, $1     * converte c de uma string para um número
            PUSH    c
            CALL    atoi
            REST    rSP, $0, $1
            OR      c, rA, 0

            SAVE    rSP, $0, $1     * justifica e imprime o texto
            PUSH    c
            CALL    just
            REST    rSP, $0, $1

            INT     0
