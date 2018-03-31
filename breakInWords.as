        EXTERN breakInWords

        b             IS      $9
        bp            IS      $11
        c             IS      $12
        p             IS      $101
        ret           IS      rA
        ret2          IS      $14
        tmp           IS      $15
        bol           IS      $16
        words         IS      $17
        word          IS      $18
        w             IS      $19
        i             IS      $20
        t1            IS      $21
        t2            IS      $22
        k             IS      $23
        len           IS      $24

breakInWords    SUBU  bp, rSP, 16
                LDOU  k, bp, 0
for             CMP   b, i, k
                *INT   #DB1717
                JNN   b, end
while           LDBU  t2, p, 0
                CMP   b, t2, 32
                JZ    b, continue
                CMP   b, t2, 10
                JZ    b, continue
                LDBU  word, p, 0
                *INT   #DB1616
                ADDU  word, word, 1
                ADDU  p, p, 1
                ADDU  i, i, 1
                SETW  bol, 1
                JMP   while
continue        CMPU  b, bol, 1
                JN    b, add
                LDTU  words, word, 0
                ADDU  words, words, 4
                ADDU  w, w, 1
                SETW  bol, 0
                SAVE    rSP, $1, $7
                PUSH    word
                CALL    strlen
                REST    rSP, $1, $7
                OR      len, ret, 0
                INT     #DB1818
                SAVE    rSP, $1, $7
                PUSH    word
                PUSH   len
                CALL    puts
                REST    rSP, $1, $7
                XOR   word, word, word
add             ADDU  i, i, 1
                ADDU  p, p, 1
                JMP   for
end             OR    ret, words, 0
                OR    ret2, w, 0
                RET   2
