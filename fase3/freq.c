#include "freq.h"

static int compare (const void* s, const void* t) {
  const char* p = *(const char**)s;
  const char* q = *(const char**)t;
  return strcmp(p, q);
}

void read_words(FILE *input, SymbolTable table) {
  char c;
  char curr_word[MAX];
  int is_word = FALSE;
  int i = 0;
  while(!feof(input)) {
     c = fgetc(input);

    if (isspace(c) && !is_word) {
      continue;
    }
    else if (isspace(c)) {
      curr_word[i++] = '\0';
      char *key = malloc(MAX*sizeof(char));
      strcpy(key, curr_word);
      key = curr_word;
      InsertionResult res = stable_insert(table, key);
      printf("Chave a ser inserida = %s\n", key);
      printf("\n");
      if (res.new == 0 ) {
        res.data->i++;
        printf("val depois da inserção = %d\n",res.data->i);
        printf("\n");
        printf("\n");
      }
      else {
        res.data->i = 1;
      }
      is_word = FALSE;
      strcpy(curr_word, "");
      i = 0;
    }
    else {
      curr_word[i++] = c;
      is_word = TRUE;
    }
  }
}

int main(int argc, char const *argv[]) {
  FILE *input;
  input = fopen(argv[1],"r");
  if(input == NULL) {
    perror("Error in opening file");
    return(-1);
  }
  SymbolTable table = stable_create();
  read_words(input, table);
  char * s_array[tablen];
  int index = 0;
  for (int i = 0; i < tablem; i++) {
    Node *x = tableht[i];
    while (x != NULL) {
      if (xkey != NULL){
        s_array[index++] = xkey;
      }
      x = xnext;
    }
  }
  qsort(s_array, table->n, sizeof(char*), compare);
  EntryData *data = malloc(sizeof(EntryData*));
  for (index = 0; index < tablen; index++) {
    data = stable_find(table, s_array[index]);
    printf("key = %s val = %d\n", s_array[index], data->i);
  }

  fclose(input);
  return 0;
}
