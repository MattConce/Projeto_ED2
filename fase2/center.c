#include <stdio.h>
#include <stdlib.h>
#include "buffer.h"


int main(int argc, char const *argv[]) {

    // argumentos passados na linha de comando
    FILE *in = fopen(argv[1], "r");
    FILE *out = fopen(argv[2], "w");
    int c = atoi(argv[3]);

    // inicializando o buffer e variáveis auxiliares
    Buffer *B = buffer_create(sizeof(char));
    char lc = '\n';
    int line = 0;

    while (!feof(in)) {

        line++;

        int n = read_line(in, B);

        // determinando a quandidade de espaços para se adicionar à esquerda
        int sp;
        if (n > c) {
            fprintf(stderr, "center: %s: line %d: line too long.\n", argv[1], line);
            sp = 0;
        } else if (n == 0) {
            sp = 0;
        } else sp = (c - n) / 2;

        // imprime os espaços à esquerda
        for (int i = 0; i < sp; i++) {
            fprintf(out, " ");
        }

        // pega o último caractere lido
        lc = *((char *) B->data + B->p);

        printf("%3d: n = %3d, sp = %3d, lc = %3d, p = %3d\n", line, n, sp, (int) lc, (int) B->p);

        // imprime a linha no arquivo de saida
        fprintf(out, "%s", ((char *) B->data + 1));
    }

    // fecha os arquivos
    fclose(in);
    fclose(out);

    return 0;
}
