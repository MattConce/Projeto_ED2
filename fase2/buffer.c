#include <stdio.h>
#include <stdlib.h>
#include "buffer.h"


Buffer *buffer_create(size_t member_size) {
  Buffer *B = (Buffer*)malloc(sizeof(Buffer));
  B->data = (void*)malloc(sizeof(member_size)); // cria um vetor para armazenar dados to tamanho de member_size
  B->buffer_size = 1;
  B->member_size = member_size;
  B->p = 0;
  return B;
}

void buffer_destroy(Buffer *B) {
  free(B);
}

void buffer_reset(Buffer *B) {
  free(B->data);
  B->data = (void*)malloc(sizeof(B->member_size));
  B->buffer_size = sizeof(B->data);
  B->p = 0;
}

void *buffer_push_back(Buffer *B) {
  if (B->p == B->buffer_size) {
    int new_size = 2*(B->buffer_size);
    B->data = (void*)realloc(B->data, (new_size)*sizeof(B->member_size));
    B->buffer_size = new_size;
  }
  B->p += 1;
  return B->data+B->p;
}

int read_line(FILE *input, Buffer *B) {
  int n = 0;
  buffer_reset(B);
  char c = fgetc(input);
  while (c != '\n' && c != EOF) {
    buffer_push_char(B, c);
    c = fgetc(input);
    n++;
  }
  // inclui o caractere '\n' na linha
  if (c == '\n')
    buffer_push_char(B, c);
  // devolve o número de caracteres na linha
  return n;
}
int main () {

}
