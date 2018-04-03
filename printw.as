
*****
* Instância que recebe a quantidade de caracteres da palavra atual armazenada
* na memória (kp) e imprime a mesma
*****

EXTERN  printw


b           IS      $0                  * variável booleana
m           IS      $2                  * posição atual da memória
kp          IS      $3                  * tamanho da palavra atual


printw      SETW    rX,2                * inicializando as variáveis
            SUBU    kp, rSP, 16
            LDOU    kp, kp, 0

print       CMP     b, kp, 0            * imprime os kp caracteres da palavra
            JZ      b, end
            LDBU    rY, m, 0
            INT     #80
            ADD     m, m, 1
            SUB     kp, kp, 1
            JMP     print

end         RET     1
