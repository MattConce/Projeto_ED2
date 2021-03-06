#include "stable_s.h"

#define tablem (table->m)
#define tablen (table->n)
#define tableht (table->hash_table)
#define xnext (x->next)
#define xkey (x->key)
#define xval (x->val)

static unsigned long hash(const char* key, int M) {
  unsigned long hash = 5381;
  int c;

  while (c = *key++) {
    hash = (((hash << 5) + hash) + c)%M;
  }

  return hash;
}

Node *node_create() {
  Node *x = (Node*) malloc(sizeof(Node*));
  x->key = NULL;
  x->val = (EntryData) malloc(sizeof(EntryData));
  x->next = NULL;
  if (x == NULL) {
    perror("Memory allocation error");
    abort();
  }

  return x;
}

void node_destroy(Node *x) {
    if (xnext != NULL) node_destroy(xnext);
    free(xkey);
    xkey = NULL;
    free(x);
    x = NULL;
}

void node_insert(Node *root, Node *x) {
    xnext = root->next;
    root->next = x;
}

SymbolTable stable_create() {
  SymbolTable table = (SymbolTable) malloc(sizeof(SymbolTable));
  tablen = 0;
  tablem = 800;
  tableht = (Node**) malloc(tablem * sizeof(Node*));

  for (int i = 0; i < tablem; i++) {
    tableht[i] = node_create();
  }

  return table;
}

void stable_destroy(SymbolTable table) {
  for (int i = 0; i < tablem; i++) {
    node_destroy(tableht[i]);
  }
  free(tableht);
  tableht = NULL;
}

InsertionResult stable_insert(SymbolTable table, const char *key) {
  InsertionResult res;
  unsigned long i = hash(key, tablem);
  Node *x = tableht[i];

  while (x != NULL) {
    if (xkey != NULL && strcmp(xkey, key) == 0) {
      res.new = 0;
      res.data = &xval;
      return res;
    }
    x = xnext;
  }

  x = node_create();
  node_insert(tableht[i], x);
  res.new = 1;
  res.data = &xval;
  x->key = malloc(MAX*sizeof(char*));
  if (x->key == NULL) {
    perror("Memory allocation error");
    abort();
  }
  strcpy(xkey, key);
  tablen++;

  return res;
}

EntryData *stable_find(SymbolTable table, const char *key) {
  EntryData *ptr = NULL;
  unsigned long i = hash(key, tablem);
  Node *x = tableht[i];

  while (x != NULL) {
    if (xkey != NULL && strcmp(xkey, key) == 0) {
      ptr = &xval;
      break;
    }
    x = xnext;
  }

  return ptr;
}

int stable_visit(SymbolTable table, int (*visit)(const char *key, EntryData *data)) {
  int bool = 1;
  for (int i = 0; i < tablem; i++) {
    Node *x = tableht[i]->next;
    while (x != NULL) {
      bool = visit(xkey, &xval);
      if (!bool) {
        return 0;
      }
    x = xnext;
    }
  }

  return bool;
}
