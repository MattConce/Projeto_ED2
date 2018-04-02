/******************************
 * Justificador de texto em C
 ******************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#define MAX 10000
#define MAX_W 500
#define MAX_l 300

char* readParagraph(char*, int*, char*, int);
void just(char*, int, int, int);
int breakInWords(char*, char**, int, int);
int breakInLines(char**, char**, int, int);
char* insertchar(char*, int, char);
void formatLine(char*, int);


char* readParagraph(char* text, int *p_n, char* p, int tam) {
  int j = *p_n;
  int i = 0;

  while (j < tam) {
    if (text[j] == '\n') {
      if (text[j+1] != '\n') {
        p[i++] = text[j++];
      }
      else break;
    }
    else {
      p[i++] = text[j++];
    }
  }
  p[i++] = '\0';
  *p_n = j;
  return p;
}

void just(char* p, int c, int p_len, int tam) {
  char **words;

  /* ALOCAÇÃO DE MEMÓRIA*/
  words = malloc(p_len * sizeof(char *));
  for (int i = 0; i < p_len; i++)
  {
    words[i] = malloc(MAX_l * sizeof(char));
  }
  /* Quebra o paragrafo em palavras e armazena em um vetor */
  int w = breakInWords(p, words, p_len, tam);
  char **lines;

  /* ALOCAÇÃO DE MEMÓRIA*/
  lines = malloc((w*c)* sizeof(char*));
  for (int i = 0; i < w; i++) {
    lines[i] = malloc(p_len * sizeof(char));
  }
  /* Coloca o maximo de palavras que cabem em uma linha sem execeder o
     número de colunas */
  int l = breakInLines(lines, words, c, w);
  // for (int i = 0; i < l; i++) puts(lines[i]);
  for (int i = 0; i < l; i++) {
    /* Formata a linha em c colunas */
    formatLine(lines[i], c);
  }
  // /* LIBERAÇÃO DE MEMÓRIA */
  free(lines);
  free(words);
}

int breakInWords(char* p, char** words, int p_len, int tam) {
  int w = 0;
  int j;
  int bol = 0;
  for (int i = 0; i < p_len; i++) {
    char* word = malloc(p_len*sizeof(char*));
    j = 0;
    while(!isspace(p[i])) {
      word[j++] = p[i++];
      bol = 1;
    }
    if (bol == 1) {
      word[j++] = '\0';
      strcpy(words[w++], word);
      bol = 0;
    }
    free(word);
  }
  return w;
}

int breakInLines(char** lines, char** words, int c, int w) {
  int count, l, i, w_l, k, m, n;
  i = 0, count = 0, l = 0, w_l = 0, k = 0;

  while (i < w) {
    char* line = malloc((c*w)* sizeof(char*));
    if (strlen(words[i])  > c) {
      strcat(line, words[i]);
      i++;
    }
    else {
      while (count < c) {
        count += (strlen(words[i])+1);
        if (count > c) break;
        w_l++;
        i++;
      }
      for (int j = k; j < w_l + k; j++) {
        strcat(line, words[j]);
        if (j < w_l-1 + k) {
          strcat(line, " ");
        }
      }
    }
    line[strlen(line)] = '\0';
    strcpy(lines[l++], line);
    count = 0;
    w_l = 0;
    strcpy(line, "");
    free(line);
    k = i;
  }
  return l;
}

void formatLine(char* line, int c) {
  int s, i, N, loop, S, bol;
  S = c - strlen(line);
  loop = 0;
  s = 0;
  bol = 0;

  for (int a = 0; a < strlen(line); a++) {
    if (line[a] == ' ') {
      bol = 1;
      break;
    }
  }

  if (bol == 0) {
    for (s = 0; s <= S; s++) {
      line = insertchar(line, 0, ' ');
    }
    puts(line);
  }
  else {
    while (s <= S) {
      N = (strlen(line) - 1);
      // printf("%d\n", N);
      for (i = N; i >= 0; i--) {

        if (s > S) break;
        if(line[i] == ' ') {
          // printf("Inserindo espaço em i = %d\n",i);
          line = insertchar(line, i - loop + 1, ' ');
          ++s;
          i  -= (loop+1);
        }
        // puts(line);
      }
      loop++;
    }
    puts(line);
  }
}

/* Insere um espaço na linha quando um espaço é encontrado */
char* insertchar(char* str, int pos, char s) {
  register int r;
  int len = strlen(str)-1;

  for (r = len; r >= pos; r--) {
    str[r + 1] = str[r];
  }
  str[pos] = s;
  str[len+2] = '\0';
  return str;
}


int main(int argc, char** argv) {
  int C = atoi(argv[1]);                  // número de colunas do texto justificado
  char* text = malloc(MAX*sizeof(char));  // max é o tamanho do texto

  int n = 0;
  char curr;
  /* Lê toda a entrada padrão e armazena em um vetor */
  while ((curr = getchar()) != EOF) {
    text[n++] = curr;
  }
  int tam = n;
  n = 0;

  /* Processamento do texto*/
  while (n < tam) {
    int p_len;
    char* p = (char *)malloc(tam*sizeof(char));

    /* Lê um paragrafo */
    p = readParagraph(text, &n, p, tam);
    // puts(p);
    puts("");
    puts("");
    p_len = strlen(p);
    /* Justifica o paragrafo */
    just(p, C, p_len, tam);
    strcpy(p, "");

    /* Pula para o próximo paragrafo */
    while (text[n] == '\n') {
      if (n >= tam) break;
      n++;
    }
    free(p);

  }

}
