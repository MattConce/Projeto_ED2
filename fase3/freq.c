#include "freq.h"

void read_words(FILE *input, SymbolTable table) {
  char c;
  char curr_word[MAX] = {0};
  int is_word = FALSE;
  int i = 0;
  while(TRUE) {
    c = fgetc(input);
    if (isspace(c) && !is_word) {
      continue;
    }
    else if (isspace(c) || c == EOF) {
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
      if (c == EOF) {
        puts("ok");
        fclose(input);
        free(key);
        break;
      }
    }
    else {
      puts("ok makeing word");
      curr_word[i++] = c;
      is_word = TRUE;
    }


  }
}

int main(int argc, char const *argv[]) {
  FILE *input = fopen(argv[1], "r");
  SymbolTable table = stable_create();
  read_words(input, table);
  return 0;
}
