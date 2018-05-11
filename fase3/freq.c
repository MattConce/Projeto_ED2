#include <stdio.h>
#include "freq.h"
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "stable_s.h"
#include "stable.h"
#define TRUE 1
#define FALSE 0
#define MAX 500
#define tablem (table->m)
#define tablen (table->n)
#define tableht (table->hash_table)
#define xnext (x->next)
#define xkey (x->key)
#define xval (x->val)


static void put(SymbolTable table, char *key, EntryData val) {
  InsertionResult res = stable_insert(table, key);
  *(res.data) = val;
}

static EntryData get(SymbolTable table, char *key) {
  EntryData *val = stable_find(table, key);
  return *val;
}

void read_words() {
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
      puts(curr_word);
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
  // char *words[MAX];
  // int w = 0;
  read_words();
  puts("Done");
  // printf("%d\n", w);
  return 1;
}
