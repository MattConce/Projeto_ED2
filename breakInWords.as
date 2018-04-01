EXTERN breakInWords

  b             IS      $9
  bp            IS      $11
  c             IS      $12
  p             IS      $101
  ret           IS      rA
  ret2          IS      $103
  ret3          IS      $107
  tmp           IS      $15
  bol           IS      $16
  words_beg     IS      $17
  word          IS      $18
  w             IS      $19
  i             IS      $20
  t1            IS      $21
  t2            IS      $22
  k             IS      $23
  len           IS      $24
  t             IS      $25
  words_end     IS      $26


breakInWords    SUBU  bp, rSP, 16
                LDOU  k, bp, 0
                XOR   tmp, tmp, tmp
for             CMP   b, i, k
                *INT   #DB1717
                JNN   b, end
while           LDBU  t2, p, 0
                CMP   b, t2, 32
                JZ    b, continue
                CMP   b, t2, 10
                JZ    b, continue
                LDBU   word, p, 0
                *INT   #DB1212
                ADDU  p, p, 1
                ADDU  i, i, 1
                ADDU  word, word, 1          *depuração
                ADDU  len, len, 1
                SETW  bol, 1
                JMP   while
continue        CMPU  b, bol, 1
                JN    b, add
                XOR   word, word, word
                SUBU  word, p, len
                STBU  len, words_end, 0
                LDBU  tmp, words_end, 0
                INT   #DB0F0F
                ADDU  words_end, words_end, 1
                LDBU  t, word, 0
                STBU  t, words_beg, 0     *guarda as palavras num vetor
                ADDU  words_beg, words_beg, 1
                ADDU  w, w, 1
                *INT   #DB1313
                SETW  bol, 0
                *INT     #DB1818
                SETW    rX, 2
                SETW    rY, 10
                INT     #80
                *INT   #DB1212
                SETW    rX, 2
                SETW    rY, 10
                INT     #80
                *INT     #DB1818
                *INT     #DB6565
                SAVE    rSP, $1, $5
                PUSH    word
                PUSH    len
                CALL    puts
                REST    rSP, $1, $5
                SETW    rX, 2
                SETW    rY, 10
                INT     #80
add             XOR   word, word, word
                XOR   len, len, len
                ADDU  i, i, 1
                ADDU  p, p, 1
                JMP   for
end             OR    ret, words_beg, 0
                OR    ret2, w, 0
                OR    ret3, words_end, 0
                RET   1
