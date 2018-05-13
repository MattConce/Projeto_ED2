#include "freq.h"

void read_words(FILE *input, SymbolTable table) {
  char c;
  char curr_word[MAX];
  int is_word = FALSE;
  int i = 0;
  int end = FALSE; // flag para o EOF
  while(TRUE) {

    if(feof(input)) end = TRUE;
    else c = fgetc(input);

    if (isspace(c) && !is_word) {
      continue;
    }
    else if (isspace(c) || end) {
      curr_word[i++] = '\0';
      char *key = malloc(MAX*sizeof(char));
      strcpy(key, curr_word);
      key = curr_word;
      InsertionResult res = stable_insert(table, key);
      printf("Chave a ser inserida = %s\n", key);
      printf("\n");
      if (res.new == 0) {
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
      if (end) {
        puts("ok");
        break;
      }
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
  fclose(input);
  return 0;
}
