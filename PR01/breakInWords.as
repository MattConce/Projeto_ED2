        EXTERN breakInWords


b             IS      $1
bp            IS      $2
c             IS      $3
p             IS      $4
ret           IS      rA
ret2          IS      $5
tmp           IS      $6
bol           IS      $7
words         IS      $8
j             IS      $9
bol           IS      $10


breakInWords    SUBU  bp, rSP, 32
                LDOU  p, bp, 0
                LDOU  words, bp, 8
                OR    j, words, 0
for             CMPU  $0, p, 0x00
                JZ    $0, ret
while           CMPU  b, p, 32
                JNZ   b, continue
                STBU  p, j, 0
                ADDU  j, j, 1
                ADDU  p, p, 1
                SETW  bol, 1
                JMP   while
continue        CMPU  bol, 1, 1
                JZ    for
                SETB  j, #0
                OR    words, j, 0
                ADDU  words, words, 8
                JMP   for
ret             OR    ret, words
                RET   2
