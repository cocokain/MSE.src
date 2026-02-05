0x52B030 ; movePlayer(double x, double y, double z, onGround, OnFlying)
SUB SP, SP, #0x80
STP X21, X22, [SP,#0x50]
STP X19, X20, [SP,#0x60]
STP X29, X30, [SP,#0x70]
ADD X29, SP, #0x70
MOV W21, W0
MOV W22, W1
MOV W0, #0x50 ; ServerboundMovePlayerPacket
BL 0x9C9A78 ; operator new(ulong)
MOV X19, X0
MOV W1, W21
MOV W2, W22
FMOV D3, D2
BL #0x30FFD8
ADD X0, SP, #0x20
MOV X1, X19
MOV X2, XZR
BL #0x299A3C
BL 0x67DB90 ; Minecraft::GetInstance
MOV W1, #0
BL 0x6E019C ; Minecraft::getConnection(int)
ADD X1, SP, #0x20
BL 0x5BF198 ; ClientPacketListener::send(std::shared_ptr<Packet>)
ADD X0, SP, #0x20
BL 0x293C8
LDP X29, X30, [SP,#0x70]
LDP X19, X20, [SP,#0x60]
LDP X21, X22, [SP,#0x50]
ADD SP, SP, #0x80
RET
