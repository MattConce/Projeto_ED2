        EXTERN main
c IS $0; p IS $1; cp IS $2; e IS $3; m IS $4; b IS $5; ct IS $6; oc IS $7; l IS $9; au IS $8
main    SETW    c, 0
        SETW    p, 0
        SETW    cp, 0
        SETW    e, 0
        SETW    m, 2
        SETW    b, 0
        SETW    ct, 0
        SETW    oc, 0
        SETW    au, 0
        SETW    l, 65
read    SETW    rX, 1
        INT     #80
        JN      rA, ending
        OR      oc, rA, 0
        CMP     b, rA, 10
        JZ      b, nl
        CMP     b, rA, 32
        JZ      b, esp
        CMP     b, rA, 9
        JZ      b, esp
        STBU    rA, m, 0
        ADDU    m, m, 1
        ADDU    c, c, 1
        ADDU    cp, cp, 1
        ADDU    ct, ct, 1
        CMPU    b, ct, l
        JP      b, eol
        JMP     read
esp     CMPU    b, cp, 0
        JP      b, eow
        JMP     read
nl      CMPU    b, oc, 10
        JZ      b, eop
        JMP     esp
eow     ADDU    p, p, 1
        ADDU    ct, ct, 1
        SUBU    m, m, cp
        SUBU    m, m, 1
        STBU    cp, m, 0
        ADDU    m, m, cp
        ADDU    m, m, 2
        XOR     cp, cp, cp
        JMP     read
eop     SETW    rX, 2
        XOR     m, m, m
eoplop1 XOR     cp, cp, cp
        ADDU    m, m, 1
        LDBU    cp, m, 0
eoplop2 CMPU    b, cp, 0
        JZ      b, endlp2
        ADDU    m, m, 1
        LDBU    rY, m, 0
        INT     #80
        SUBU    cp, cp, 1
        JMP     eoplop2
endlp2  CMPU    b, p, 0
        JZ      b, endeop
        SETW    rY, 32
        INT     #80
        JMP     eoplop1
endeop  SETW    rY, 10
        INT     #80
        INT     #80
        JMP     read
eol     SETW    rX, 2
        XOR     e, e, e
        SUBU    e, l, c
        SUBU    p, p, 1
        DIVU    e, e, p
        ADDU    p, p, 1
        SUBU    m, m, cp
        SUBU    m, m, 1
        STBU    cp, m, 0
        XOR     m, m, m
eoloop1 CMPU    b, p, 0
        JZ      b, eolend
        XOR     cp, cp, cp
        ADDU    m, m, 1
        LDBU    cp, m, 0
eoloop2 CMPU    b, cp, 0
        JZ      b, prntesp
        ADDU    m, m, 1
        LDBU    rY, m, 0
        INT     #80
        SUBU    cp, cp, 1
        JMP     eoloop2
prntesp SETW    rY, 32
        OR      au, e, 0
        ADDU    rR, rR, 1
        CMPU    b, p, rR
        JP      b, loopesp
        ADDU    au, au, 1
        SUBU    rR, rR, 1
loopesp CMPU    b, au, 0
        JZ      b, endesp
        INT     #80
        SUBU    au, au, 1
        JMP     loopesp
endesp  SUBU    rR, rR, 1
        SUBU    p, p, 1
        JMP     eoloop1
eolend  ADDU    m, m, 1
        XOR     cp, cp, cp
        LDBU    cp, m, 0
        OR      au, cp, 0
        SUBU    ct, ct, cp
eolelp  CMPU    b, au, 0
        JZ      b, eolenen
        ADDU    m, m, 1
        LDBU    rA, m, 0
        SUBU    m, m, ct
        STBU    rA, m, 0
        ADDU    m, m, ct
        SUBU    au, au, 1
        JMP     eolelp
eolenen ADDU    m, m, 1
        SUBU    m, m, ct
        XOR     p, p, p
        XOR     c, c, c
        OR      c, cp, 0
        XOR     ct, ct, ct
        JMP     read
eof     CMP     b, c, 0
        SETW    rX, 2
        JZ      b, endeof
        XOR     m, m, m
eoflop1 XOR     cp, cp, cp
        ADDU    m, m, 1
        LDBU    cp, m, 0
eoflop2 CMPU    b, cp, 0
        JZ      b, endelp2
        ADDU    m, m, 1
        LDBU    rY, m, 0
        INT     #80
        SUBU    cp, cp, 1
        JMP     eoflop2
endelp2 CMPU    b, p, 0
        JZ      b, endelp1
        SETW    rY, 32
        INT     #80
        JMP     eoflop1
endelp1 SETW    rY, 10
        INT     #80
endeof  SETW    rY, 0
        INT     #80
        JMP     end
ending  JMP     eof
end     INT     0
