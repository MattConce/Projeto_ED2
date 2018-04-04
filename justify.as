
*****
* Instância que recebe o valor numérico de c, justifica e imprime o texto
*****

EXTERN  just


b           IS      $0              * variável booleana
c           IS      $1              * número de colunas
m           IS      $2              * indica a posição atual da memória
n           IS      $3              * quantidade de palavras que será impressa na linha atual
k           IS      $4              * quantidade de caracteres não-brancos na linha atual
kp          IS      $5              * quantidade de caracteres de uma palavra
a1          IS      $6              * variáveis auxiliares
a2          IS      $7
a3          IS      $8


just        XOR     b, b, b         * inicializando as variáveis
            SETW    m, 1

            SUBU    c, rSP, 16
            LDOU    c, c, 0

            XOR     kp, kp, kp

read        XOR     n, n, n         * começa a ler uma linha
            OR      kp, a3, 0
            OR      k, kp, 0
            XOR     a3, a3, a3

            SAVE    rSP, $5, $7     * lê uma linha até a mesma ficar "cheia" ou
            PUSH    c               * se concluir que é uma linha vazia
            PUSH    kp
            CALL    readln
            REST    rSP, $5, $7
            OR      kp, rA, 0       * pega o valor de retorno (kp da palavra excedente)

            XOR     a1, a1, a1      * verifica se chegou ao final do arquivo
            SUB     a1, a1, 1
            CMP     b, kp, a1
            JZ      b, eof          * caso quando ainda há uma linha para ser impressa
            JN      b, end          * caso quando não há mais nada para imprimir e é só encerrar

print       SAVE    rSP, $1, $1     * imprime uma linha (vazia ou não)
            SAVE    rSP, $3, $8
            PUSH    n
            PUSH    c
            PUSH    k
            PUSH    kp
            CALL    println
            REST    rSP, $3, $8
            REST    rSP, $1, $1
            OR      a1, m, 0
            XOR     m, m, m
            OR      a3, kp, 0

reset       CMP     b, kp, 0        * arruma a memória para começar a ler a próxima linha
            JN      b, read         * (passa os caracteres da palavra excedente para o início da memória)
            LDBU    a2, a1, 0
            STBU    a2, m, 0
            SUB     kp, kp, 1
            ADD     m, m, 1
            ADD     a1, a1, 1
            JMP     reset

eof         SAVE    rSP, $1, $1     * imprime a última linha do arquivo e encerra
            SAVE    rSP, $3, $8
            PUSH    n
            PUSH    c
            PUSH    k
            PUSH    kp
            CALL    println
            REST    rSP, $3, $8
            REST    rSP, $1, $1

end         SETW    rX, 2           * encerra a impressão
            SETW    rY, 0
            INT     #80
            RET     1
