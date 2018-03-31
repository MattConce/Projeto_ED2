            EXTERN puts
s    IS  $1
bp   IS  $7
i    IS  $3
n    IS  $4
b    IS  $5
tmp  IS  $6

puts      SUBU    bp, rSP, 24
          LDOU    s, bp, 0
          LDOU    n, bp, 8
          SETW    rX, 2
          XOR     i, i, i
write     CMP     b, i, n
          JZ      b, end
          LDB     rY, s, 0
          LDB     tmp, s, 0
          INT     #80
          ADDU    i, i, 1
          ADDU    s, s, 1
          JMP     write
end       RET     2
