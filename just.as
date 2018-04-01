EXTERN            main

b     IS  $0
c     IS  $1
ret   IS  rA
ret2  IS  rR
text  IS  $2
p     IS  $3
tam   IS  $4
n     IS  $5
k     IS  $6


main              SUBU  c, rSP, 16
                  LDOU  c, c, 0
                  SAVE  rSP, $0, $5
                  PUSH  c
                  CALL  atoi
                  REST  rSP, $0, $5
                  OR    c, ret, 0
                  SAVE  rSP, $0, $5
                  CALL  read
                  REST  rSP, $0, $5
                  OR    text, ret, 0
                  OR    tam, text, 0
                  INT   #DB0202                
                  SUBU  text, text, text
while1            CMP   b, text, tam
                  JZ    b, end
                  SAVE  rSP, $0, $7
                  PUSH  text
                  PUSH  tam
                  CALL  readParagraph
                  REST  rSP, $0, $7
                  OR    p, ret, 0
                  OR    k, p, 0
                  ADDU  n, n, k
                  SUBU  p, p, p
                  SAVE  rSP, $0, $6
                  PUSH  p
                  PUSH  k
                  CALL  puts
                  REST  rSP, $0, $6
                  SETW  rX, 2
                  SETW  rY, 10
                  INT   #80
                  SETW  rX, 2
                  SETW  rY, 10
                  INT   #80
                  SUBU  p, p, p
                  SAVE  rSP, $0, $15
                  PUSH  p
                  PUSH  c
                  PUSH  k
                  CALL  justificador
                  REST  rSP, $0, $15
while2            LDB   b, text, 10
                  JNZ   b, while1
                  ADDU  text, text, 1
                  JMP   while2
end               INT   0
