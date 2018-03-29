EXTERN  read


text        IS      $3
n           IS      $4


read        SETW    rX, 1
            INT     #80
            CMPU    $0, rA, 0
            JN      $0, end
            LDBU    rA, text, 0
            ADDU    text, text, 1
            ADDU    n, n, 1
            JMP     read

end         RET     0
