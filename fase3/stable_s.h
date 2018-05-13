#include <stdlib.h>
#include <stdio.h>
#include "stable.h"
#include <ctype.h>
#include <string.h>
#define TRUE 1
#define FALSE 0
#define MAX 500

typedef struct Node {
  char* key;
  EntryData val;
  struct Node *next;
} Node;

typedef struct Stack {
  Node *head;
} Stack;

typedef struct stable_s {
  int n; // número de pares chave-valor
  int m; // tamanho da tabela
  Node **hash_table; // vetor para hash table
} stable_s;


Node *node_create() ;
void node_destroy(Node *x);
void node_insert(Node *root, Node *x);
