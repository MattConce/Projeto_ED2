EXTERN              read

b         IS  $0
text      IS  $1
tam       IS  $2
ret       IS  rA


read                XOR   text, text, text
next                SETW  rX, 1
                    INT   #80
                    CMP   b, rA, 0
                    JN    b, end
                    STBU  rA, text, 0
                    ADDU  text, text, 1
                    JMP   next
end                 XOR   rA, rA, rA
                    OR    ret, text, 0
                    RET   0
