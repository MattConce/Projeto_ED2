        EXTERN formatLine

        b             IS      $9
        bp            IS      $11
        c             IS      $12
        s             IS      $13
        ret           IS      rA
        ret2          IS      $14
        N             IS      $15
        bol           IS      $16
        words         IS      $17
        j             IS      $18
        bol           IS      $19
        w             IS      $20
        i             IS      $21
        m             IS      $22
        line          IS      $23
        loop          IS      $24
        a             IS      $25
        S             IS      $26
        len           IS      $27
        tmp           IS      $28
        sav           IS      $455


formatLine        SUBU  bp, rSP, 24
                  LDOU  line, bp, 0
                  LDOU  c, bp, 8
                  XOR   s, s, s
                  XOR   loop, loop, loop
                  XOR   bol, bol, bol
                  XOR   S, S, S
                  PUSH  line
                  SAVE  sav, $29, $32
                  CALL  strlen
                  REST  sav, $29, $32
                  OR    len, ret
                  SUBU  S, c, len
                  XOR   a, a, a
                  SUBU  line, line, line
for1              CMPU  b, a, len
                  JZ    b, continue
                  CMPU  b, line, 32
                  JNZ   b, for1
                  SETW  bol, 1
                  JMP   continue
continue          CMPU  b, bol, 0
                  JNZ   b, while
for2              CMPU  b, s, S
                  JZ    b, print
                  PUSH  line
                  PUSH  0
                  PUSH  32
                  SAVE  sav, $29, $40
                  CALL  insertChar
                  OR    line, ret, 0
                  REST  sav, $29, $40
                  JMP   for2
print             PUSH  line
                  SAVE  sav, $29, $40
                  CALL  puts
                  REST  sav, $29, $40
while             CMPU  b, s, S
                  JP    b, ret
                  OR    N, len, 0
                  SUBU  N, N, 1
for3              CMPU  b, i, 0
                  JNP   b, pass
                  CMPU  b, s, S
                  JP    b, pass
                  CMPU  b, line, 32
                  JNZ   b, pass
                  PUSH  line
                  SUBU  tmp, i, loop
                  ADDU  tmp, tmp, 1
                  PUSH  tmp
                  PUSH  32
                  SAVE  sav, $29, $40
                  CALL  insertChar
                  OR    line, ret, 0
                  ADDU  s, s, 1
                  SUBU  i, i, tmp
                  JMP   for3
pass              ADDU  loop, loop, 1
                  JMP   while
ret               PUSH  line
                  SAVE  sav, $29, $40
                  CALL  puts
                  REST  sav, $29, $40
                  RET   2
