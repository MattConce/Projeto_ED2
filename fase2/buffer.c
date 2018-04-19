#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
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
  free(B->data);
  B->data = NULL;
  free(B);
  B = NULL;
}

void buffer_reset(Buffer *B) {
  size_t member_size = B->member_size;
  buffer_destroy(B);
  B = buffer_create(member_size);
}

void *buffer_push_back(Buffer *B) {

  if (B->p == B->buffer_size) {
    int new_size = 2*(B->buffer_size);
    B->data = (void*)realloc(B->data, (new_size)*sizeof(B->member_size));
    B->buffer_size = new_size;
  }

  B->p++;
  return B->data + B->p;
}

int read_line(FILE *input, Buffer *B) {

  int n = 0;
  buffer_reset(B);

  char c = fgetc(input);

  // pula espaços do início da linha
  while (c != '\n' && isspace(c)) {
      c = fgetc(input);
  }

  // lê e armazena caracteres até achar um \n ou EOF
  while (c != '\n' && !feof(input)) {
    buffer_push_char(B, c);
    c = fgetc(input);
    n++;
  }

  // inclui o caractere '\n' na linha
  if (c == '\n')
    buffer_push_char(B, c);

  // remove espaços do final da linha;
  while(isspace(*((char *) B->data + (B->p-1)))) {
      B->p--;
      n--;
  }

  // adiciona \0 no final de data (indica final da string)
  buffer_push_char(B, '\0');
  B->p--;

  // devolve o número de caracteres na linha
  return n;
}
