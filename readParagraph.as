EXTERN              readParagraph

b       IS  $0
bp      IS  $1
text    IS  $2
p       IS  $3
ret     IS  rA
ret2    IS  rR
i       IS  $4
j       IS  $5
tmp     IS  $6
tam     IS  $7



readParagraph      XOR  p, p, p
                   XOR  i, i, i
                   XOR  text, text, text
                   XOR  bp, bp, bp
                   XOR  j, j, j
                   XOR  tmp, tmp, tmp
                   XOR  tam, tam, tam
                   SUBU bp, rSP, 24
                   LDOU text, bp, 0
                   LDOU tam, bp, 8
while              CMP  b, i, tam
                   JNN  b, end
                   LDBU tmp, text, 0                   
                   CMP  b, tmp, 10
                   JNZ  b, continue
                   OR   j, text, 0
                   ADDU j, j, 1
                   XOR  tmp, tmp, tmp
                   LDBU tmp, j, 0
                   CMP  b, tmp, 10
                   JZ   b, end
continue           XOR  tmp,tmp, tmp
                   LDBU tmp, text, 0
                   STBU tmp, p, 0
                   ADDU i, i, 1
                   ADDU p, p, 1
                   ADDU text, text, 1
                   JMP  while
end                OR   ret, p, 0
                   RET  2
