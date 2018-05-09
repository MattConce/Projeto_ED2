
*****
* Instância que recebe o valor numérico de c, o último kp da linha atual, k da
* linha atual e n da linha atual.
* Imprime a linha atual de forma apropriada e não retorna valores
*****

EXTERN  println


b           IS      $0                  * variável booleana
c           IS      $1                  * número de colunas
m           IS      $2                  * posição atual da memória
k           IS      $3                  * quantidade de caracteres não-brancos na linha atual
n           IS      $4                  * quantidade de palavras na linha atual
N           IS      $5                  * quantidade de espaços para se inserir entre palavras
f           IS      $6                  * quantidade de palavras no início (terão N espaços entre si)
l           IS      $7                  * quantidade de palavras no final (terão N+1 espaços entre si)
kp          IS      $8                  * quantidade de caracteres de uma palavra
bp          IS      $9                  * variável auxiliar para carregar os valores passados pela intância chamadora
lln         IS      $10                 * indica se é a última linha de um parágrafo
eof         IS      $11                 * indica se é a última linha do arquivo


println     SETW    rX, 2               * inicializando as variáveis
            SUBU    bp, rSP, 40
            LDOU    n, bp, 0
            LDOU    c, bp, 8
            LDOU    k, bp, 16
            LDOU    kp, bp, 24

            XOR     lln, lln, lln
            CMP     b, kp, 0            * verifica se já está no final do arquivo
            JN      b, eofln
            XOR     eof, eof, eof

            CMP     b, n, 0             * verifica se é uma linha vazia
            JZ      b, end

            CMP     b, kp, 0            * verifica se é a última linha de um parágrafo
            JZ      b, lastln

            CMP     b, n, 1             * verifica se linha contém apenas uma palavra
            JZ      b, lastw

            SUB     n, n, 1             * caso contrário, calcula os valores de N, f e l
            SUB     N, c, k             * (note que f+l = n-1, pois a última palavra é impressa separadamente)
            DIV     N, N, n
            SUB     f, n, rR
            OR      l, rR, 0

start       SAVE    rSP, $3, $6         * imprime as primeiras palavras com N espaço entre elas
            PUSH    f
            PUSH    N
            CALL    printws
            REST    rSP, $3, $6

            ADD     N, N, 1

            SAVE    rSP, $3, $6         * imprime as últimas palavras com N+1 espaços entre elas
            PUSH    l
            PUSH    N
            CALL    printws
            REST    rSP, $3, $6

lastw       LDB     kp, m, 0            * imprime a última palavra de uma linha
            ADD     m, m, 1             * (não adiciona espaço após a mesma)
            SAVE    rSP, $3, $3
            PUSH    kp
            CALL    printw
            REST    rSP, $3, $3

end         SETW    rY, 10              * finaliza imprimindo uma quebra de linha
            INT     #80
            JP      eof, ret            * caso o arquivo esteja acabando, ignora a impressão de mais uma linha
            JZ      lln, ret            * caso seja o fim de um parágrafo, adiciona mais uma quebra de linha
            INT     #80
ret         RET     4

lastln      SETW    N, 1                * executa quando a linha atual é a última de um parágrafo
            SUB     f, n, 1             * faz mesma coisa que numa linha normal, mas fixa N = 1
            SAVE    rSP, $3, $6
            PUSH    f
            PUSH    N
            CALL    printws
            REST    rSP, $3, $6
            SETW    lln, 1
            JMP     lastw

eofln       SETW    eof, 1              * executa quando a linha atual é a última do arquivo
            XOR     kp, kp, kp
            JMP     lastln
