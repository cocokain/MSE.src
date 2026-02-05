0x69C980 ; Fullbright 
MOVZ W0, #1
0x69CB60
FMOV S0, #1.0
RET

0x69C980 ; Fullbright Restore
BLX X8
0x69CB60
STR D8, [SP, #-0x20]!
STP X29, X30, [SP, #0x10]
