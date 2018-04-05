MAC0323 - Algoritmos e Estrutura de Dados II
================================================================================
PR01 - Justificação de textos
--------------------------------------------------------------------------------

**Autores**:

    Leonardo Ikeda      ()
    Matheus             ()
    Vitor Barbosa Sério (7627627)

Esse arquivo pode ser melhor vizualizado na página do nosso diretório no GitHub:

https://github.com/MattConce/Projeto_ED2

**Comandos para executar o programa**:

- Para gerar *just.mac*: `make`
- Para executar *just.mac*: `./macsim just.mac c < texto.txt`
(*c* é o número de colunas e *texto.txt* é o arquivo que contém o texto)


### 1. O Programa

Este é um projeto para a disciplina MAC0323 do Instituto de Matemática e
Estatística da Universidade de São Paulo. Ele consiste basicamente em um
programa que recebe um texto na entrada padrão e imprime o mesmo texto em
formato justificado na saída padrão com *c* colunas (*c* é passado como
argumento na linha de comando).


#### 1.1. Estratégia

A estratégia usada para o programa é simples:

O programa lê e armazena os caracteres até obter o suficiente para uma linha
de c caracteres, ou chegar ao final do parágrafo, ou perceber que é uma linha
vazia e, então, imprime a linha conforme necessário e continua a leitura e
armazenamento.

Para isso, os caracteres são armazenados com a seguinte estrutura de memória:

| n<sub>0</sub> | c<sub>00</sub> | c<sub>01</sub> | ... | c<sub>0(n<sub>0</sub>-1)</sub> | n<sub>1</sub> | c<sub>10</sub> | c<sub>11</sub> | ... |
|:-----:|:--------:|:--------:|:---:|:----------:|:-----:|:--------:|:--------:|:---:|

Onde n<sub>i</sub> representa o tamanho da i-ésima palavra da linha que está
sendo lida e c<sub>ij</sub> representa o j-ésimo caractere da mesma palavra
(cada um desses valores ocupa um *byte*). Assim, armazena-se todos os caracteres
e o tamanho de cada uma das palavras que irão compor a linha e, então, é feita
a impressão da mesma, de forma apropriada.


#### 1.2. Arquivos

- **just.as**:
    - Programa principal (*main*), que justifica o texto
    - Chama os programas contidos em:
        - **atoi.as**:
            - Recebe uma string representando um número inteiro e a converte
            para um inteiro.
            - Retorna o número resultante.
        - **justify.as**:
            - Lê e imprime, justificado, o texto passado na entrada padrão.
            - Recebe c, convertido para inteiro.
            - Chama os programas contidos em:
                - **readln.as**:
                    - Lê e armazena o texto na entrada padrão até completar uma
                    linha.
                    - Recebe c e o valor retornado na última linha lida (0, se
                    for a primeira linha)
                    - Retorna o tamanho da última palavra que estava sendo lida.
                - **println.as**:
                    - Imprime a última linha lida.
                    - Recebe c, o valor retornado por 'readln' e a quantidade de
                    caracteres não-brancos e de palavras da linha que será
                    impressa
                    - Chama os programas contidos em:
                        - **printws.as**:
                            - Imprime as n primeiras palavras armazenadas na
                            memória, separadas por sp espaços.
                            - Recebe os valores de n e sp.
                            - Chama os programas contidos em:
                                - **printw.as**:
                                    - Imprime a primeira palavra armazenada
                                    na memória.
                                    - Recebe o tamanho da palavra.
                                - **printsp.as**:
                                    - Imprime n espaços.
                                    - Recebe o valor de n.
                        - **printw.as**.


### 2. Makefile

O arquivo makefile contido nesse projeto tem como intuito facilitar a geração do
executável principal. Ele pode ser executado das seguintes formas:

- `make` ou `make just`: Gera o programa principal (*just.mac*) com todas as
suas dependências
- `make other`: Gera um programa *test.mac* a partir de um *test.as* (para
testes)
- `make other FILE=nome_do_arquivo`: Gera um programa *nome_do_arquivo.mac* a
partir de um *nome_do_arquivo.as*
- `make tar`: Cria uma pasta com o nomes dos autores, contendo este README, o
makefile e os programas necessários para gerar *just.mac*
- `make clean`: Remove todos os arquivos gerados pelas outras regras

É importante pontuar que, para que a regra geral funcione corretamente é
recomendável que os arquivos de teste sejam nomeados com prefixo *test* ou seja,
no formato *test_alguma_coisa.as*.

Além disso, os programas de teste gerados por esse makefile não podem possuir
outras dependências.
