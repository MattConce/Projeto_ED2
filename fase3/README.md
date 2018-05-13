MAC0323 - Algoritmos e Estrutura de Dados II
================================================================================
PR03 - Parte III: Tabela de símbolos
--------------------------------------------------------------------------------

**Autores**:

    Leonardo Martinez Ikeda  (10262822)
    Matheus Santos Conceição (10297672)
    Vitor Barbosa Sério       (7627627)


Esse arquivo pode ser melhor vizualizado na página do nosso diretório no GitHub:

https://github.com/MattConce/Projeto_ED2

**Comandos para executar o programa**:

- Para gerar *freq*: `make`
- Para executar *freq*: `./freq arquivo_de_entrada`
(*arquivo_de_entrada* contém o texto de entrada cujas palavras serão contadas
  pelo freq e impressas na saída padrão)



### 1. O Programa

Este é um projeto para a disciplina MAC0323 do Instituto de Matemática e
Estatística da Universidade de São Paulo. Ele consiste basicamente em um
programa que lê um texto em um arquivo dado e imprime a frequência com que cada
palavra do texto ocorre).

### 2. Makefile

O arquivo makefile contido nesse projeto tem como intuito facilitar a geração do
executável principal. Ele pode ser executado das seguintes formas:

- `make` ou `make freq`: Gera o programa principal (*freq*) com todas as
suas dependências
- `make tar`: Cria uma pasta com os nomes dos autores, contendo este README, o
makefile e os programas necessários para gerar *freq*
- `make clean`: Remove todos os arquivos gerados pelas outras regras
