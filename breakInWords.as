        EXTERN breakInWords

        b             IS      $9
        bp            IS      $11
        c             IS      $12
        p             IS      $13
        ret           IS      rA
        ret2          IS      $14
        tmp           IS      $15
        bol           IS      $16
        words         IS      $17
        word          IS      $18
        w             IS      $19
        sav           IS      $255

breakInWords    SUBU  bp, rSP, 32
                LDOU  p, bp, 0
                LDOU  words, bp, 8
for             CMPU  $0, p, 0
                JZ    $0, end
while           CMPU  b, p, 32
                JZ    b, continue
                STBU  p, word, 0
                ADDU  word, word, 1
                ADDU  p, p, 1
                SETW  bol, 1
                JMP   while
continue        CMPU  b, bol, 1
                JZ    b, for
                ADDU  word, word, 1
                SETW  word, #0
                STTU  words, word, 0
                ADDU  words, words, 4
                ADDU  w, w, 1
                JMP   for
end             OR    ret, words
                OR    ret2, w
                RET   2
