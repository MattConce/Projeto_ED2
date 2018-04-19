MAC0323 - Algoritmos e Estrutura de Dados II
================================================================================
PR02 - Buffer
--------------------------------------------------------------------------------

**Autores**:

    Leonardo Martinez Ikeda  (10262822)
    Matheus Santos Conceição (10297672)
    Vitor Barbosa Sério       (7627627)


Esse arquivo pode ser melhor vizualizado na página do nosso diretório no GitHub:

https://github.com/MattConce/Projeto_ED2

**Comandos para executar o programa**:

- Para gerar *center*: `make`
- Para executar *center*: `./center arquivo_de_entrada arquivo_de_saida c`
(*c* é o número de colunas e *arquivo_de_entrada* e *arquivo_de_saída* são os
nomes dos arquivos que contém o texto de entrada e o no qual deve ser escrita a
saída, respectivamente)


### 1. O Programa

Este é um projeto para a disciplina MAC0323 do Instituto de Matemática e
Estatística da Universidade de São Paulo. Ele consiste basicamente em um
programa que lê um texto em um arquivo dado e imprime o mesmo texto centralizado
com *c* colunas num outro arquivo também dado (*c* e o nome dos arquivos são
passados como argumentos na linha de comando).

### 2. Makefile

O arquivo makefile contido nesse projeto tem como intuito facilitar a geração do
executável principal. Ele pode ser executado das seguintes formas:

- `make` ou `make center`: Gera o programa principal (*center*) com todas as
suas dependências
- `make tar`: Cria uma pasta com os nomes dos autores, contendo este README, o
makefile e os programas necessários para gerar *center*
- `make clean`: Remove todos os arquivos gerados pelas outras regras
