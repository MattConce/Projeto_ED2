

typedef struct node{
  char *key;
  EntryData val;
  struct node *next;
}Node;

struct stable_s {
  int n; // número de pares chave-valor
  int m; // tamanho da tabela
  Node **hash_table; // vetor para hash table
};

void put(SymbolTable table, InsertionResult);
