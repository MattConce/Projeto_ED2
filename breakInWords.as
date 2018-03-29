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
        bol           IS      $19
        sav           IS      $355

breakInWords    SUBU  bp, rSP, 32
                LDOU  p, bp, 0
                LDOU  words, bp, 8
for             CMPU  $0, p, 0x00
                JZ    $0, ret
while           CMPU  b, p, 32
                JZ    b, continue
                STBU  p, word, 0
                ADDU  word, word, 1
                ADDU  p, p, 1
                SETW  bol, 1
                JMP   while
continue        CMPU  bol, 1, 1
                JZ    for
                ADDU  word, word, 1
                SETB  word, #0
                OR    words, word, 0
                ADDU  words, words, 8
                ADDU  w, w, 1
                JMP   for
ret             OR    ret, words
                OR    ret2, w
                RET   2
