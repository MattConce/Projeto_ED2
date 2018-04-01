            EXTERN justificador

            b             IS      $0
            bp            IS      $1
            c             IS      $2
            p             IS      $101
            ret           IS      rA
            ret2          IS      $103
            tmp           IS      $5
            lines         IS      $6
            words         IS      $7
            l             IS      $8
            w             IS      $9
            i             IS      $10
            k             IS      $11


justificador  SUBU  bp, rSP, 24
              LDOU  c, bp, 0
              LDOU  k, bp, 8
              SAVE  rSP, $9, $24
              PUSH  k
              CALL  breakInWords
              REST  rSP, $9, $24
              OR    words, ret, 0
              OR    w, ret2, 0
              INT   #DB0909
              SAVE  rSP, $9, $25
              PUSH  lines
              PUSH  words
              PUSH  c
              PUSH  w
              CALL  breakInLines
              OR    lines, ret, 0
              OR    l, ret2, 0
              REST  rSP, $9, $25
              SUBU  lines, lines, lines
              XOR   i, i, i
for           CMPU  b, i, l
              JZ    b, end
              PUSH  lines
              PUSH  c
              SAVE  rSP, $9, $27
              CALL  formatLine
              SAVE  rSP, $9, $27
              ADDU  i, i, 1
              ADDU  lines, lines, 8
              JMP   for
end           RET   2
