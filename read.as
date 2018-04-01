EXTERN  read


text        IS      $100
n           IS      $4
ret         IS      rA
ret2        IS      $103


read        SETW    rX, 1
            INT     #80
            CMP     $0, rA, 0
            JN      $0, end
            STBU     rA, text, n
            *ADDU     text, text, 1
            ADDU     n, n, 1
            JMP     read

end         XOR     rA, rA, rA
            *OR      ret, text, 0
            OR      ret2, n, 0
            RET     0
