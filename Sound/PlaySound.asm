0xXXXXXX ; Free Space
BL 0x9CBE5C

;bl
0x9CBE5C ; PlaySound::Loop
SUB SP, SP, #0x50
STP X29, X30, [SP, #0x40]
ADD X29, SP, #0x40
STP X19, X20, [SP, #0x10]
BL 0x67DB90 ; Minecraft::GetInstance
CBZ X0, _End
LDR X20, [X0, #0x58] ; instance->LocalPlayer
CBZ X20, _End
ADRP X8, #0x17A3000
ADD X8, X8, #0x460
LDR X1, [X8] ; SoundEvent::random_orb
MOV X0, X20
FMOV S0, 1.0 ; pitch
FMOV S1, 1.0 ; volume
BL 0x6CEF10 ; LocalPlayer::playSound(SoundEvent const*, float, float)
LDP X19, X20, [SP, #0x10] <=_End
LDP X29, X30, [SP, #0x40]
ADD SP, SP, #0x50
RET
