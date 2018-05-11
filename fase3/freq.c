#include <stdio.h>
#include "freq.h"
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#define TRUE 1
#define FALSE 0
#define MAX 500

void read_words(char **words, int *w) {
  char c;
  char curr_word[MAX];
  int is_word = FALSE;
  int i = 0;
  while(TRUE) {
    c = getchar();
    if (isblank(c) && !is_word) {
      continue;
    }
    else if (isblank(c) || c == EOF) {
      puts(curr_word);
      is_word = FALSE;
      strcpy(curr_word, "");
      i = 0;
      if (c == EOF) return;
    }
    else {
      curr_word[i++] = c;
      is_word = TRUE;
    }
  }
}

int main() {
  char *words[MAX];
  int w = 0;
  puts("Done");
  read_words(words, &w);
  // printf("%d\n", w);
}
