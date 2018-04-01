EXTERN              breakInLines

b             IS      $0
bp            IS      $1
c             IS      $2
p             IS      $3
ret           IS      rA
ret2          IS      rR
tmp           IS      $5
bol           IS      $6
words_beg     IS      $7
j             IS      $8
words_end     IS      $9
w             IS      $10
i             IS      $11
m             IS      $12  *no just2.c é o w_l (número de palavras por linha)
lines         IS      $13
line          IS      $14
k             IS      $15
l             IS      $16
word          IS      $17
test          IS      $18
len           IS      $19
count         IS      $20


breakInLines      XOR   b, b, b
                  XOR   i, i, i
                  XOR   j, j, j
                  XOR   bp, bp, bp
                  XOR   tmp, tmp, tmp
                  XOR   lines, lines, lines
                  XOR   k, k, k
                  XOR   l, l, l
                  XOR   words_end, words_end, words_end
                  XOR   words_beg, words_beg, words_beg
                  XOR   c, c, c
                  XOR   w, w, w
                  XOR   count, count, count
                  XOR   line, line, line
                  XOR   word, word, word
                  XOR   test, test, test
                  XOR   len, len, len
                  XOR   m, m, m
                  XOR   bol, bol, bol
                  SUBU  bp, rSP, 40
                  LDOU  words_beg, bp, 0
                  LDOU  words_end, bp, 8
                  LDOU  c, bp, 16
                  LDOU  w, bp, 24
teste             CMP   b, test, 10
                  JZ    b, int
while1            CMP   b, i, w
                  JNN   b, end
                  XOR   line, line, line
                  LDBU  word, words_beg, 0
                  INT   #DB1111
                  ADD   words_beg, words_beg, 1
                  LDBU  len, words_end, 0
                  ADDU  words_end, words_end, 1
                  INT   #DB1313
                  SAVE  rSP, $0, $5
                  PUSH  word
                  PUSH  len
                  CALL  puts
                  REST  rSP, $0, $5
                  SETW  rX, 2
                  SETW  rY, 10
                  INT    #80
                  ADD   test, test, 1
                  JMP   teste
int               INT   0
                  CMP   b, len, c
                  JN    b, while2
                  *STTU  words, line, 0
                  ADDU  i, i, 1
                  JMP   continue
while2            CMPU  b, count, c
                  JNN   b, for
                  XOR   tmp, tmp, tmp
                  ADDU  count, count, ret
                  ADDU  count, count, 1
                  CMPU  b, count, c
                  JP    b, for
                  ADDU  m, m, 1
                  ADDU  i, i, 1
                  JMP   while2
for               OR    j, k, 0
                  ADDU  m, m, k
                  CMPU  b, j, m
                  JNN   b, continue
                  *STTU  words, line, 0
                  OR    bol, m, 0
                  ADDU  bol, bol, k
                  SUBU  bol, bol, 1
                  CMPU  b, j, bol
                  JNN   b, for
                  ADDU  line, line, 4
                  SETW  line, 32
                  JMP   for
continue          ADDU  line, line, 1
                  SETW  line, #0
                  STTU  line, lines, 0
                  ADDU  lines, lines, 4
                  ADDU  l, l, 1
                  XOR   count, count, count
                  XOR   m, m, m
                  XOR   line, line, line
                  OR    k, i, 0
                  JMP   while1
end               OR    ret, lines, 0
                  OR    ret2, l, 0
                  RET   4
