EXTERN  debugMem     * receives an register containing an memory adress
                     * and prints the value found at said adress

value   IS    $0

debugMem    SETW  rX, 2
            SETW  rY, 45
            INT   #80
            INT   #80
            INT   #80
            INT   #80
            SETW  rY, 68
            INT   #80
            SETW  rY, 69
            INT   #80
            SETW  rY, 66
            INT   #80
            SETW  rY, 85
            INT   #80
            SETW  rY, 71
            INT   #80
            SETW  rY, 32
            INT   #80
            SETW  rY, 83
            INT   #80
            SETW  rY, 10
            INT   #80
            JMP   print
*above prints "----DEBUG S\n"

printNull   SETW  rX, 2
            SETW  rY, 92
            INT   #80
            SETW  rY, 48
            INT   #80
            JMP   end

print       SUBU   rX, rSP, 16
            LDOU   value, rX, 0
            LDBU   rY, value, 0
            CMP    rX, rY, 0
            JZ     rY, printNull
            SETW   rX, 2
            INT    #80

*below prints "----DEBUG E\n"
end         SETW  rY, 10
            INT   #80
            SETW  rY, 45
            INT   #80
            INT   #80
            INT   #80
            INT   #80
            SETW  rY, 68
            INT   #80
            SETW  rY, 69
            INT   #80
            SETW  rY, 66
            INT   #80
            SETW  rY, 85
            INT   #80
            SETW  rY, 71
            INT   #80
            SETW  rY, 32
            INT   #80
            SETW  rY, 69
            INT   #80
            SETW  rY, 10
            INT   #80

            RET     1