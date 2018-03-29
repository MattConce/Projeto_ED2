            ESTERN justificador

b             IS      $0
bp            IS      $1
c             IS      $2
p             IS      $3
ret           IS      rA
ret2          IS      $4
tmp           IS      $5
lines         IS      $6
words         IS      $7
l             IS      $8
sav           IS      $355

just        SUBU  bp, rSp, 24
            LDOU  p, bp, 0
            LDOU  c, bp, 8
            PUSH  p
            PUSH  words
            SAVE  sav, $9, $19
            CALL  breakInWords
            OR    words, ret, 0
            REST  sav, $9, $19
            PUSH  lines
            PUSH  words
            PUSH  c
            SAVE  sav, $9, $19
            CALL  breakInLines
            OR    lines, ret, 0
            SAVE  sav, $9, $19
            OR    l, lines, 0
            SUBU  lines, lines, lines
            CMPU  b, lines, l
            PUSH  lines
            PUSH  c
            SAVE  sav, $9, $19
            CALL  formatLine

while
