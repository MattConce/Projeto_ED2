     EXTERN main
main CALL   getchar
     CMP    $0, rA, 10
     JZ     $0, end
     PUSH   $0
     CALL   puts
     JMP    main
end  INT    0
