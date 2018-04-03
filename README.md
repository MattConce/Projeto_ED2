# MAC0323 - Algoritmos e Estrutura de Dados II
## PR01 - Justificação de textos

**Autores**:

    Leonardo Ikeda      ()
    Matheus             ()
    Vitor Barbosa Sério (7627627)


**Comandos para executar o programa**:

- Para gerar o executável: `make`
- Para executar o arquivo: `./macsim main.mac c < texto.txt`


### 1. O Programa

Este é um projeto para a disciplina MAC0323 do Instituto de Matemática e
Estatística da Universidade de São Paulo. Ele consiste basicamente em um
programa que recebe um texto na entrada padrão e imprime o mesmo texto em
formato justificado na saída padrão com *c* colunas (*c* é passado como
argumento na linha de comando).


#### 1.1 Estratégia

A estratégia usada para o programa é simples:

O programa lê e armazena os caracteres até obter o suficiente para uma linha
de c caracteres, ou chegar ao final do parágrafo, ou perceber que é uma linha
vazia e, então, imprime a linha conforme necessário e continua a leitura e
armazenamento.

Para isso, os caracteres são armazenados com a seguinte estrutura de memória:

| $n_0$ | $c_{00}$ | $c_{01}$ | ... | $c_{0n_0}$ | $n_1$ | $c_{10}$ | $c_{11}$ | ... |
|:-----:|:--------:|:--------:|:---:|:----------:|:-----:|:--------:|:--------:|:---:|

Onde $n_i$ representa a $i$-ésima palavra da linha que está sendo lido e
$c_{ij}$ representa o $j$-ésimo caractere da mesma palavra.
