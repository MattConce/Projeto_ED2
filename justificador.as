EXTERN              justificador

b         IS  $0
bp        IS  $1
p         IS  $2
ret       IS  rA
ret2      IS  rR
ret3      IS  $107
tmp       IS  $5
lines     IS  $6
words_beg IS  $7
words_end IS  $8
i         IS  $9
j         IS  $10
k         IS  $11
l         IS  $12
c         IS  $13
w         IS  $14


justificador        XOR   b, b, b
                    XOR   i, i, i
                    XOR   j, j, j
                    XOR   bp, bp, bp
                    XOR   tmp, tmp, tmp
                    XOR   lines, lines, lines
                    XOR   k, k, k
                    XOR   l, l, l
                    XOR   words_end, words_end, words_end
                    XOR   words_beg, words_beg, words_beg
                    XOR   c, c, c
                    XOR   w, w, w
                    SUBU  bp, rSP, 32
                    LDOU  p, bp, 0
                    LDOU  c, bp, 8
                    LDOU  k, bp, 16
                    SAVE  rSP, $0, $20
                    PUSH  p
                    PUSH  k
                    CALL  breakInWords
                    REST  rSP, $0, $20
                    OR    words_beg, ret, 0
                    OR    words_end, ret2, 0
                    OR    w, ret3, 0
                    SUBU  words_beg, words_beg, words_beg
                    SUBU  words_end, words_end, words_end
                    SAVE  rSP, $0, $20
                    PUSH  words_beg
                    PUSH  words_end
                    PUSH  c
                    PUSH  w
                    CALL  breakInLines
                    REST  rSP, $0, $20
                    OR    lines, ret, 0
                    OR    l, lines, 0
                    SUBU  lines, lines, lines
                    XOR   i, i, i
for                 CMP   b, i, l
                    JZ    b, end
                    SAVE  rSP, $0, $30
                    PUSH  lines
                    PUSH  c
                    CALL  formatLine
                    REST  rSP, $0, $30
                    ADDU  i, i, 1
                    ADDU  lines, lines, 8
                    JMP   for
end                 RET   3
