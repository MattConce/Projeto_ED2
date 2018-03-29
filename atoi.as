EXTERN  atoi


int         IS      $0
b           IS      $1
val         IS      $2
char        IS      $3
p           IS      $4
i           IS      $5
ret         IS      rA


atoi        XOR     int, int, int
            XOR     char, char, char
            XOR     val, val, val
            XOR     b, b, b
            XOR     p, p, p
            SETW    i, 1
            SUBU    val, rSP, 16
            LDOU    val, val, 0

find_p      LDBU    char, val, p
            CMP     b, char, 0
            JZ      b, found_p
            ADD     p, p, 1
            JMP     find_p

found_p     SUB     p, p, 1

convert     LDBU    char, val, p
            SUB     char, char, 48
            MUL     char, char, i
            ADD     int, int, char
            MUL     i, i, 10
            SUB     p, p, 1
            CMP     b, p, 0
            JN      b, end
            JMP     convert

end         XOR     ret, ret, ret
            OR      ret, int, 0
            RET     1
