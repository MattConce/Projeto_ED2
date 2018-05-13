#include <stdlib.h>
#include "stable.h"
#include "stable_s.h"
#include <ctype.h>
#include <string.h>
#include <stdio.h>

#define tablem (table->m)
#define tablen (table->n)
#define tableht (table->hash_table)
#define xnext (x->next)
#define xkey (x->key)
#define xval (x->val)

SymbolTable stable_create() {

  // SymbolTable table = {.n = 0,
  //                      .m = 4, // capacidade inicial 4 seguindo exemplo do Sedgewick
  //                      .hash_table = (Node**) malloc(tablem * sizeof(Node*))};
  SymbolTable table = malloc(sizeof(SymbolTable));
  table->n = 0;
  table->m = 4;
  table->hash_table = (Node**) malloc(table->m*sizeof(Node));
  for (int i = 0; i < table->m; i++) {
    table->hash_table[i] = node_create();
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

  //InsertionResult res = (InsertionResult) malloc(sizeof(InsertionResult));
  InsertionResult res;

  unsigned long i = hash(key, tablem);
  /*if (tablen >= 10*tablem)
    table = resize(table);*/

  for (Node *x = tableht[i]; x != NULL; x = xnext) {
    if (xkey != NULL && strcmp(xkey, key) == 0) {
      res.new = 0;
      res.data = xval;
      //printf("res.data is %p for %s\n", res.data, key);
      return res;
    }
  }
  Node *y = node_create();
  y = node_create();
  res.new = 1;
  res.data = y->val;
  //printf("res.data is %p for %s\n", res.data, key);
  y->key = key;
  y->next = tableht[i];
  tableht[i] = y;
  tablen++;
  //printf("ir in insert address: [%p], data value: (%d)\n", &res, res.data);
  //printf("hash: %d, key inserted: \"%s\", next points to [%p]\n", i, key, y->next);
  return res;
}

EntryData *stable_find(SymbolTable table, const char *key) {

  // verificar todos os elementos da tabela
  /*Node *test;
  int j = 0;
  while (j < tablem) {
    test = tableht[j];
    while (test->next != NULL) {
      printf("position %d, key is %s, val adress is %p\n", j, test->key, test->val);
      test = test->next;
    }
    j++;
    }*/

  EntryData *ptr = NULL;

  unsigned long i = hash(key, tablem);

  for (Node *x = tableht[i]; x != NULL; x = xnext) {
    if (xkey != NULL && strcmp(xkey, key) == 0) {
      ptr = xval;
      break;
      //printf("evaluating %s, xval pointer is [%p], with int value (%d), returning ptr [%p]\n", key, xval, xval, ptr);
    }
  }
  return ptr;
}

static Node* node_create() {

  Node *x = (Node*) malloc(sizeof(Node));

  xkey = NULL;
  xnext = NULL;
  xval = (EntryData*) malloc(sizeof(EntryData));
  //xval->i = 0;

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
    hash = (((hash << 5) + hash) + c);
  }

  return hash % M;
}

static SymbolTable resize(SymbolTable table) {

  SymbolTable newtbl = (SymbolTable) malloc(sizeof(SymbolTable));
  /*newtbl->n = tablen;
  int M = 2 * tablem;
  newtbl->m = M;
  newtbl->hash_table = (Node**) malloc(M * sizeof(Node*));

  for (int i = 0; i < tablem; i++) {
    for (Node *x = tableht[i]; x; xnext) {
      rehash(newtbl, xkey, xval);
    }
  }
  */
  return newtbl;
}

static void rehash(SymbolTable table,  char *key, EntryData data) {

  /*int i = hash(key, tablem);
    Node *x;
    x = node_create();
    xkey = key;
    xval = data;
    xnext = tableht[i];
    tableht[i] = x;*/
}

int stable_visit(SymbolTable table, int (*visit)(const char *key, EntryData *data)) {
  int ret = 0;
  int greatest = 0;
  for (int i = 0; i < tablem; i++) {
    // [xnext != NULL] em vez de [x != NULL] meio gambiarra, ver direito depois
    for (Node *x = tableht[i]; xnext != NULL; x = xnext) {
      ret = visit(xkey, xval);
      if (ret == 0) {
        return 0;
      }
      if (ret > greatest) greatest = ret;
    }
  }
  return greatest;
}
