          EXTERN breakInLines

          b             IS      $9
          bp            IS      $11
          c             IS      $12
          p             IS      $13
          ret           IS      rA
          ret2          IS      $14
          tmp           IS      $15
          bol           IS      $16
          words_beg     IS      $17
          j             IS      $18
          count         IS      $19
          w             IS      $20
          i             IS      $21
          m             IS      $22  *no just2.c é o w_l (número de palavras por linha)
          lines         IS      $6
          line          IS      $24
          k             IS      $25
          l             IS      $26
          word          IS      $27
          len           IS      $28
          test          IS      $29
          words_end     IS      $30


breakInLines    SUBU  bp, rSP, 40
                LDOU  words_beg, bp, 0
                LDOU  words_end, bp, 8
                LDOU  c, bp, 16
                LDOU  w, bp, 24
                XOR   i, i, i
                SUB  words_beg, words_beg, words_beg
                SUB  words_end, words_end, words_end
teste           CMP   b, test, 10
                JZ    b, int
while1          CMP   b, i, w
                JNN   b, end
                XOR   line, line, line
                LDBU  word, words_beg, 0
                ADD   words_beg, words_beg, 1
                INT    #DB1B1B
                LDBU   len, words_end, 0
                ADDU  words_end, words_end, 1
                INT    #DB1C1C
                SAVE  rSP, $1, $5
                PUSH    word
                PUSH    len
                CALL    puts
                REST    rSP, $1, $5
                SETW    rX, 2
                SETW    rY, 10
                INT     #80
                *INT   #DB1C1C
                ADD   test, test, 1
                JMP   teste
int             INT   0
                CMP   b, len, c
                JN    b, while2
                *STTU  words, line, 0
                ADDU  i, i, 1
                JMP   continue
while2          CMPU  b, count, c
                JNN   b, for
                XOR   tmp, tmp, tmp
                ADDU  count, count, ret
                ADDU  count, count, 1
                CMPU  b, count, c
                JP    b, for
                ADDU  m, m, 1
                ADDU  i, i, 1
                JMP   while2
for             OR    j, k, 0
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
continue        ADDU  line, line, 1
                SETW  line, #0
                STTU  line, lines, 0
                ADDU  lines, lines, 4
                ADDU  l, l, 1
                XOR   count, count, count
                XOR   m, m, m
                XOR   line, line, line
                OR    k, i, 0
                JMP   while1
end             OR    ret, lines, 0
                OR    ret2, l, 0               
                RET   4
