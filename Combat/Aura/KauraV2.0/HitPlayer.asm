0x525200 ; hitPlayer(player)
SUB SP, SP, #0x80
STP X20, X19, [SP,#0x50]
STP X22, X21, [SP,#0x60]
STP X29, X30, [SP,#0x70]
ADD X29, SP, #0x70
MOV X19, X0
CBZ X0, _THEEND
BL 0x67DB90 ; Minecraft::GetInstance
LDR X0, [X0, #0x58]
CBZ X0, _THEEND
MOV W1, WZR
BL 0x6CE488 ; LocalPlayer::swing(InteractionHand::EInteractionHand)
MOV W0, #1
MOV W1, #1
LDR D0, [X19, #0x78]
LDR D1, [X19, #0x80]
FMOV D2, 0.125
FADD D1, D1, D2
LDR D2, [X19, #0x88]
BL 0x52B030 ; movePlayer(double x, double y, double z, onGround, OnFlying)
MOV W0, #0
MOV W1, #0
LDR D0, [X19, #0x78]
LDR D1, [X19, #0x80]
LDR D2, [X19, #0x88]
BL 0x52B030 ; movePlayer(double x, double y, double z, onGround, OnFlying)
LDR X8, [X19] ; ServerboundInteractPacket
ADD X0, SP, #0x30
ADD X1, X19, #8
MOV X2, XZR
BL 0xB80C4
MOV W0, #0x40
BL 0x9C9A78 ; operator new(ulong)
MOV X21, X0
ADD X1, SP, #0x30
BL 0x30F750 ; ServerboundInteractPacket::ServerboundInteractPacket((boost::shared_ptr__tm__8_6Entity))
ADD X0, SP, #0x10
MOV X1, X21
MOV X2, XZR
BL 0x29952C
BL 0x67DB90 ; Minecraft::GetInstance
MOV W1, #0
BL 0x6E019C ; Minecraft::getConnection(int)
ADD X1, SP, #0x10
BL 0x5BF198 ; ClientPacketListener::send(std::shared_ptr<Packet>)
ADD X0, SP, #0x30
BL 0xC5D0
ADD X0, SP, #0x10
BL 0x293C8
MOV W0, #1
MOV W1, #1
LDR D0, [X19, #0x78]
LDR D1, [X19, #0x80]
LDR D2, [X19, #0x88]
BL 0x52B030 ; movePlayer(double x, double y, double z, onGround, OnFlying)
LDP X29, X30, [SP,#0x70] <= _THEEND
LDP X22, X21, [SP,#0x60]
LDP X20, X19, [SP,#0x50]
ADD SP, SP, #0x80
RET
