EXTERN  read


text        IS      $3
n           IS      $4
ret         IS      rA


read        SETW    rX, 1
            INT     #80
            CMP    $0, rA, 0
            JNP     $0, end
            STBU    rA, text, 0
            ADDU    text, text, 1
            ADDU    n, n, 1
            JMP     read

end         OR      ret, text, 0            
            RET     0
