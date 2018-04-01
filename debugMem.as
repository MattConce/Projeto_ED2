EXTERN  debugMem     * receives an register containing an memory adress
                     * and prints the value found at said adress

bp      IS    $0
value   IS    $1

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
*above prints "----DEBUG S\n"

            SUBU   bp, rSP, 16
            *INT    #DB0000
            LDOU   value, bp, 0
            *INT    #DB0101
            LDB    rY, value, 0
            *SETW    bp, 1
            *LDB     rY, bp, 0
            INT     #80

*below prints "----DEBUG E\n"
            SETW  rY, 10
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