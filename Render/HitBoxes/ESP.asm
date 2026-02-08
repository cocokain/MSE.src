0x68AF08 ; Enabled Hitbox
NOP

0x68AF40 ; Color1
ORR W2, WZR, #0xFFFFFF ; white

0x68B114 ; YawColor
ORR W1, WZR, #0xFF ; blue

0x68B0DC ; Eye
ORR W1, WZR, #0xFF0000

------------------------------------
0x68B47C ; ESP
FCVT S0, D4

0x68B484 ; Border
FCVT S1, D4
FCVT S2, D4
