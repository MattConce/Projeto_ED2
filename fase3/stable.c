#include <stdlib.h>
#include "stable.h"
#include "stable_s.h"
#include <ctype.h>

#define tablem (table.m)
#define tablen (table.n)
#define tableht (table.hash_table)
#define xnext (x->next)
#define xkey (x->key)
#define xval (x->val)

SymbolTable stable_create() {

  SymbolTable table = {.n = 0,
                       .m = 4, // capacidade inicial 4 seguindo exemplo do Sedgewick
                       .hash_table = (Node**) malloc(tablem * sizeof(Node*))};

  for (int i = 0; i < tablem; i++) {
    tableht[i] = node_create();
  }

  return table;
}

void stable_destroy(SymbolTable table) {

  for (int i = 0; i < table->m; i++) {
    node_destroy(tableht[i]);
  }
  free(tableht);
  tableht = NULL;
}

InsertionResult stable_insert(SymbolTable table, const char *key) {

  InsertionResult res;

  unsigned long hash = hash(key, tablem);
   if (tablen >= 10*tablem)
    table = resize(table);

  for (Node *x = tableht[hash]; x != NULL; x = xnext) {
    if (strcmp(xkey, key) == 0) {
      res.new = 0;
      res.data = &xval;
      return res;
    }
  }
  res.new = 1;
  return res;
}

EntryData *stable_find(SymbolTable table, const char *key) {

  EntryData *ptr = NULL;

  unsigned long hash = hash(key, tablem);

  for (Node *x = tableht[hash]; x != NULL; x = xnext) {
    if (strcmp(xkey, key) == 0) {
      *ptr = xval;
    }
  }

  return ptr;
}

static Node* node_create() {

  Node *x = (Node*) malloc(sizeof(Node));

  xkey = NULL;
  xval = {0};
  xnext = NULL;

  return x;
}

static void node_destroy(Node *x) {
    free(x);
    x = NULL;
}

static unsigned long hash(const char* key, int M) {

  unsigned long hash = 5381;
  int c;

  while (c = *key++) {
    hash = (((hash << 5) + hash) + c)%M;
  }

  return hash;
}

static SymbolTable resize(SymbolTable table) {

  SymbolTable *newtbl = (SymbolTable*) malloc(sizeof(SymbolTable));
  newtbl->n = tablen;
  int M = 2 * tablem;
  newtbl->m = M;
  newtbl->hash_table = (Node**) malloc(M * sizeof(Node*));

  for (int i = 0; i < tablem; i++) {
    for (Node *x = tableht[i]; x; xnext) {
      rehash(newtbl, xkey, xvalue);
    }
  }

  return &newtbl;
}

static void rehash(SymbolTable table, const char *key, EntryData *data) {

    int hash = hash(table, key);
    Node *x = tableht[hash];

    while (x != NULL)
      x = xnext;

    x = node_create();
    xkey = key;
    xval = data;
    xnext = NULL;
    x = xnext;

}

int stable_visit(SymbolTable table, int (*visit)(const char *key, EntryData *data)) {
  int bool = 1;
  for (int i = 0; i < m; i++) {
    for (Node *x = tableht[i]; x; xnext) {
      bool = visit(xkey, xval);
      if (bool) {
        return 0;
      }
    }
  }
  return bool;
}

int main() {

}