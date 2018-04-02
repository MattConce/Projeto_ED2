EXTERN  main

*==  IMPORTANT: Implementing malloc would be interesting, seeing as
*    in its current state, this program merely supposes certain memory
*    adresses won't be used, and has a limited amount of adresses it can store
*    bytes onto (see table below)
*=============================================

*==  MEMORY TABLE: ===========================
*  M[10000]-M[59999]     whole text memory segment
*  M[60000]-M[109999]    words memory segment
*  M[110000]-M[160000]   justified paragraph segment
*  M[200000]-M[225000]   words length segment
*=============================================

arg        IS        $0               * cmd line argument ('C')
mem        IS        $1               * first byte's memory adress (used when read is called)
lastmem    IS        $2               * last std input stored byte's mem adress
par_last   IS        $3               * paragraph's last byte's mem adress
word_last  IS        $4               * words memory segment last adress

main          SUBU    arg, rSP, 16
              LDOU    arg, arg, 0
              SAVE    rSP, $0, $5
              PUSH    arg
              CALL    atoi                    *converts argument to int value
              REST    rSP, $0, $5
              OR      arg, rA, 0
              SETW    mem, 10000              *hard coding first byte's memory adress
              SAVE    rSP, $0, $1
              PUSH    mem
              CALL    read                    *stores text from M[mem] onwards, up to M[mem+49999]
              REST    rSP, $0, $1
              OR      lastmem, rA, 0          *text bytes are within M[mem] and M[lastmem]
while         SAVE    rSP, $0, $2
              PUSH    lastmem
              CALL    readParagraph           *find a paragraph and store its' last byte adress
              REST    rSP, $0, $2
              OR      par_last, rA, 0
              SAVE    rSP, $0, $4
              PUSH    mem
              PUSH    par_last
              CALL    splitWords              * [store words in another memory segment, separating
              REST    rSP, $0, $4             *  words by inserting NULL at the end of each word]
              OR      word_last, rA, 0

              SAVE    rSP, (!!!!!!)
              PUSH    mem                     * [even though we push mem here, we have to manually
              PUSH    word_last               *  pinpoint the adress in justify.as]
              CALL    justify
              REST    rSP, (!!!!!!)
              OR      , rA, 0

              INT     0
