
*****
* Instância que recebe a quantidade de plavras (n) para imprimir, junto com a
* quantidade de espaços para adicionar ao final de cada uma dessas palavras (sp)
*****

EXTERN  printws


b           IS      $0              * variável booleana
m           IS      $2              * posição atual da memória
n           IS      $3              * quantidade de palavras para serem impressas
sp          IS      $4              * quantidade de espaços entre as palavras
bp          IS      $5              * variável auxiliar para carregar os valores passados pela intância chamadora
kp          IS      $6              * tamanho da palavra atual


printws     SETW    rX, 2           * inicializando as variáveis
            SUBU    bp, rSP, 24
            LDOU    n, bp, 0
            LDOU    sp, bp, 8

print       CMP     b, n, 0         * imprime as pavras com os espaços
            JZ      b, end
            LDB     kp, m, 0
            ADD     m, m, 1
            SAVE    rSP, $3, $3     * imprime a palavra atual
            PUSH    kp
            CALL    printw
            REST    rSP, $3, $3
            PUSH    sp              * imprime os espaços
            CALL    printsp
            SUB     n, n, 1
            JMP     print

end         RET     2
