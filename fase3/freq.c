#include "freq.h"

void read_words(SymbolTable table) {
  char c;
  char curr_word[MAX];
  int is_word = FALSE;
  int i = 0;
  while(TRUE) {
    c = fgetc(stdin);
    if (isspace(c) && !is_word) {
      continue;
    }
    else if (isspace(c) || c == EOF) {
      curr_word[i++] = '\0';
      char *key = malloc(MAX*sizeof(char));
      strcpy(key, curr_word);
      key = curr_word;
      InsertionResult res = stable_insert(table, key);
      puts(key);
      if (res.new == 0) {
        res.data->i++;
      }
      else {
        res.data->i = 1;
      }
      is_word = FALSE;
      strcpy(curr_word, "");
      i = 0;
      if (c == EOF) {
        break;
      }
    }
    else {
      curr_word[i++] = c;
      is_word = TRUE;
    }
  }
}

int main() {
  SymbolTable table = stable_create();
  read_words(table);
  return 1;
}
