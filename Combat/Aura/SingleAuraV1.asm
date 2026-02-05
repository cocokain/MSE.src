0x525200 ; singleAura
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
BL 0x52AF50 ; getLivingPlayers #0x1801000
LDR W0, [X22, #0x8C]
ADD W0, W0, #1
STR W0, [X22, #0x8C]
UXTW X0, W0
LSL X0, X0, #3
ADD X0, X22, X0
LDR X8, [X0]
CBNZ X8, _addPlayer
MOV W0, -1
STR W0, [X22, #0x8C]
B _theEnde
MOV X0, X8 <= _addPlayer
ADD X8, X22, #0x70
BL 0x15A408 ; Entity::getUUID(void)
B _theEnde
LDR X0, [X20, #0x58] <= _Not_ZLPressed ; Minecraft::GetInstance ; LocalPlayer->lvl
ADD X1, X22, #0x70
LDR X9, [X1]
CBZ X9, _theEnde
ADD X8, SP, #0x10
BL 0x205314 ; Level::getPlayerByUUID(uuid)
LDR X0, [SP, #0x10]
CBNZ X0, _gotPlayer
MOV W0, -1
STR W0, [X22, #0x8C]
B _theEnde
BL #0x37D588 <= _gotPlayer ; getSystemtime
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
BL 0x67DB90 ; Minecraft::GetInstance
MOV W1, #0
BL 0x6E019C ; Minecraft::getConnection(int)
MOV X19, X0
LDR X0, [SP, #0x10]
MOV X1, X19
BL 0x52B030 ; hitPlayer(player, packetlistener)
MOV W0, #0x50 ; ServerboundMovePlayerPacket
BL 0x9C9A78 ; operator new(ulong)
MOV W1, #1
MOV W2, #1
LDR D0, [X22, #0x58]
LDR D1, [X22, #0x60]
LDR D3, [X22, #0x68]
MOV X21, X0
BL #0x30FFD8
ADD X0, SP, #0x10
MOV X1, X21
MOV X2, XZR
BL  #0x299A3C
ADD X1, SP, #0x10
MOV X0, X19
BL 0x5BF198 ; ClientPacketListener::send(std::shared_ptr<Packet>)
ADD X0, SP, #0x10
BL 0x293C8
LDR X0, [X20, #0x58] <= _theEnde ; Minecraft::GetInstance ; LocalPlayer->lvl
ADD X1, X22, #0x70
LDR X9, [X1]
CBZ X9,  _noTarget1
ADD X8, SP, #0x10
BL 0x205314 ; Level::getPlayerByUUID(uuid)
LDR X0, [SP, #0x10]
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
MOV W0, -1 <= _noTarget1
STR W0, [X22, #0x8C]
ADRP X0, #0x1801000
ADD X0, X0, #0x90
ADD X1, SP, #0x30
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
B _noTarget2
