#include "freq.h"

static int compare (const void* s, const void* t) {
  const char* p = *(const char**)s;
  const char* q = *(const char**)t;
  return strcmp(p, q);
}

int print_visited_int(const char *key, EntryData *data) {
  printf("%s %d\n", key, data->i);
  return 1;
}

void read_words(FILE *input, SymbolTable table) {
  char c;
  char curr_word[MAX];
  int is_word = FALSE;
  int i = 0;
  while(!feof(input)) {
     c = fgetc(input);
    // elimina linhas e espaços entre palavras
    if (isspace(c) && !is_word) {
      continue;
    }
    // palavra encontrada
    else if (isspace(c)) {
      curr_word[i++] = '\0';
      char *key = malloc(MAX*sizeof(char));
      strcpy(key, curr_word);
      key = curr_word;
      InsertionResult res = stable_insert(table, key);
      if (res.new == 0 ) {
        res.data->i++;
      }
      else {
        res.data->i = 1;
      }
      is_word = FALSE;
      strcpy(curr_word, "");
      i = 0;
    }
    // ainda dentro da palavra
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
  int greatest = 0;
  // achar a maior palavra na tabela
  // e colocar todas as tabelas em um vetor para ordena-las
  for (int i = 0; i < tablem; i++) {
    Node *x = tableht[i];
    while (x != NULL) {
      if (xkey != NULL){
        int size = strlen(xkey);
        if (size > greatest)
          greatest = size;
        s_array[index++] = xkey;
      }
      x = xnext;
    }
  }
  // ordenação lexográfica
  qsort(s_array, table->n, sizeof(char*), compare);
  EntryData *data = malloc(sizeof(EntryData*));
  for (index = 0; index < tablen; index++) {
    printf("%s",s_array[index]);
    // imprime os espaçoes necessários
    for (int sp = strlen(s_array[index]); sp < greatest+1; sp++)
      printf(" ");

    data = stable_find(table, s_array[index]);
    printf("%d\n",data->i);
  }
  /* Descomente stable_visit para imprimir todo conteúdo da tabela*/
  //int ok = stable_visit(table, print_visited_int);
  //printf("%d\n", ok);

  fclose(input);
  return 0;
}
