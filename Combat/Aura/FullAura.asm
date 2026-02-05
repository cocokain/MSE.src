0x525500 ; fullaura
SUB SP, SP, #0x60
STP X20, X19, [SP,#0x30]
STP X22, X21, [SP,#0x40]
STP X29, X30, [SP,#0x50]
ADD X29, SP, #0x50
ADRP X22, 0x1801000
BL #0x37D588 ; getSystemtime
LDR X1, [X22, #0x50]
SUB X1, X0, X1
CMP X1, #1000
B.LE _tickCounter
STR X0, [X22, #0x50]
ADRP X8, #0x1779000
LDR X8, [X8, #0xEC8]
LDR X9, [X8]
LDR X8, [X9]
LDR X8, [X8,#0x60]
MOV W2, #0x22
MOV X0, X9
MOV W1, #0
BLR X8
TBZ W0, #0, _tickCounter ; jump when ZR nor pressed
BL 0x67DB90 ; Minecraft::GetInstance
LDR X0, [X0, #0x58] ; instance->LocalPlayer
LDR D0, [X0, #0x78]
LDR D1, [X0, #0x80]
LDR D3, [X0, #0x88]
STR D0, [X22, #0x58]
STR D1, [X22, #0x60]
STR D3, [X22, #0x68]
BL 0x67DB90 ; Minecraft::GetInstance
MOV W1, #0
BL 0x6E019C ; Minecraft::getConnection(int)
MOV X19, X0
ADD X22, X22, #8 <= _hitLoop
LDR X0, [X22]
CBZ X0, _endLoop
MOV X1, X19
BL 0x525200 ; hitPlayer(player, packetlistener)
B _hitLoop
MOV W0, #1 <= _endLoop ; ServerboundMovePlayerPacket
MOV W1, #1
LDR D0, [X22, #0x58]
LDR D1, [X22, #0x60]
LDR D2, [X22, #0x68]
BL 0x52B030 ; movePlayer(double x, double y, double z, onGround, OnFlying)
ADRP X0, #0x1801000  <= _tickCounter
ADD X0, X0, #0x90
ADD X1, SP, #0x10
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
ADD X0, SP, #0x10
MOV W1, #320
MOV W2, #25
MOVZ W3, #0x6090,LSL #16
MOVK W3, #0x9090
MOV W4, #1
FMOV S0, 3
BL 0x521530 ; wstring  displayString(std::wstring const&, int x, int y, int textcolor, int textalign, float scale):
BL 0x9C9AA8 ; std::wstring::~wstring(void)
LDP X29, X30, [SP,#0x50]
LDP X22, X21, [SP,#0x40]
LDP X20, X19, [SP,#0x30]
ADD SP, SP, #0x60
RET


08000000 01801090 00000046 0000005B
08000000 01801098 0000006C 00000075
08000000 018010A0 00000052 0000006C
08000000 018010A8 0000006E 00000061
08000000 018010B0 00000065 00000067
08000000 018010B8 00000000 0000005D
