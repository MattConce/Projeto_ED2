EXTERN              breakInWords

b         IS  $0
bp        IS  $1
c         IS  $2
p         IS  $3
ret       IS  rA
ret2      IS  rR
ret3      IS  $107
tmp       IS  $4
bol       IS  $5
words_beg IS  $6
words_end IS  $7
word      IS  $8
i         IS  $9
j         IS  $10
w         IS  $11
k         IS  $12
t         IS  $13
len       IS  $14


breakInWords        XOR  b, b, b
                    XOR  i, i, i
                    XOR  j, j, j
                    XOR  bp, bp, bp
                    XOR  tmp, tmp, tmp
                    XOR  k, k, k
                    XOR  p, p, p
                    XOR  words_end, words_end, words_end
                    XOR  words_beg, words_beg, words_beg
                    XOR  c, c, c
                    XOR  w, w, w
                    XOR  word, word, word
                    XOR  t, t, t
                    XOR  len, len, len
                    XOR  bol, bol, bol
                    SUBU  bp, rSP, 24
                    LDOU  p, bp, 0
                    LDOU  k, bp, 8
for                 CMP   b, i, k
                    JNN   b, end
while               LDBU  tmp, p, 0
                    CMP   b, tmp, 32
                    JZ    b, continue
                    CMP   b, tmp, 10
                    JZ    b, continue
                    ADDU  p, p, 1
                    ADDU  i, i, 1
                    ADDU  len, len, 1
                    SETW  bol, 1
                    JMP   while
continue            CMPU  b, bol, 1
                    JN    b, add
                    XOR   word, word, word
                    XOR   tmp, tmp, tmp
                    STBU  len, words_end, 0
                    LDBU  t, words_end, 0
                    INT   #DB0D0D
                    ADDU  words_end, words_end, 1
                    SUBU  word, p, len
                    LDBU  tmp, word, 0
                    INT   #DB0404
                    STBU  tmp, words_beg, 0
                    ADDU  words_beg, words_beg, 1
                    ADDU  w, w, 1
                    SETW  bol, 0
                    SETW  rX, 2
                    SETW  rY, 10
                    INT   #80
                    SETW  rX, 2
                    SETW  rY, 10
                    INT   #80
                    SAVE  rSP, $0, $6
                    PUSH  word
                    PUSH  len
                    CALL  puts
                    REST  rSP, $0, $6
                    SETW  rX, 2
                    SETW  rY, 10
                    INT   #80
add                 XOR   word, word, word
                    XOR   len, len, len
                    ADDU  i, i, 1
                    ADDU  p, p, 1
                    JMP   for
end                 OR    ret, words_beg, 0
                    OR    ret2, words_end, 0
                    OR    ret3, w, 0
                    RET   2
