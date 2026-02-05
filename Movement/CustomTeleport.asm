; ZL+ZR = tp先座標設定
; ZL = tp
tpPos = %.1f, %.1f, %.1f



0x52C500 ; getEffect
SUB SP, SP, #0x80
STP X20, X19, [SP,#0x50]
STP X22, X21, [SP,#0x60]
STP X29, X30, [SP,#0x70]
ADD X29, SP, #0x70
BL 0x67DB90 ; Minecraft::GetInstance
LDR X20, [X0, #0x58] ; instance->LocalPlayer
ADRP X22, 0x180F000
ADRP X8, #0x1779000
LDR X8, [X8, #0xEC8]
LDR X9, [X8]
LDR X8, [X9]
LDR X8, [X8,#0x60]
MOV W2, #0x22
MOV X0, X9
MOV W1, #0
BLR X8
TBZ W0, #0, _toggleChanger ; ZRが押されていないならトグルを0に
LDR W0, [X22] ; トグルが1なら何もしない
CBNZ W0, _theEnde
MOV W0, #1
STR W0, [X22]
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
LDR D0, [X20, #0x78]
LDR D1, [X20, #0x80]
LDR D2, [X20, #0x88]
STR D0, [X22, #0x10]
STR D1, [X22, #0x18]
STR D2, [X22, #0x20]
ADRP X21, 0x1870000
ADD X21, X21, #0xA00
ADRP X2, #0x1870000
ADD X2, X2, #0x58
MOV W1, #0x100
MOV X0, X21
ADRP X19, #0x1870000
ADD X19, X19, #0xF00
BL 0x9C9C58 ; swprintf
MOV X0, X21
STP XZR, XZR, [X19,#8]
STR XZR, [X19]
BL 0xB6BBC ; wcslen
MOV X2, X0
MOV X0, X19
MOV X1, X21
BL 0x9C9A98; std::wstring::__init(wchar_t const*,ulong)
MOV X0, X19
BL 0x6A2A10 ; wstring mcprintf(std::wstring const&):
BL 0x9C9AA8 ; std::wstring::~wstring(void)
B _theEnde
NOP <= _Not_ZLPressed
LDR X0, [X22, #0x10] ; nullCheck
CBZ X0, _theEnde
LDR X0, [X22, #0x28] ; nullCheck
CBZ X0, _nullToPos
LDR D0, [X22, #0x28]
LDR D1, [X22, #0x30]
LDR D2, [X22, #0x38]
MOV X0, X20
FMOV S3, 0
FMOV S4, 0
BL 0x1552E0 ; Entity::moveTo(double, double, double, float, float)
STR XZR, [X22, #0x10]
STR XZR, [X22, #0x18]
STR XZR, [X22, #0x20]
STR XZR, [X22, #0x28]
STR XZR, [X22, #0x30]
STR XZR, [X22, #0x38]
B _theEnde
LDR D0, [X20, #0x78] <= _nullToPos
LDR D1, [X20, #0x80]
LDR D2, [X20, #0x88]
STR D0, [X22, #0x28]
STR D1, [X22, #0x30]
STR D2, [X22, #0x38]
LDR D0, [X22, #0x10]
LDR D1, [X22, #0x18]
LDR D2, [X22, #0x20]
MOV X0, X20
FMOV S3, 0
FMOV S4, 0
BL 0x1552E0 ; Entity::moveTo(double, double, double, float, float)
LDP X29, X30, [SP,#0x70] <= _theEnde
LDP X22, X21, [SP,#0x60]
LDP X20, X19, [SP,#0x50]
ADD SP, SP, #0x80
RET
STR WZR, [X22] <= _toggleChanger
B _theEnde
