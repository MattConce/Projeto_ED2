        EXTERN main
c IS $0; p IS $1; cp IS $2; e IS $3; m IS $4; b IS $5; ct IS $6; oc IS $7; l IS $9; au IS $8
main    SETW    c, 0            *contador total de caracteres (sem espaço) por linha
        SETW    p, 0            *contador de palavras por linha
        SETW    cp, 0           *contador de caracteres de uma palavra
        SETW    e, 0            *contador de espacos entre as palavras (para imprimir)
        SETW    m, 2            *endereco atual de memoria
        SETW    b, 0            *variavel booleana
        SETW    ct, 0           *contagem total de caracteres na linha (inclui espacos)
        SETW    oc, 0           *armazena o caractere lido anteriormente
        SETW    au, 0           *registrador auxiliar
        SETW    l, 65           *quantidade de colunas por linha
read    SETW    rX, 1           *le um caractere por vez e armazena na memoria
        INT     #80
        JN      rA, ending      *finaliza o programa quando encontra EOF
        CMP     b, rA, 10       *verifica se rA e algum tipo de espaco
        JZ      b, nl
        CMP     b, rA, 32
        JZ      b, esp
        CMP     b, rA, 9
        JZ      b, esp
        STBU    rA, m, 0        *armazena o caractere na memoria
        OR      oc, rA, 0
        ADDU    m, m, 1         *atualiza as variaveis
        ADDU    c, c, 1
        ADDU    cp, cp, 1
        ADDU    ct, ct, 1
        CMPU    b, ct, l        *verifica se os caracteres excederam l
        JP      b, eol
        JMP     read
esp     OR      oc, rA, 0
        CMPU    b, cp, 0        *verifica se uma palavra estava sendo lida
        JP      b, eow
        JMP     read
nl      CMPU    b, oc, 10       *verifica se o caractere anterior tambem era \n
        JZ      b, eop
        JMP     esp
eow     ADDU    p, p, 1         *coloca cp no espaco imediatamente anterior ao da palavra respectiva
        ADDU    ct, ct, 1
        SUBU    m, m, cp
        SUBU    m, m, 1
        STBU    cp, m, 0
        ADDU    m, m, cp
        ADDU    m, m, 2
        XOR     cp, cp, cp
        JMP     read
eop     OR      oc, rA, 0       *finaliza um paragrafo
        CMP     b, ct, 0        *retorna pra read se nao houver o que imprimir
        JZ      b, read
        SETW    rX, 2
        XOR     m, m, m
eoplop1 XOR     cp, cp, cp      *loop para imrpimir cada palavra
        ADDU    m, m, 1
        LDBU    cp, m, 0
eoplop2 CMPU    b, cp, 0        *loop para imprimir cada caractere de uma palavra
        JZ      b, endlp2
        ADDU    m, m, 1
        LDBU    rY, m, 0
        INT     #80
        SUBU    cp, cp, 1
        JMP     eoplop2
endlp2  CMPU    b, p, 0         *verifica se e a ultima palavra na memoria
        JZ      b, endeop
        SETW    rY, 32          *adiciona um espaco apos uma palavra
        INT     #80
        JMP     eoplop1
endeop  SETW    rY, 10          *adiciona duas quebras de linha, finalizando o paragrafo
        INT     #80
        INT     #80
        JMP     read
eol     SETW    rX, 2           *justifica uma linha, que nao a ultima do paragrafo
        XOR     e, e, e         *calcula o minimo de espacos entre as palavras
        SUBU    e, l, c
        SUBU    p, p, 1
        DIVU    e, e, p
        ADDU    p, p, 1
        SUBU    m, m, cp        *armazena o cp da palavra excedente na memoria
        SUBU    m, m, 1
        STBU    cp, m, 0
        XOR     m, m, m         *volta para o inicio da memoria
eoloop1 CMPU    b, p, 0         *loop para imprimir cada palavra
        JZ      b, eolend
        XOR     cp, cp, cp
        ADDU    m, m, 1
        LDBU    cp, m, 0
eoloop2 CMPU    b, cp, 0        *loop para imprimir cada caractere de uma palavra
        JZ      b, prntesp
        ADDU    m, m, 1
        LDBU    rY, m, 0
        INT     #80
        SUBU    cp, cp, 1
        JMP     eoloop2
prntesp SETW    rY, 32          *parte para gerenciar a impressao de espacos
        OR      au, e, 0
        ADDU    rR, rR, 1
        CMPU    b, p, rR        *se ja estiver nas ultimas palavras, adiciona um espaco a mais
        JP      b, loopesp
        ADDU    au, au, 1
        SUBU    rR, rR, 1
loopesp CMPU    b, au, 0        *loop para imprimir cada espaco
        JZ      b, endesp
        INT     #80
        SUBU    au, au, 1
        JMP     loopesp
endesp  SUBU    rR, rR, 1       *finaliza a impressao de espacos
        SUBU    p, p, 1
        JMP     eoloop1
eolend  ADDU    m, m, 1         *inicializa a finalizacao da linha
        XOR     cp, cp, cp
        LDBU    cp, m, 0
        OR      au, cp, 0
        SUBU    ct, ct, cp
eolelp  CMPU    b, au, 0        *loop para passar a palavra excedente para o inicio da memoria
        JZ      b, eolenen
        ADDU    m, m, 1
        LDBU    rA, m, 0
        SUBU    m, m, ct
        STBU    rA, m, 0
        ADDU    m, m, ct
        SUBU    au, au, 1
        JMP     eolelp
eolenen ADDU    m, m, 1         *finaliza a impressao da linha e retorna pra read
        SUBU    m, m, ct
        XOR     p, p, p
        XOR     c, c, c
        OR      c, cp, 0
        XOR     ct, ct, ct
        SETW    rY, 10          *imprime uma quebra de linha
        INT     #80
        JMP     read
eof     CMP     b, c, 0         *finaliza a impressao do texto
        SETW    rX, 2           *verifica se ainda ha uma linha pra imprimir
        JZ      b, endeof
        XOR     m, m, m
eoflop1 XOR     cp, cp, cp      *loop para imprimir cada palavra
        ADDU    m, m, 1
        LDBU    cp, m, 0
eoflop2 CMPU    b, cp, 0        *loop para imprimir cada caractere de uma palavra
        JZ      b, endelp2
        ADDU    m, m, 1
        LDBU    rY, m, 0
        INT     #80
        SUBU    cp, cp, 1
        JMP     eoflop2
endelp2 CMPU    b, p, 0         *adiciona um espaco entre as palavras
        JZ      b, endelp1
        SETW    rY, 32
        INT     #80
        JMP     eoflop1
endelp1 SETW    rY, 10          *adiciona uma quebra de linha ao final da linha
        INT     #80
endeof  SETW    rY, 0           *adiciona um caractere nulo e encerra o programa
        INT     #80
        JMP     end
ending  JMP     eof
end     INT     0               *encerra o programa
