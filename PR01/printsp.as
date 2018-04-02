EXTERN  printsp


b           IS      $0
n           IS      $1


printsp     SETW    rX,2
            SETW    rY, 32
            SUBU    n, rSP, 16
            LDOU    n, n, 0

print       CMP     b, n, 0
            JZ      b, end
            INT     #80
            SUB     n, n, 1
            JMP     print

end         RET     1
