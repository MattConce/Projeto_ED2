#include <stdlib.h>
#include "stable.h"
#include "stable_s.h"
#include <ctype.h>

SymbolTable stable_create() {
  SymbolTable table = malloc(sizeof(SymbolTable));
  table->n = 0;
  table->m = 4; // capacidade inicial 4 seguindo exemplo do Sedgewick
  table->hash_table = (Node**) malloc(table->m*sizeof(Node));
  for (int i = 0; i < table->m; i++) {
    table->hash_table[i] = (Node*) malloc(sizeof(Node));
  }
  return table;
}

int main() {

}

void stable_destroy(SymbolTable table) {
  for (int i = 0; i < table->m; i++) {
    free(table->hash_table[i]);
  }
  free(table->hash_table);
  free(table);
}
