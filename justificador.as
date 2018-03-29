            EXPORT justificador

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
            w             IS      $9
            i             IS      $10
            sav           IS      $355

just        SUBU  bp, rSp, 24
            LDOU  p, bp, 0
            LDOU  c, bp, 8
            PUSH  p
            PUSH  words
            SAVE  sav, $9, $19
            CALL  breakInWords
            OR    words, ret, 0
            OR    w, ret2, 0
            REST  sav, $9, $19
            PUSH  lines
            PUSH  words
            PUSH  c
            PUSH  w
            SAVE  sav, $9, $25
            CALL  breakInLines
            OR    lines, ret, 0
            OR    l, rest2, 0
            REST  sav, $9, $25
            SUBU  lines, lines, lines
            XOR   i, i, i
for         CMPU  b, i, l
            JZ    b, ret
            PUSH  lines
            PUSH  c
            SAVE  sav, $9, $27
            CALL  formatLine
            SAVE  sav, $9, $27
            ADDU  i, i, 1
            ADDU  lines, lines, 8
            JMP   for
ret         RET   2
