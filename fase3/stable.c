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

InsertionResult stable_insert(SymbolTable table, const char *key) {
  InsertionResult res;
  unsigned long hash = table->m;
  int c;
  while (c = *key++) {
    hash = ((hash << 5) + hash) + c;
  }
  for (Node *x = table->hash_table[hash]; x != NULL; x = x->next) {
    if (x->key == key) {
      res.new = 1;
      *res.data = x->val;
      return res;
    }
  }
  res.new = 0;
  return res;
}

EntryData *stable_find(SymbolTable table, const char *key) {
  EntryData *ptr = NULL;
  unsigned long hash = table->m;
  int c;
  while (c = *key++) {
    hash = ((hash << 5) + hash) + c;
  }
  for (Node *x = table->hash_table[hash]; x != NULL; x = x->next) {
    if (x->key == key) {
      *ptr = x->val;
    }
  }
  return ptr;
}

int visit(const char *key, EntryData *data) {

}
