0x52B700 ; void splitArguments(start, splitkey)
SUB SP, SP, #0x40
STP X19, X20, [SP,#0x10]
STP X21, X22, [SP,#0x20]
STP X29, X30, [SP,#0x30]
ADD X29, SP, #0x30
MOV X19, X0
MOV W20, W1
MOV X8, X19
LDR W0, [X8] <= _replaceLoop
CBZ W0, _THEEND
CMP W0, W20
B.NE _noReplacement
STR WZR, [X8]
ADD X8, X8, #4 <= _noReplacement
B _replaceLoop
LDP X19, X20, [SP,#0x10] <= _THEEND
LDP X21, X22, [SP,#0x20]
LDP X29, X30, [SP,#0x30]
ADD SP, SP, #0x40
RET

when split = ,
A,B,C
> A null B null C
