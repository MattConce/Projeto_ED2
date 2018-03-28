        EXTERN main
c       IS      $0              *quantidade de colunas por linha
n       IS      $1              *contador de palavras por linha
k       IS      $2              *contador total de caracteres (sem espaço) por linha
kp      IS      $3              *contador de caracteres de uma palavra
ko      IS      $4              *armazena o caractere lido anteriormente
N       IS      $5              *contador de espacos entre as palavras (para imprimir)
m       IS      $6              *endereco atual de memoria (tambem conta a quantidade de caracteres na linha)
b       IS      $7              *variavel booleana
a1      IS      $8              *registrador auxiliar 1
a2      IS      $9              *registrador auxiliar 2
main    SETW    c, 10
        SETW    n, 0
        SETW    k, 0
        SETW    kp, 0
        SETW    ko, 0
        SETW    N, 0
        SETW    m, 1
        SETW    b, 0
        SETW    a1, 0
        SETW    a2, 0
        *INT     #DB0009
read    SETW    rX, 1           *le um caractere por vez e armazena na memoria
        INT     #80
        JN      rA, eof         *finaliza o programa quando encontra EOF
        CMP     b, rA, 10       *verifica se rA e algum tipo de espaco
        JZ      b, readnl
        CMP     b, rA, 32
        JZ      b, readsp
        CMP     b, rA, 9
        JZ      b, readsp
        STBU    rA, m, 0        *armazena o caractere na memoria
        OR      ko, rA, 0
        ADDU    k, k, 1         *atualiza as variaveis
        ADDU    kp, kp, 1
        *INT     #DB0206
        CMPU    b, m, c         *verifica se os caracteres excederam c
        JP      b, eol
        ADDU    m, m, 1
        JMP     read
readsp  OR      ko, rA, 0
        CMPU    b, kp, 0        *verifica se uma palavra estava sendo lida
        JP      b, eow
        JMP     read
readnl  CMPU    b, m, 1         *verifica se é uma quebra de linha entre parágrafos
        JZ      b, emptynl
        CMPU    b, ko, 10       *verifica se é uma quebra de linha no final do parágrafo
        JZ      b, eop
        JMP     readsp          *quebra de linha no meio do parágrafo
emptynl SETW    rX, 2           *imprime uma linha vazia
        SETW    rY, 10
        INT     #80
        JMP     read
eow     ADDU    n, n, 1         *coloca kp no espaco imediatamente anterior ao da palavra respectiva
        SUBU    m, m, kp
        SUBU    m, m, 1
        STBU    kp, m, 0
        ADDU    m, m, kp
        ADDU    m, m, 2
        XOR     kp, kp, kp
        JMP     read
eop     OR      ko, rA, 0       *finaliza um paragrafo
        SETW    rX, 2
        XOR     m, m, m
eoplop1 XOR     kp, kp, kp      *loop para imrpimir cada palavra
        LDBU    kp, m, 0
        ADDU    m, m, 1
eoplop2 CMPU    b, kp, 0        *loop para imprimir cada caractere de uma palavra
        JZ      b, endlp2
        LDBU    rY, m, 0
        INT     #80
        SUBU    kp, kp, 1
        ADDU    m, m, 1
        JMP     eoplop2
endlp2  CMPU    b, n, 0         *verifica se e a ultima palavra na memoria
        JZ      b, endeop
        SETW    rY, 32          *adiciona um espaco apos uma palavra
        INT     #80
        JMP     eoplop1
endeop  SETW    rY, 10          *adiciona duas quebras de linha, finalizando o paragrafo
        INT     #80
        INT     #80
        JMP     read
eol     SETW    rX, 2           *justifica uma linha, que nao a ultima do paragrafo
        SUBU    m, m, kp        *armazena o kp da palavra excedente na memoria
        SUBU    m, m, 1
        STBU    kp, m, 0
        XOR     m, m, m         *volta para o inicio da memoria
        XOR     kp, kp, kp
        *INT     #DB0606
        LDBU    kp, m, 0
        *INT     #DB0303
        SUBU    n, n, 1         *verifica se ha mais de uma palavra na linha
        *INT     #DB0101
        CMPU    b, n, 0
        JZ      b, lastp
        XOR     N, N, N         *calcula o minimo de espacos entre as palavras
        SUBU    N, c, k
        DIVU    N, N, n
eoloop1 XOR     kp, kp, kp      *loop para imprimir cada palavra
        LDBU    kp, m, 0
        ADDU    m, m, 1
        CMPU    b, n, 0
        JZ      b, lastp
eoloop2 CMPU    b, kp, 0        *loop para imprimir cada caractere de uma palavra
        JZ      b, prntesp
        LDBU    rY, m, 0
        INT     #80
        SUBU    kp, kp, 1
        ADDU    m, m, 1
        JMP     eoloop2
prntesp SETW    rY, 32          *parte para gerenciar a impressao de espacos
        OR      a1, N, 0
        ADDU    rR, rR, 1
        CMPU    b, n, rR        *se ja estiver nas ultimas palavras, adiciona um espaco a mais
        JP      b, loopesp
        ADDU    a1, a1, 1
        SUBU    rR, rR, 1
loopesp CMPU    b, a1, 0        *loop para imprimir cada espaco
        JZ      b, endesp
        INT     #80
        SUBU    a1, a1, 1
        JMP     loopesp
endesp  SUBU    n, n, 1         *finaliza a impressao de espacos
        JMP     eoloop1
lastp   CMP     b, kp, 0        *imprime a ultima palavra da linha
        JZ      b, eolend
        LDBU    rY, m, 0
        INT     #80
        SUBU    kp, kp, 1
        ADDU    m, m, 1
        JMP     lastp
eolend  XOR     kp, kp, kp      *inicializa a finalizacao da linha
        LDBU    kp, m, 0
        OR      a1, kp, 0
        OR      a2, m, 0
        XOR     m, m, m
eolelp  CMPU    b, a1, 0        *loop para passar a palavra excedente para o inicio da memoria
        JZ      b, eolenen
        ADDU    m, m, 1
        LDBU    rA, m, 0
        SUBU    m, m, a2
        STBU    rA, m, 0
        ADDU    m, m, a2
        SUBU    a1, a1, 1
        JMP     eolelp
eolenen ADDU    m, m, 1         *finaliza a impressao da linha e retorna pra read
        SUBU    m, m, a2
        XOR     n, n, n
        OR      k, kp, 0
        SETW    rY, 10          *imprime uma quebra de linha
        INT     #80
        JMP     read
eof     CMP     b, k, 0         *finaliza a impressao do texto
        JZ      b, endeof       *pula pro final caso nao haja o que imprimir
        SETW    rX, 2
        XOR     m, m, m
eoflop1 CMP     b, n, 0         *loop para imprimir cada palavra
        JZ      b, endelp1
        XOR     kp, kp, kp
        LDBU    kp, m, 0
        ADDU    m, m, 1
eoflop2 CMPU    b, kp, 0        *loop para imprimir cada caractere de uma palavra
        JZ      b, endelp2
        LDBU    rY, m, 0
        INT     #80
        SUBU    kp, kp, 1
        ADDU    m, m, 1
        JMP     eoflop2
endelp2 CMPU    b, n, 0         *adiciona um espaco entre as palavras
        JZ      b, endelp1
        SETW    rY, 32
        INT     #80
        SUBU    n, n, 1
        JMP     eoflop1
endelp1 SETW    rY, 10          *adiciona uma quebra de linha ao final da linha
        INT     #80
endeof  SETW    rY, 0           *adiciona um caractere nulo e encerra o programa
        INT     #80
        JMP     end
end     INT     0               *encerra o programa
