#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "stable_s.h"
#include "stable.h"

static int compare (const void* s, const void* t) {
  const char* p = *(const char**)s;
  const char* q = *(const char**)t;
  return strcmp(p, q);
}

// funções visit não utilizadas nessa versão

/*int print_key_int_spaced(const char *key, EntryData *data) {
  int size = strlen(key);
  return size;
}

int print_key_int(const char *key, EntryData *data) {
  printf("%s %d\n", key, data->i);
  return 1;
  }*/

int main(int argc, char const *argv[]) {

  // abrindo um pipe no qual imprimiremos todas as palavras
  int fd[2];
  pipe(fd);
  FILE *write = fdopen(fd[1], "w");
  FILE *read = fdopen(fd[0], "r");

  FILE *in = fopen(argv[1], "r");
  char *word = (char*) malloc(1000 * sizeof(char));
  SymbolTable table = stable_create();
  // tamanho da maior palavra, alterado conforme lemos cada uma delas
  int greatest = 0;

  while (fscanf(in, "%s", word) != EOF) {
    // guardar tamanho se a palavra for a maior até então
    int size = strlen(word);
    if (size > greatest) greatest = size;
    InsertionResult res;
    res = stable_insert(table, word);
    if (res.new == 0) res.data->i++;
    else {
      res.data->i = 1;
      // imprimir palavras novas no pipe
      fprintf(write, "%s ", word);
    }
    word = (char*) malloc(1000 * sizeof(char)); // achar outro memadress para prox. word
  }

  fclose(write);

  char *entry = (char*) malloc(1000 * sizeof(char));
  char *s_array[table->n];
  int index = 0;

  // ler palavras do pipe, colocar em um array de strings
  while (fscanf(read, "%s", entry) != EOF) {
    s_array[index] = entry;
    entry = (char*) malloc(1000 * sizeof(char));
    index++;
  }

  // ordenar o array por qsort (stdlib.h)
  qsort(s_array, table->n, sizeof(char*), compare);

  // resetar index
  index = 0;
  EntryData *ed;

  while (index < table->n) {
    // imprimir a palavra, os espacos necessarios, e o valor
    printf("%s", s_array[index]);
    for (int i = strlen(s_array[index]); i < greatest + 1; i++) {
      printf(" ");
    }
    ed = stable_find(table, s_array[index]);
    printf("%d\n", ed->i);
    index++;
  }

  //int test = stable_visit(table, print_key_int_spaced);
  //printf("returned %d\n", test);
}
