EXTERN  read


text        IS      $3
n           IS      $4
ret         IS      $5


read        SETW    rX, 1
            INT     #80
            CMPU    $0, rA, 0
            JN      $0, end
            LDBU    text, rA, 0
            ADDU    text, text, 1
            ADDU    n, n, 1
            JMP     read

end         OR      ret, text, 0
            RET     0
