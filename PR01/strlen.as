c IS $0
     EXTERN main
main XOR $0,$0,$0
     SETW rX,1
loop INT #80
     JN rA,end
     ADDU c,c,1
     JMP loop
end  INT #DB0000 *debug
     INT 0
