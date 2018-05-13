#include "stable_s.h"

#define tablem (table->m)
#define tablen (table->n)
#define tableht (table->hash_table)
#define xnext (x->next)
#define xkey (x->key)
#define xval (x->val)

/******************************************************************************/

static unsigned long hash(const char* key, int M) {

  unsigned long hash = 5381;
  int c;

  while (c = *key++) {
    hash = (((hash << 5) + hash) + c)%M;
  }

  return hash;
}

static void rehash(SymbolTable table, const char *key, EntryData data) {

    int i = hash(key, tablem);
    Node *x = node_create(key);
    xval = data;
    node_insert(tableht[i], x);
}

static SymbolTable resize(SymbolTable table) {

  SymbolTable newtbl = (SymbolTable) malloc(sizeof(SymbolTable));
  newtbl->n = tablen;
  int M = 2 * tablem;
  newtbl->m = M;
  newtbl->hash_table = (Node**) malloc(M * sizeof(Node*));

  for (int i = 0; i < tablem; i++) {
    Node *x = tableht[i];
    while (x != NULL) {
      rehash(newtbl, xkey, xval);
      x = xnext;
    }
  }
  free(table);
  return newtbl;
}

/******************************************************************************/

Node *node_create() {

  Node *x = (Node*) malloc(sizeof(Node*));
  x->key = NULL;
  x->val = (EntryData) malloc(sizeof(EntryData));
  x->next = NULL;

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
  tablem = 4;
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

  printf("Inserting key %s...\n", key);

  InsertionResult res;

  if (tablen >= 10*tablem)
    table = resize(table);

  unsigned long i = hash(key, tablem);
  Node *x = tableht[i];

  while (x != NULL) {
    //printf("%lu\n",i);
    // if (xnext != NULL)
    //     printf("next key = %s\n", xnext->key);
    if (xkey != NULL && strcmp(xkey, key) == 0) {
      // printf("i = %lu key = %s xkey = %s\n",i, key, xkey);
      // printf("%d\n",xval.i);
      res.new = 0;
      res.data = &xval;
      printf("Finished inserting, m is %d, n is %d\n", table->m, table->n);
      return res;
    }
    x = xnext;
  }

  x = node_create(key);
  //printf("new node: i = %lu key = %s xkey = %s\n",i, key, xkey);
  node_insert(tableht[i], x);
  res.new = 1;
  res.data = &xval;
  x->key = malloc(sizeof(char*));
  strcpy(xkey, key);
  tablen++;
  printf("Finished inserting, m is %d, n is %d\n", table->m, table->n);
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
