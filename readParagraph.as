EXTERN readParagraph

                      b             IS      $0
                      bp            IS      $1
                      t             IS      $2
                      p             IS      $3
                      ret           IS      rA
                      ret2          IS      $103
                      tmp           IS      $5
                      tam           IS      $4
                      t1            IS      $6
                      t2            IS      $7
                      i             IS      $8
                      j             IS      $9
                      s             IS      $10



readParagraph         XOR     p, p, p
                      XOR     b, b, b
                      XOR     i, i, i
                      SUBU    bp, rSP, 24
                      LDOU    t, bp, 0
                      LDOU    tam, bp, 8
                      INT     #DB0404
                      *INT     #DB0808
while                 XOR     b, b, b
                      CMP     b, i, tam
                      INT     #DB0000
                      JNN     b, end
                      XOR     t1, t1, t1
                      LDB    t1, t, 0
                      INT     #DB0808
                      INT     #DB0606
                      CMP    b, t1, 10
                      JNZ     b, continue
                      OR      j, t, 0
                      *INT     #DB0909
                      ADD    j, j, 1
                      *INT     #DB0909
                      LDB     t2, j, 0
                      CMP     b, t2, 10
                      *INT     #DB0606
                      JZ      b, end
continue              LDB    p, t, 0
                      *INT     #DB0808
                      ADD    i, i, 1
                      ADD    t, t, 1
                      ADD    p, p, 1
                      JMP     while
end                   OR      ret, p, 0
                      *INT     #DB0303
                      OR      ret2, i, 0
                      *INT     #DB0808
                      RET     2
