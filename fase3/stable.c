#include "stable_s.h"

/******************************************************************************/

static Node *node_create(const char *key) {

  Node *x = (Node*) malloc(sizeof(Node));

  xkey = key;
  xval.i = 0;
  xnext = NULL;

  return x;
}

static void node_destroy(Node *x) {
    free(x);
    x = NULL;
}

static Stack *stack_create() {
    Stack *s = (Stack *) malloc(sizeof(Stack));
    s->head = NULL;
    return s;
}

static void stack_destroy(Stack *s) {
    Node *next = NULL;
    for (Node *x = s->head; x != NULL; x = next) {
        next = xnext;
        node_destroy(x);
    }
    free(s);
    s = NULL;
}

static void stack_insert(Stack **s, Node **x) {
    (*x)->next = (*s)->head;
    (*s)->head = *x;
}

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
    stack_insert(&tableht[i], &x);
}

static SymbolTable resize(SymbolTable table) {

  SymbolTable newtbl = (SymbolTable) malloc(sizeof(SymbolTable));
  newtbl->n = tablen;
  int M = 2 * tablem;
  newtbl->m = M;
  newtbl->hash_table = (Stack**) malloc(M * sizeof(Stack*));

  for (int i = 0; i < tablem; i++) {
    Node *x = tableht[i]->head;
    while (x != NULL) {
      rehash(newtbl, xkey, xval);
      x = xnext;
    }
  }
  free(table);
  return newtbl;
}

/******************************************************************************/

SymbolTable stable_create() {

  // SymbolTable table = {.n = 0,
  //                      .m = 4, // capacidade inicial 4 seguindo exemplo do Sedgewick
  //                      .hash_table = (Node**) malloc(tablem * sizeof(Node*))};
  SymbolTable table = malloc(sizeof(SymbolTable));
  table->n = 0;
  table->m = 14;
  table->hash_table = (Stack**) malloc(table->m * sizeof(Stack*));
  for (int i = 0; i < table->m; i++) {
    table->hash_table[i] = stack_create();
  }

  return table;
}

void stable_destroy(SymbolTable table) {

  for (int i = 0; i < table->m; i++) {
    stack_destroy(tableht[i]);
  }
  free(tableht);
  tableht = NULL;
}

InsertionResult stable_insert(SymbolTable table, const char *key) {

  InsertionResult res;

  unsigned long i = hash(key, tablem);
  if (tablen >= 10*tablem)
    table = resize(table);
  Node *x = tableht[i]->head;
  while (x != NULL) {
    printf("%lu\n",i);
    if (xnext != NULL)
        printf("next key = %s\n", xnext->key);
    if (xkey != NULL && strcmp(xkey, key) == 0) {
      printf("i = %lu key = %s xkey = %s\n",i, key, xkey);
      res.new = 0;
      res.data = &xval;
      return res;
    }
    x = xnext;
  }
  x = node_create(key);
  printf("new node: i = %lu key = %s xkey = %s\n",i, key, xkey);
  stack_insert(&tableht[i], &x);
  res.new = 1;
  res.data = &xval;
  puts(xkey);
  return res;
}

EntryData *stable_find(SymbolTable table, const char *key) {

  EntryData *ptr = NULL;

  unsigned long i = hash(key, tablem);

  Node *x = tableht[i]->head;
  while (x != NULL) {
    if (strcmp(xkey, key) == 0) {
      *ptr = xval;
    }
    x = xnext;
  }

  return ptr;
}

int stable_visit(SymbolTable table, int (*visit)(const char *key, EntryData *data)) {
  int bool = 1;
  for (int i = 0; i < tablem; i++) {
    Node *x = tableht[i]->head;
    while (x != NULL) {
      bool = visit(xkey, &xval);
      if (bool) {
        return 0;
      }
      x = xnext;
    }
  }
  return bool;
}
