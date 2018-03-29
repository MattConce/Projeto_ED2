            EXTERN puts
s    IS  $1

puts      SUBU  s, rSP, 16
          LDOU  s, s, 0
          SETW  rX, 2
          SUBU  s, s, s
write     LDBU  rY, s, 0
          *INT   #DB0101
          JZ    rY, end
          INT   #80
          ADDU  s, s, 1
          JMP   write
end       RET   1
