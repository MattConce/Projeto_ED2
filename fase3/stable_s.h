

typedef struct Node{
  char *key;
  EntryData val;
  struct Node *next;
} Node;

struct stable_s {
  int n; // número de pares chave-valor
  int m; // tamanho da tabela
  Node **hash_table; // vetor para hash table
};

// void put(SymbolTable table, const char *key, EntryData *data);
// EntryData get(SymbolTable table, )
