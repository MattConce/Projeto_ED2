
struct stable_s {
  int n; // número de pares chave-valor
  int m; // tamanho da tabela
  Node hash_table[]; // vetor para hash table
};

typedef struct {
  char *key;
  EntryData val;
  Node next;
}Node;
