            EXTERN puts
s    IS  $1
bp   IS  $2
i    IS  $3
n    IS  $4
b    IS  $5

puts      SUBU    bp, rSP, 24
          LDOU    s, bp, 0
          LDOU    n, bp, 8
          INT     #DB0404
          INT     #DB0101
          SETW    rX, 2
          XOR     i, i, i
write     CMP     b, i, n
          JZ      b, end
          LDB     rY, s, 0
          INT     #80
          ADDU    i, i, 1
          ADDU    s, s, 1
          JMP     write
end       RET     2
