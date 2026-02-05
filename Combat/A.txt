0x1871000:
"Instant Craft Successfully"

0x562994: ; Achievement menu
BL 0x569130
B 0x562E5C

0x569130:
SUB SP, SP, #0x40
STP X20, X19, [SP,#0x20]
STP X29, X30, [SP,#0x30]
ADD X29, SP, #0x30 
mov W0, #0x9e
BL _CraftFunction
mov W0, #0x9f
BL _CraftFunction
mov W0, #0xa0
BL _CraftFunction
mov W0, #0xa1
BL _CraftFunction
mov W0, #0x184
BL _CraftFunction
mov W20, #0x40
sub W20, W20, #1 <= _CraftGappleLoop
mov W0, #0x24
BL _CraftFunction
CBNZ W20, _CraftGappleLoop
ADRP X0, #0x1871000 ; ""
ADD X1, X0, #0x100
BL 0x6A2A10 ; wstring mcprintf(wchar_t, temp):
BL 0x9C9AA8 ; std::wstring::~wstring(void)
LDP X29, X30, [SP,#0x30]
LDP X20, X19, [SP,#0x20]
ADD SP, SP, #0x40
RET
SUB SP, SP, #0x40 <= _CraftFunction
STP X20, X19, [SP,#0x20]
STP X29, X30, [SP,#0x30]
ADD X29, SP, #0x30 
MOV W20, W0 
BL 0x67DB90 ; mc::Minecraft::getInstance();
MOV W1,0
BL 0x6E019C ; Minecraft::getConnection(int)
MOV X19,X0
MOV W0, #0x60 ;
BL 0x9C9A78 ; _Znwm_0 ; operator new(ulong)
MOV W1, W20
MOV W2, WZR
MOV W3, WZR
MOV X20, X0
BL 0xF1534 ; mc::CraftItemPacket(int,int,int)
ADD X0, SP, #0x10
MOV X1, X20
MOV X2, XZR
BL 0x29DD3C ; ???
ADD X1, SP, #0x10
MOV X0, X19 ; getInstance->getconnection(0);
BL 0x5BF198 ; ClientPacketListener::send(std::shared_ptr<Packet>)
ADD X0, SP, #0x10
BL 0x293C8
LDP X29, X30, [SP,#0x30]
LDP X20, X19, [SP,#0x20]
ADD SP, SP, #0x40
RET
