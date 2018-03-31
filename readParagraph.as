EXTERN readParagraph

                      b             IS      $0
                      bp            IS      $1
                      text          IS      $100
                      p             IS      $3
                      ret           IS      rA
                      ret2          IS      $103
                      tmp           IS      $5
                      tam           IS      $4
                      t1            IS      $9
                      t2            IS      $7
                      i             IS      $6
                      j             IS      $9
                      s             IS      $10



readParagraph         XOR     p, p, p
                      XOR     b, b, b
                      XOR     i, i, i
                      SUBU    bp, rSP, 16
                      LDOU    tam, bp, 0
while                 XOR     b, b, b
                      CMP     b, i, tam
                      JNN     b, end
                      LDBU    t1, text, 0
                      CMP     b, t1, 10
                      JNZ     b, continue
                      OR      j, text, 0
                      ADDU    j, j, 1
                      LDBU    t2, j, 0
                      CMP     b, t2, 10
                      JZ      b, end
continue              LDBU    p, text, 0                      
                      ADDU    i, i, 1
                      ADDU    text, text, 1
                      ADDU    p, p, 1
                      JMP     while
end                   OR      ret, p, 0
                      OR      ret2, i, 0
                      RET     2
