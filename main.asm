

global main
main:
    ; floating pointing numbers...
    ; [msb][exp][mantisa]
    ;   1    E      M        bits
    ; for normal form numbers ~ -10^38 ... 10^38 ~ 
    ; = (-1)^msb * ( 1 + mantissa / (2^M) ) * 2^(exp - offset)
    ;                 [1; 2)
    ; offset = 2 ^ (M - 1) - 1

    ; ex. float: E = 8 bits, M = 27 bits, offset = 127
    ; ex. double: E = 11 bits, M = 52 bits, offset = 1023
    ; ex. long double (10bytes = 80 bist): E = 15 bits, M = 64 bits (1(hidden mantissa bit) + 63)

    ; denormonlize form (exp = 0) ~ 2^-45 ... 
    ; = (-1)^msb * (mantissa / (2^M) ) * 2^(-offset)
    ;               1 - скрытый бит мантиссы 

    ; special numbers: 
    ; 1) e = 1...1;
    ;  1.1) m = 0; ±inf
    ;  1.2) m != 0; NaN
    ; 2) e = 0...0;
    ;  2.1) m = 0; ±0
    ;  2.2) m != 0; denormolize form

    ; Машинная точность: eps > 0; 1 + eps != 1
    ; a !=(real) b; a == b <=> 1 < (a / b) < 1 + eps
    ; eps = 2 ^ -(M + 1)
    ; ex. float: eps = 2^(-24) ~ 5.96 * 10^-8 семь знаков уверенно
    ; ex. double: eps = 2^(-53) ~ 1.11 * 10^-16 пятнадцать знаков уверенно
    ; a == b !!! abs(a - b) < eps

    ; exerseizes
    ; 1.0 float
    ; 0  0111..111   0000..000

    ; -3/8 = -0.011_2 = 1.1 * 2 ^-2 // 125 
    ; 1  125_2   10000000...

    ; 6.5 = 110.1_2 = 1.101 * 2 ^ 2
    ; 0   10000001 1010...0

    ; 0.1 = 0.0(0011)0011 = 1.10011 * 2 ^ -4 ; exp = 123
    ; 0.1 * 2 = 0.2
    ; 0.2 * 2 = 0.4
    ; 0.4 * 2 = 0.8
    ; 0  01111011 1(0011)(0011)(0011)(0011)(0011)(0011)01


    xor eax, eax
    ret