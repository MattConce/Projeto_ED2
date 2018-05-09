#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "buffer.h"


#define bdata (B->data)
#define bdataat(X) (B->data + (X))
#define memsize (B->member_size)
#define buffsize (B->buffer_size)
#define bp (B->p)

Buffer *buffer_create(size_t member_size) {
  Buffer *B = (Buffer*)malloc(sizeof(Buffer));
  bdata = (void*)malloc(sizeof(member_size)); // cria um vetor para armazenar dados to tamanho de member_size
  buffsize = 1;
  memsize = member_size;
  bp = 0;
  return B;
}

void buffer_destroy(Buffer *B) {
  free(bdata);
  bdata = NULL;
  free(B);
  B = NULL;
}

void buffer_reset(Buffer *B) {
  size_t member_size = memsize;
  buffer_destroy(B);
  B = buffer_create(member_size);
}

void *buffer_push_back(Buffer *B) {

  if (bp == buffsize) {
    int new_size = 2*(buffsize);
    bdata = (void*)realloc(bdata, (new_size)*sizeof(memsize));
    buffsize = new_size;
  }

  bp++;
  return bdataat(bp);
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

  // remove espaços do final da linha;
  while(isspace(*((char *) bdataat(bp)))) {
      bp--;
      n--;
  }

  // inclui o caractere '\n' na linha
  if (c == '\n')
    buffer_push_char(B, c);

  // adiciona \0 no final de data (indica final da string)
  buffer_push_char(B, '\0');
  bp--;

  // devolve o número de caracteres na linha
  return n;
}
