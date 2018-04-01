EXTERN  main

*==  IMPORTANT: Implementing malloc would be interesting, seeing as
*    in its current state, this program merely supposes certain memory
*    adresses won't be used, and has a limited amount of adresses it can store
*    bytes onto (see table below)
*=============================================

*==  MEMORY TABLE: ===========================
*  M[10000]-M[59999]     whole text memory segment
*  M[60000]-M[109999]    words memory segment
*=============================================

arg        IS        $0               * cmd line argument ('C')
lastmem    IS        $1               * last std input stored byte's mem adress
par_last   IS        $2               * paragraph's last byte's mem adress
word_last  IS        $3               * words memory segment last adress

main          SUBU    arg, rSP, 16
              LDOU    arg, arg, 0
              SAVE    rSP, $0, $5
              PUSH    arg
              CALL    atoi                    *converts argument to int value
              REST    rSP, $0, $5
              OR      arg, rA, 0
              SAVE    rSP, $0, $1
              CALL    read                    *stores text from M[10000] onwards, up to M[59999]
              REST    rSP, $0, $1
              OR      lastmem, rA, 0          *text bytes within M[10000] and M[lastmem]
while         SAVE    rSP, $0, $2
              PUSH    lastmem
              CALL    readParagraph
              REST    rSP, $0, $2
              OR      par_last, rA, 0
*
              SETW    $40, 10000
              SAVE    rSP, $0, $4
              PUSH    $40
              PUSH    par_last
              CALL    splitWords
              REST    rSP, $0, $4
              OR      word_last, rA, 0
              INT     #DB0303
*
              INT     0
