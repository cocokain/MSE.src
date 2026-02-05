0x525300 ; laura
SUB SP, SP, #0x80
STP X20, X19, [SP,#0x50]
STP X22, X21, [SP,#0x60]
STP X29, X30, [SP,#0x70]
ADD X29, SP, #0x70
BL 0x67DB90 ; Minecraft::GetInstance
LDR X20, [X0, #0x58] ; instance->LocalPlayer
ADRP X22, 0x1801000
ADRP X8, #0x1779000
LDR X8, [X8, #0xEC8]
LDR X9, [X8]
LDR X8, [X9]
LDR X8, [X8,#0x60]
MOV W2, #0x22
MOV X0, X9
MOV W1, #0
BLR X8
TBZ W0, #0, _toggleChanger
LDR W0, [X22, #0x88]
CBNZ W0, _theEnde
ADRP X8, #0x1779000
LDR X8, [X8, #0xEC8]
LDR X9, [X8]
LDR X8, [X9]
LDR X8, [X8,#0x60]
MOV W2, #0x21
MOV X0, X9
MOV W1, #0
BLR X8
TBZ W0, #0, _Not_ZLPressed
MOV W0, #1
STR W0, [X22, #0x88]
ADRP X8, #0x17A3000
ADD X8, X8, #0x460
LDR X1, [X8] ; SoundEvent::random_orb
MOV X0, X20
FMOV S0, 0.75
FMOV S1, 0.5
BL 0x6CEF10 ; LocalPlayer::playSound(SoundEvent const*, float, float)
LDR W0, [X22, #0x8C] <= _reSearchPlayer
ADD W0, W0, #1
STR W0, [X22, #0x8C]
UXTW X0, W0
LSL X0, X0, #3
ADD X0, X22, X0
LDR X8, [X0]
CBNZ X8, _addPlayer
MOV W0, -1
STR W0, [X22, #0x8C]
B _reSearchPlayer
MOV X0, X8 <= _addPlayer
MOV X21, X0
ADD X8, X22, #0x70
BL 0x15A408 ; Entity::getUUID(void)
ADRP X0, #0x1801000
ADD X0, X0, #0x3DC
ADRP X1, #0x1870000
ADD X1, X1, #0xF00
MOV X19, X1
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
LDR W0, [X22, #0x8C]
CBNZ X0, _SingleText
ADRP X0, #0x1801000
ADD X0, X0, #0x3AC
B _Fullrangetext
MOV X0, X21 <= _SingleText
ADD X8, SP, #0x10
BL 0x2D1024 ; LocalPlayer::getNetworkName(void)
ADD X0, SP, #0x10
BL 0x52B270 ; getWchar(std::wstring)
MOV X1, X0 <= _Fullrangetext
MOV X0, X19
BL 0x9C9AB8 ; std::wstring::append(wchar_t const*)
MOV X0, X19
BL 0x6A2A10 ; wstring mcprintf(std::wstring const&):
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADD X0, SP, #0x10
BL 0x9C9AA8 ; std::wstring::~wstring(void)
B _theEnde
BL #0x37D588  <= _Not_ZLPressed ; Minecraft::GetInstance ; LocalPlayer->lvl
LDR X1, [X22, #0x50]
SUB X1, X0, X1
CMP X1, #600
B.LE _theEnde
STR X0, [X22, #0x50]
LDR D0, [X20, #0x78]
LDR D1, [X20, #0x80]
LDR D3, [X20, #0x88]
STR D0, [X22, #0x58]
STR D1, [X22, #0x60]
STR D3, [X22, #0x68]
LDR W0, [X22, #0x8C]
CBZ W0, _fullauraExec
LDR X0, [X20, #0x58] ; Minecraft::GetInstance ; LocalPlayer->lvl
ADD X1, X22, #0x70
LDR X9, [X1]
CBZ X9, _theEnde
ADD X8, SP, #0x28
BL 0x205314 ; Level::getPlayerByUUID(uuid)
LDR X0, [SP, #0x28]
CBZ X0, _theEnde
BL 0x525200 ; hitPlayer(player)
MOV W0, #1 <= _endLoop ; Fullaura
MOV W1, #1
LDR D0, [X22, #0x58]
LDR D1, [X22, #0x60]
LDR D2, [X22, #0x68]
BL 0x52B030 ; movePlayer(double x, double y, double z, onGround, OnFlying)
B _theEnde
ADRP X21, 0x1801000 <= _fullauraExec
ADD X21, X21, #8 <= _hitLoop
LDR X0, [X21]
CBZ X0, _endLoop
BL 0x525200 ; hitPlayer(player)
B _hitLoop
LDR W0, [X22, #0x8C] <= _theEnde 
CBZ W0, _fullauraView
LDR X0, [X20, #0x58] ; Minecraft::GetInstance ; LocalPlayer->lvl
ADD X1, X22, #0x70
LDR X9, [X1]
CBZ X9, _noTarget1
ADD X8, SP, #0x28
BL 0x205314 ; Level::getPlayerByUUID(uuid)
LDR X0, [SP, #0x28]
CBZ X0, _noTarget1
ADD X8, SP, #0x30
BL 0x2D1024 ; LocalPlayer::getNetworkName(void)
ADD X0, SP, #0x30 <= _noTarget2
MOV W1, #320
MOV W2, #25
MOVZ W3, #0x6090,LSL #16
MOVK W3, #0x9090
MOV W4, #1
FMOV S0, 3
BL 0x521530 ; wstring  displayString(std::wstring const&, int x, int y, int textcolor, int textalign, float scale):
BL 0x9C9AA8 ; std::wstring::~wstring(void)
LDP X29, X30, [SP,#0x70]
LDP X22, X21, [SP,#0x60]
LDP X20, X19, [SP,#0x50]
ADD SP, SP, #0x80
RET
STR WZR, [X22, #0x88] <= _toggleChanger
B _theEnde
ADRP X0, #0x1801000 <= _noTarget1
ADD X0, X0, #0x390
ADD X1, SP, #0x30
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
B _noTarget2
ADRP X0, #0x1801000 <= _fullauraView
ADD X0, X0, #0x3AC
ADD X1, SP, #0x30
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
B _noTarget2


08000000 01801390 0000004E 0000005B
08000000 01801398 0000006E 0000006F
08000000 018013A0 0000005D 00000065
08000000 018013A8 0000005B 00000000
08000000 018013B0 00000075 00000046
08000000 018013B8 0000006C 0000006C
08000000 018013C0 00000061 00000072
08000000 018013C8 00000067 0000006E
08000000 018013D0 0000005D 00000065
08000000 018013D8 0000005B 00000000
08000000 018013E0 00000061 0000004C
08000000 018013E8 00000072 00000075
08000000 018013F0 0000005D 00000061
08000000 018013F8 00000074 00000020
08000000 01801400 00000072 00000061
08000000 01801408 00000065 00000067
08000000 01801410 00000020 00000074
08000000 01801418 00000020 0000003D
08000000 01801420 00000000 00000000


0x1801390 : [None]
0x18013AC : [Fullrange]
0x18013DC : [Laura] target =
