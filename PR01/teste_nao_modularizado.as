    EXTERN  main
  main    XOR     $0, $0, $0
          SUBU    $1, rSP, 16
          LDOU    $1, $1, 0
          LDBU    $2, $1, 0
          LDBU    $3, $1, 1
          STBU    $4, $1, 0
          STBU    $4, $2, 1
          *SETW    rX, 1
          *INT     #80
          *CMPU    $0, rA, 10
          *JNZ     $0, write
          *INT     0
  write   SETW    rX, 2
          SETW    rY, 10
          INT     #80
          OR      rY, $4, 0
          INT     #80          
          SETW    rY, 10
          INT     #80
          INT     0
