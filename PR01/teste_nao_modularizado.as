    EXTERN  main
  main    XOR     $0, $0, $0
          SETW    rX, 1
          INT     #80
          CMPU    $0, rA, 10
          JNZ     $0, write
          INT     0
  write   SETW    rX, 2
          LDBU    rY, rA, 0
          INT     #80
          JMP     main
