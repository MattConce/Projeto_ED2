          EXTERN breakInLines

          b             IS      $9
          bp            IS      $11
          c             IS      $12
          p             IS      $13
          ret           IS      rA
          ret2          IS      $14
          tmp           IS      $15
          bol           IS      $16
          words         IS      $17
          j             IS      $18
          count         IS      $19
          w             IS      $20
          i             IS      $21
          m             IS      $22  *no just2.c é o w_l (número de palavras por linha)
          lines         IS      $23
          line          IS      $24
          k             IS      $25
          l             IS      $26
          sav           IS      $255


breakInLines    SUBU  bp, rSP, 40
                LDOU  lines, bp, 0
                LDOU  words, bp, 8
                LDOU  c, bp, 16
                LDOU  w, bp, 24
                XOR   i, i, i
                SUBU  words, words, words
while1          CMPU  b, i, w
                JZ    b, end
                XOR   line, line, line
                PUSH  words
                SAVE  sav, $26, $29
                CALL  strlen
                OR    tmp, ret, 0
                CMPU  b, tmp, c
                JN    b, while2
                STTU  words, line, 0
                ADDU  i, i, 1
                JMP   continue
while2          CMPU  b, count, c
                JNN   b, for
                XOR   tmp, tmp, tmp
                PUSH  words
                SAVE  sav, $26, $29
                CALL  strlen
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
                STTU  words, line, 0
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
