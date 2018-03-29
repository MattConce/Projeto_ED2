EXTERN readParagraph

                      b             IS      $0
                      bp            IS      $1
                      t             IS      $2
                      p             IS      $3
                      ret           IS      rA
                      ret2          IS      $103
                      tmp           IS      $5
                      tam           IS      $4
                      text          IS      $100


readParagraph         XOR     p, p, p
                      SUBU    bp, rSP, 32
                      LDOU    t, bp, 0
                      LDOU    p, bp, 8                      I
                      LDOU    tam, bp, 16
                      XOR     b, b, b
while                 CMP     b, t, 0
                      JNN     b, end
                      CMP     b, t, 10
                      JNZ     b, continue
                      OR      tmp, t, 0
                      ADDU    tmp, tmp, 1
                      CMP     $0, tmp, 10
                      JZ      $0, end
                      XOR     tmp, tmp, tmp
continue              STBU    t, p, 0
                      ADDU    t, t, 1
                      ADDU    p, p, 1
                      JMP     while
end                   OR      ret, p, 0
                      OR      ret2, t, 0
                      RET     3
