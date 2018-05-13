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


// static void put(SymbolTable table, char *key, EntryData val) {
//   InsertionResult res = stable_insert(table, key);
//   *(res.data) = val;
// }
//
// static EntryData get(SymbolTable table, char *key) {
//   EntryData *val = stable_find(table, key);
//   return *val;
// }

// void read_words(SymbolTable table) {
//   char c;
//   char curr_word[MAX];
//   int is_word = FALSE;
//   int i = 0;
//   while(TRUE) {
//     c = fgetc(stdin);
//     if (isspace(c) && !is_word) {
//       continue;
//     }
//     else if (isspace(c) || c == EOF) {
//       char *key = curr_word;
//       InsertionResult res = stable_insert(table, key);
//       if (res.new == 0) {
//         res.data->i = (res.data->i)++;
//       }
//       else {
//         res.data->i = 1;
//       }
//       is_word = FALSE;
//       strcpy(curr_word, "");
//       i = 0;
//       if (c == EOF) {
//         break;
//       }
//     }
//     else {
//       curr_word[i++] = c;
//       is_word = TRUE;
//     }
//   }
// }

int word_length(const char *key, EntryData *data) {
  int size = strlen(key);
  return size;
}

int print_key_int(const char *key, EntryData *data) {
  printf("%s %d\n", key, data->i);
  return strlen(key);
}

int main(int argc, char const *argv[]) {

  FILE *in = fopen(argv[1], "r");
  char *word = (char*) malloc(2048 * sizeof(char));
  SymbolTable table = stable_create();

  while (fscanf(in, "%s", word) != EOF) {

    //InsertionResult *res = (InsertionResult*) malloc(sizeof(InsertionResult));
    InsertionResult res;
    //printf("res from main address: [%p], data \"value\": (%d)\n", &res, res.data);
    res = stable_insert(table, word);
    //printf("(RESULT) res from main address: [%p], data \"value\": (%d)\n", &res, res.data);
    if (res.new == 0) {
      res.data->i++;
      //printf("int: %d, pointer: %p\n", res.data->i, &res.data->i);
    }
    else {
      res.data->i = 1;
    }
    word = (char*) malloc(2048 * sizeof(char)); // achar outro memadress para prox. word
  }

  int test = stable_visit(table, print_key_int);
  printf("returned %d\n", test);
}
