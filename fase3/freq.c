#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "stable_s.h"
#include "stable.h"

int word_length(const char *key, EntryData *data) {
  int size = strlen(key);
  return size;
}

int print_key_int(const char *key, EntryData *data) {
  printf("%s %d\n", key, data->i);
  return strlen(key);
}

int main(int argc, char const *argv[]) {

  FILE *in = fopen(argv[1], "r");
  char *word = (char*) malloc(2048 * sizeof(char));
  SymbolTable table = stable_create();

  while (fscanf(in, "%s", word) != EOF) {
    InsertionResult res;
    res = stable_insert(table, word);
    if (res.new == 0) res.data->i++;
    else res.data->i = 1;
    word = (char*) malloc(2048 * sizeof(char)); // achar outro memadress para prox. word
  }

  int test = stable_visit(table, print_key_int);
  printf("returned %d\n", test);
}
