#include <stdlib.h>
#include "stable.h"
#include "stable_s.h"

SymbolTable stable_create() {
  SymbolTable st = malloc(sizeof(SymbolTable));
  st->n = 0;
  st->m = 4; // capacidade inicial 4 seguindo exemplo do Sedgewick
  st->hash_table = (Node**) malloc(st->m*sizeof(Node));
  for (int i = 0; i < st->m; i++) {
    st->hash_table[i] = (Node*) malloc(sizeof(Node));
  }
  return st;
}

int main() {

}
