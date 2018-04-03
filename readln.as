
*****
* Instância que recebe o valor numérico de c e o último kp da linha anterior
* Retorna kp da palavra excedente, -2 quando chegou ao final do texto ou -1
* quando chegou ao final do texto, mas ainda há algo para ser impresso
*****

EXTERN  readln


b           IS      $0              * variável booleana
c           IS      $1              * número de colunas
m           IS      $2              * posição atual da memória
n           IS      $3              * quantidade de palavras na linha atual
k           IS      $4              * quantidade de caracteres não-brancos na linha atual
kp          IS      $5              * quantidade de caracteres de uma palavra
oc          IS      $6              * caractere lido na iteração anterior (ignora espaços e tabulações)
bp          IS      $7              * variável auxiliar para carregar os valores passados pela intância chamadora


readln      SETW    rX, 1           * inicializando variáveis
            SUBU    bp, rSP, 24
            LDOU    c, bp, 0
            LDOU    kp, bp, 8

read        INT     #80             * lê caractere por caractere

            JN      rA, eof         * verifica se chegou ao fim do texto

            CMP     b, rA, 10       * verifica se é uma quebra de linha ou carriage return
            JZ      b, nl
            CMP     b, rA, 13
            JZ      b, nl

            CMP     b, rA, 32       * verifica se é um espaço ou uma tabulação
            JZ      b, sp
            CMP     b, rA, 9
            JZ      b, sp

            STBU    rA, m, 0        * caso contrário, armazena o caractere, e atualiza as variáveis
            ADD     k, k, 1
            ADD     kp, kp, 1
            OR      oc, rA, 0
            CMP     b, m, c
            JP      b, fullln
            ADD     m, m, 1
            JMP     read

sp          CMP     b, kp, 0        * executa quando se chega ao final de uma palavra
            JZ      b, read         * atualiza variáveis necessárias e armazena kp na memória
            ADD     n, n, 1
            SUB     m, m, kp
            SUB     m, m, 1
            STB     kp, m, 0
            ADD     m, m, kp
            ADD     m, m, 2
            XOR     kp, kp, kp
            JMP     read

nl          CMP     b, m, 1         * executa quando se encontra uma quebra de linha ou carriage return
            JZ      b, endnl        * verifica se linha é vazia
            CMP     b, oc, 10       * verifica se é a última linha de uma parágrafo
            JZ      b, endnl
            CMP     b, oc, 13
            JZ      b, endnl
            OR      oc, rA, 0       * caso contrário, trata como um espaço simples
            JMP     sp
endnl       OR      rA, kp, 0       * coloca 0 como valor de retorno
            JMP     end

eof         CMP     b, m, 1         * executa quando se chega ao final do arquivo
            JZ      b, endeof       * verifica se linha atual está vazia
            CMP     b, kp, 0        * verifica se a última palavra já está 'finalizada'
            JZ      b, end
            ADD     n, n, 1         * atualiza variáveis e armazena kp
            SUB     m, m, kp
            SUB     m, m, 1
            STB     kp, m, 0
            XOR     kp, kp, kp
            JMP     end
endeof      SUB     rA, rA, 1       * coloca -2 como valor de retorno, caso não haja mais o que imprimir
            JMP     end

fullln      SUB     k, k, kp        * executa quando já não cabem mais palavras em uma linha
            OR      rA, kp, 0       * retorna o valor atual de kp e armazena o mesmo na memória
            SUB     m, m, kp        * note que a palavra excedente ainda não foi lida totalmente (necessariamente)
            STB     kp, m, 0

end         XOR     m, m, m
            RET     2
