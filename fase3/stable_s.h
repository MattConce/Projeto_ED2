#include <stdlib.h>
#include "stable.h"
#include <ctype.h>
#include <string.h>

typedef struct Node{
  const char *key;
  EntryData *val;
  struct Node *next;
} Node;

struct stable_s {
  int n; // número de pares chave-valor
  int m; // tamanho da tabela
  Node **hash_table; // vetor para hash table
};

static Node* node_create();
static void node_destroy(Node*);
static unsigned long hash(const char*, int);
static SymbolTable resize(SymbolTable);
static void rehash(SymbolTable, char*, EntryData);
