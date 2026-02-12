0xXXXXXX ; FreeSpace
BL 0x9CBE5C

0x9CBE5C ; Input=>Sound
SUB SP, SP, #0x50
STP X29, X30, [SP, #0x40]
ADD X29, SP, #0x40
STP X19, X20, [SP, #0x10]
STP X21, X22, [SP, #0x20]
BL 0x67DB90 ; Minecraft::GetInstance
CBZ X0, _Exit
LDR X20, [X0, #0x58] ; instance->LocalPlayer
CBZ X20, _Exit
ADRP X8, #0x1779000
LDR X8, [X8, #0xEC8]
LDR X19, [X8]
LDR X8, [X19]
LDR X21, [X8, #0x60]
MOV X0, X19
MOV W2, #0x3A ; D-Pad R
MOV W1, #0
BLR X21
CMP W0, #0
B.EQ _ResetRight
LDRB W9, [X20, #0x190]
CBNZ W9, _LeftCheck
MOV W11, #1
STRB W11, [X20, #0x190]
FMOV S0, 10.0 ; volume
MOV X22, #0x460
B _DoPlay
STRB WZR, [X20, #0x190] <=_ResetRight
MOV X0, X19 <=_LeftCheck
MOV W2, #0x39 ; D-Pad L
MOV W1, #0
BLR X21
CMP W0, #0
B.EQ _ResetLeft
LDRB W9, [X20, #0x191]
CBNZ W9, _B_ButtonCheck
MOV W11, #1
STRB W11, [X20, #0x191]
FMOV S0, 0.5 ; pitch
MOV X22, #0x460
B _DoPlay
STRB WZR, [X20, #0x191] <=_ResetLeft
MOV X0, X19 <=_B_ButtonCheck
MOV W2, #0x26
MOV W1, #0
BLR X21
CMP W0, #0
B.EQ _ResetB
LDRB W9, [X20, #0x192]
CBNZ W9, _Exit
MOV W11, #1
STRB W11, [X20, #0x192]
FMOV S0, 1.5
MOV X22, #0x3A0 ; SoundEvent::Craft_item
B _DoPlay
STRB WZR, [X20, #0x192] <=_ResetB
ADRP X8, #0x17A3000 <=_DoPlay
ADD X8, X8, X22
LDR X1, [X8]
MOV X0, X20
FMOV S1, 1 ; pitch::default
BL 0x6CEF10 ; LocalPlayer::playSound(SoundEvent const*, float, float)
LDP X21, X22, [SP, #0x20] <=_Exit
LDP X19, X20, [SP, #0x10]
LDP X29, X30, [SP, #0x40]
ADD SP, SP, #0x50
RET
