
*****
* Instância que recebe uma string representando um valor numérico e retorna o
* valor numérico da mesma.
*****

EXTERN  atoi


b           IS      $0                  * variável booleana
int         IS      $1                  * valor numérico
val         IS      $2                  * endereço da string passada
char        IS      $3                  * caractere atual
p           IS      $4                  * magnitude do valor da string (em potência de 10)
i           IS      $5                  * variável auxiliar para calcular int


atoi        XOR     int, int, int       * inicializando as variáveis
            XOR     char, char, char
            XOR     val, val, val
            XOR     b, b, b
            XOR     p, p, p
            SETW    i, 1
            SUBU    val, rSP, 16
            LDOU    val, val, 0

find_p      LDBU    char, val, p        * determina a magnitude do valor numérico
            CMP     b, char, 0
            JZ      b, found_p
            ADD     p, p, 1
            JMP     find_p

found_p     SUB     p, p, 1             * arruma o valor de p para a iteração

convert     LDBU    char, val, p        * converte a string para um número
            SUB     char, char, 48
            MUL     char, char, i
            ADD     int, int, char
            MUL     i, i, 10
            SUB     p, p, 1
            CMP     b, p, 0
            JN      b, end
            JMP     convert

end         XOR     rA, rA, rA          * retorna o valor de int
            OR      rA, int, 0
            RET     1
