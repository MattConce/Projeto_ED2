EXTERN readParagraph

b             IS      $1
bp            IS      $2
t             IS      $3
p             IS      $4
ret           IS      rA
ret2          IS      $5
tmp           IS      $6


readParagraph SUBU    bp, rSP, 24
              LDOU    t, bp, 0
              LDOU    p, bp, 8
              CMPU    b, text, 0
              JZ      b, ret
              CMPU    b, text, 10
              JNZ     b, continue
              OR      tmp, text, 0
              ADDU    tmp, tmp, 1
              CMPU    $0, tmp, 10
              JZ      $0, ret
              XOR     tmp, tmp, tmp
continue      LDBU    p, text, 0
              ADDU    text, text, 1
              ADDU    p, p, 1
ret           SETB    p, 0
              ADDU    p, p, 1
              OR      ret, p, 0
              OR      ret2, t, 0
              RET     2
