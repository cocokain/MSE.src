X21 ItemInstance
X22 tag
X23 list

Creditmenu hook
0x562620:
BL 0x52B650
B 0x562E5C



0x52B650 ; callkeyboard
SUB SP, SP, #0x50
STP X20, X19, [SP,#0x10]
STP X22, X21, [SP,#0x20]
STP X24, X23, [SP,#0x30]
STP X29, X30, [SP,#0x40]
ADD X29, SP, #0x40
ADRP X20, #0x1779000
LDR X20, [X20, #0xEC8]
LDR X20, [X20] ; KEYBOARD OBJECT?
LDR X24, [X20]
LDR X24, [X24, #0x130] ; CINPUT::REQUESTKEYBOARD
ADRP X21, #0xCD1000
ADD X21, X21, #0x55C
MOV X0, X20 ; KEYBOARD OBJECT
MOV X1, X21 ; HEADER TEXT
ADRP X2, #0x1855000 ; "/nbt"
MOV W3, WZR
MOV W4, #0x3F ; MAX TEXT LENGTH
ADRP X5, #0x52B000
ADD X5, X5, #0x860
ADRP X6, #0x1855000 ; "/nbt"
MOV W7, WZR ; KEYBOARD MODE
BLR X24 ; CALLS CINPUT::REQUESTKEYBOARD
LDP X29, X30, [SP,#0x40]
LDP X24, X23, [SP,#0x30]
LDP X22, X21, [SP,#0x20]
LDP X20, X19, [SP,#0x10]
ADD SP, SP, #0x50
RET



08000000 01855000 0000006E 0000002F
08000000 01855008 00000074 00000062
08000000 01855010 0000002F 00000000
08000000 01855018 00000069 0000006E
08000000 01855020 0000006B 00000063
08000000 01855028 0000002F 00000000
08000000 01855030 00000061 00000067
08000000 01855038 00000065 00000074
08000000 01855040 0000002F 00000000
08000000 01855048 00000061 00000070
08000000 01855050 0000006F 0000006E
08000000 01855058 00000061 00000072
08000000 01855060 00000061 0000006D
08000000 01855068 00000065 00000000
08000000 01855070 00000061 00000000
08000000 01855078 00000070 00000000
08000000 01855080 00000075 00000000
08000000 01855088 00000073 00000000
08000000 01855090 00000068 00000000
08000000 01855098 00000064 00000000
08000000 018550A0 0000002F 00000000
08000000 018550A8 00000068 00000073
08000000 018550B0 00000070 0000006F
08000000 018550B8 0000002F 00000000
08000000 018550C0 0000006E 00000075
08000000 018550C8 00000065 00000073
08000000 018550D0 0000006C 0000006C
04000000 018550D8 00000000


0x1855000 : /nbt
0x1855014 : /nick
0x185502C : /gate
0x1855044 : /panorama
0x185506C : e
0x1855074 : a
0x185507C : p
0x1855084 : u
0x185508C : s
0x1855094 : h
0x185509C : d
0x18550A4 : /shop
0x18550BC : /unsell

0x1855000
/nbt
/nick
/gate
/panorama
e
a
p
u
s
h
d
/shop
/unsell

0x52B860 ; Called once the keyboard is closed
SUB SP, SP, #0xB0
STP X20, X19, [SP,#0x60]
STP X22, X21, [SP,#0x70]
STP X24, X23, [SP,#0x80]
STP X26, X25, [SP,#0x90]
STP X29, X30, [SP,#0xA0]
ADD X29, SP, #0xA0 ; STR WZR, [X0, #0x24] ; SOME BUTTON STATE THING
TBZ W1, #0, _THEEND
ADRP X8, #0x1779000
LDR X8, [X8, #0xec8]
LDR X0, [X8] ; Keyboard object?
LDR X8, [X0]
LDR X8, [X8, #0x140]
ADRP X1, #0x1852000
MOV W2, #0x7F
BLR X8 
ADRP X26, #0x1852000
MOV X0, X26
MOV W1, #0x20 ; " " space
BL 0x52B700 ; void splitArguments(start, splitkey)
MOV X0, X26
MOV X1, #1
BL 0x52B780 ; void getArgment(start, getKey)
MOV X21, X0
MOV X0, X21
ADRP X1, 0x1855000
BL 0x52B800 ; isSame(wchar_t , wchar_t)
CBNZ W0, _nbtCommand
MOV X0, X21
ADRP X1, 0x1855000
ADD X1, X1, #0x14
BL 0x52B800 ; isSame(wchar_t , wchar_t)
CBNZ W0, _nickCommand
MOV X0, X21
ADRP X1, 0x1855000
ADD X1, X1, #0x2C
BL 0x52B800 ; isSame(wchar_t , wchar_t)
CBNZ W0, _endgatewayCommand
MOV X0, X21
ADRP X1, 0x1855000
ADD X1, X1, #0x44
BL 0x52B800 ; isSame(wchar_t , wchar_t)
CBNZ W0, _panoramaCommand
MOV X0, X21
ADRP X1, 0x1855000
ADD X1, X1, #0xA4
BL 0x52B800 ; isSame(wchar_t , wchar_t)
CBNZ W0, _shopCommand
MOV X0, X21
ADRP X1, 0x1855000
ADD X1, X1, #0xBC
BL 0x52B800 ; isSame(wchar_t , wchar_t)
CBNZ W0, _unsellCommand
B _THEEND
MOV X0, X26 <= _SUCCESS
MOV X1, #1
BL 0x52B780 ; void getArgment(start, getKey)
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
BL 0x6A2A10 ; wstring mcprintf(std::wstring const&):
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV W0, WZR <= _THEEND
LDP X29, X30, [SP,#0xA0]
LDP X26, X25, [SP,#0x90]
LDP X24, X23, [SP,#0x80]
LDP X22, X21, [SP,#0x70]
LDP X20, X19, [SP,#0x60]
ADD SP, SP, #0xB0
RET
BL 0x67DB90 <= _nbtCommand ; Minecraft::GetInstance
LDR X0, [X0, #0x58] ; mc::Minecraft::getInstance()->LocalPlayer
CBZ X0, _THEEND
LDR X0, [X0, #0x5B0] ; Player->Enventory
BL 0x1B1610 ; Inventory::getSelected((void))
MOV X1, X0
ADD X0, SP, #0x10
BL 0xCE60
LDR X21, [SP, #0x10] ; getSelectedIteminstance
MOV X0, X21
CBZ X0, _THEEND
BL 0x1748BC ; ItemInstance::hasTag((void))
CBNZ W0, _hasTag1
MOV X0, X21
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
MOV X0, X21
MOV X1, X22
BL 0x1777C4 ; ItemInstance::setTag(CompoundTag *)
MOV X0, X21 <= _hasTag1
BL 0x1748DC ; ItemInstance::getTag((void))
MOV X22, X0
MOV X25, #1
ADD X25, X25, #1 <= _nbtTagLoop
MOV X0, X26
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _SUCCESS
MOV X19, X0
MOV X0, X19
ADRP X1, 0x1855000
ADD X1, X1, #0x6C
BL 0x52B800 ; isSame(wchar_t , wchar_t) ; is e
CBNZ W0, _addEnch
MOV X0, X19
ADRP X1, 0x1855000
ADD X1, X1, #0x74
BL 0x52B800 ; isSame(wchar_t , wchar_t) ; is a
CBNZ W0, _addAttribute
MOV X0, X19
ADRP X1, 0x1855000
ADD X1, X1, #0x7C
BL 0x52B800 ; isSame(wchar_t , wchar_t) ; is p
CBNZ W0, _addEffect
MOV X0, X19
ADRP X1, 0x1855000
ADD X1, X1, #0x84
BL 0x52B800 ; isSame(wchar_t , wchar_t) ; is u
CBNZ W0, _addUnbreaking
MOV X0, X19
ADRP X1, 0x1855000
ADD X1, X1, #0x8C
BL 0x52B800 ; isSame(wchar_t , wchar_t) ; is s
CBNZ W0, _makeStack
MOV X0, X19
ADRP X1, 0x1855000
ADD X1, X1, #0x94
BL 0x52B800 ; isSame(wchar_t , wchar_t) ; is h
CBNZ W0, _addHideflag
MOV X0, X19
ADRP X1, 0x1855000
ADD X1, X1, #0x9C
BL 0x52B800 ; isSame(wchar_t , wchar_t) ; is d
CBNZ W0, _damage
B _THEEND
ADRP X0, #0xD78000 <= _addEnch ; "ench"
ADD X0, X0, #0xB30
ADD X1, SP, #0x10
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
ADD X1, SP, #0x10
MOV X0, X22
BL 0xE1D60 ; CompoundTag::contains(std::wstring const&) ; ench
CBNZ W0, _hasEnch
MOV X0, X22
BL 0x52107C ; List CompoundTag::AddEnchList();
MOV X0, X22 <= _hasEnch
ADD X1, SP, #0x10
MOV W2, #10
BL 0xE6764 ; CompoundTag::getList(std::wstring const&, int)
MOV X23, X0
MOV X0, X26
ADD X25, X25, #1
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x30]
MOV X0, X26
ADD X25, X25, #1
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x38]
MOV X0, X23
LDR W1, [SP, #0x30] ; ID
LDR W2, [SP, #0x38] ; lvl
BL 0x520D94 ; void ListTag::AddEnchTag(id,lvl)
ADD X0, SP, #0x10
BL 0x9C9AA8 ; std::wstring::~wstring(void)
B _nbtTagLoop
ADRP X0, #0xD89000 <= _addEffect ; "CustomPotionEffects"
ADD X0, X0, #0x8DC
ADD X1, SP, #0x10
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
ADD X1, SP, #0x10
MOV X0, X22
BL 0xE1D60 ; CompoundTag::contains(std::wstring const&) ; ench
CBNZ W0, _hasEffect
MOV X0, X22
BL 0x521004 ; List CompoundTag::AddCustomEffectList();
MOV X0, X22 <= _hasEffect
ADD X1, SP, #0x10
MOV W2, #10
BL 0xE6764 ; CompoundTag::getList(std::wstring const&, int)
MOV X23, X0
MOV X0, X26
ADD X25, X25, #1
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x30]
MOV X0, X26
ADD X25, X25, #1
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x38]
MOV X0, X26
ADD X25, X25, #1
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x40]
MOV X0, X23
LDR W1, [SP, #0x30] ; Amplifier
LDR W2, [SP, #0x38] ; ID
LDR W3, [SP, #0x40] ; Duration
BL 0x520C54 ; void ListTag::AddEffectTag(Amplifier,Id,Duration)
ADD X0, SP, #0x10
BL 0x9C9AA8 ; std::wstring::~wstring(void)
B _nbtTagLoop
ADRP X0, #0xD80000 <= _addAttribute ; "AttributeModifiers"
ADD X0, X0, #0xF10
ADD X1, SP, #0x10
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
ADD X1, SP, #0x10
MOV X0, X22
BL 0xE1D60 ; CompoundTag::contains(std::wstring const&) ; ench
CBNZ W0, _hasAttribute
MOV X0, X22
BL 0x5210F4 ; List CompoundTag::AddAttributeList();
MOV X0, X22 <= _hasAttribute
ADD X1, SP, #0x10
MOV W2, #10
BL 0xE6764 ; CompoundTag::getList(std::wstring const&, int)
MOV X23, X0
MOV X0, X26
ADD X25, X25, #1
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x30]
MOV X0, X26
ADD X25, X25, #1
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x38]
MOV X0, X26
ADD X25, X25, #1
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x40]
MOV X0, X26
ADD X25, X25, #1
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA308 ; double atof_0(const char *nptr)
STR D0, [SP, #0x48]
MOV X0, X23
LDR W1, [SP, #0x30] ; ID
LDR W2, [SP, #0x38] ; Operation
LDR W3, [SP, #0x40] ; UUID
LDR D0, [SP, #0x48] ; Amount
BL 0x520E5C ; void ListTag::AddAttributeTag(ID,Operation,UUID,Amount)
ADD X0, SP, #0x10
BL 0x9C9AA8 ; std::wstring::~wstring(void)
B _nbtTagLoop
ADRP X0, #0xD80000 <= _addUnbreaking 
ADD X0, X0, #0xCA0 ; "Unbreakable"
ADD X1, SP, #0x10
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
ADD X1, SP, #0x10
MOV X0, X22
BL 0xE1D60 ; CompoundTag::contains(std::wstring const&) ; "Unbreakable"
CBNZ W0, _hasUnbreakingTag
MOV X0, X22
ADD X1, SP, #0x10
BL 0xE6890 ; CompoundTag::remove(string)
MOV X0, X26 <= _hasUnbreakingTag
ADD X25, X25, #1
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x30]
MOV X0, X22
LDR W1, [SP, #0x30] ; ID
BL 0x520F8C ; void CompoundTag::AddUnbreakableTag(bool)
ADD X0, SP, #0x10
BL 0x9C9AA8 ; std::wstring::~wstring(void)
B _nbtTagLoop
MOV W1, #64 <= _makeStack
MOV X0, X21
BL 0x177804 ; itemInstance::setCount()
B _nbtTagLoop
MOV X0, X26 <= _addHideflag
ADD X25, X25, #1
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x30]
ADRP X0, #0xD80000 ; "Hideflag"
ADD X0, X0, #0xD54
ADD X1, SP, #0x10
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
ADD X1, SP, #0x10
MOV X0, X22
BL 0xE1D60 ; CompoundTag::contains(std::wstring const&) ; "Hideflag"
CBNZ W0, _hasHideflagTag
MOV X0, X22
ADD X1, SP, #0x10
BL 0xE6890 ; CompoundTag::remove(string)
MOV X0, X26 <= _hasHideflagTag
MOV X0, X22
ADD X1, SP, #0x10
LDR W2, [SP, #0x30]
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
B _nbtTagLoop
MOV X0, X26 <= _damage
ADD X25, X25, #1
MOV X1, X25
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [X21, #0x2C]
B _nbtTagLoop
MOV X0, X26 <= _nickCommand 
MOV X1, #2
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X23, X0
ADRP X22, #0x177c000
LDR X22, [X22, #0xe40]
LDR X22, [X22] 
ADD X0, X22, #0x124 ; Username copy #1
MOV X1, X23
MOV W2, #0x80
BL #0x9C9C38 ; memcpy
ADD X0, X22, #0x208  ; Username copy #2
MOV X1, X23
MOV W2, #0x80
BL #0x9C9C38 ; memcpy
B _THEEND
MOV X0, X26 <= _endgatewayCommand
MOV X1, #2
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x40]
MOV X0, X26 
MOV X1, #3
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x44]
MOV X0, X26 
MOV X1, #4
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x48]
MOV X0, X26 
MOV X1, #5
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x4C]
MOV X0, X26 
MOV X1, #6
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x50]
MOV X0, X26 
MOV X1, #7
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x54]
MOV X0, X26 
MOV X1, #8
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x58]
MOV X0, X26 
MOV X1, #9
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x5C]
ADD X0, SP, #0x10
LDR W1, [SP, #0x40]
LDR W2, [SP, #0x44]
LDR W3, [SP, #0x48]
BL 0x3DA88 ; BlockPos::BlockPos(int, int, int)
LDR W0, [SP, #0x5C]
CBNZ W0, _noOption
MOV W0, #209
BL 0x29D84 <= _noOption ; Block::byId(int)
BL 0x11EAC ; Block::defaultBlockState(void)
MOV X23, X0
BL 0x31D4C ; MinecraftServer::getInstance()
MOV W1, WZR
BL 0x6E301C ; MinecraftServer::getLevel(int)
MOV X22, X0
ADD X1, SP, #0x10
MOV X2, X23
MOV W3, #3
MOV W4, WZR
BL 0x72DE18 ; ServerLevel::setBlock((BlockPos const &, BlockState const *, int, bool))
MOV X0, X22
ADD X1, SP, #0x10
BL 0x201F3C ; Level::removeBlockEntity(BlockPos const&)
BL 0x5DF50 ; createEndgatewayInstance
MOV X20, X0
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X23, X0
BL 0xE5A44 ; CompoundTag(void)
MOV X0, X20
MOV X1, X23
BL 0x38AE3C ; TheEndGatewayEntity::save(CompoundTag *)
ADRP X0, #0xD98000
ADD X0, X0, #0x11C ; "Exactteleport"
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X23
MOV X1, X19
LDR W2, [SP, #0x58]
BL 0xE1370 ; CompoundTag::putBoolean(std::wstring const&, bool)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X21, X0
BL 0xE5A44 ; CompoundTag(void)
ADRP X0, #0xD85000
ADD X0, X0, #0x470 ; "X"
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X21
MOV X1, X19
LDR W2, [SP, #0x4C]
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000
ADD X0, X0, #0xE18 ; "Y"
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X21
MOV X1, X19
LDR W2, [SP, #0x50]
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD85000
ADD X0, X0, #0x478 ; "Z"
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X21
MOV X1, X19
LDR W2, [SP, #0x54]
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD98000 ; "ExitPortal"
ADD X0, X0, #0x0F0
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X23
MOV X1, X19
MOV X2, X21
BL 0xE1F4C ; CompoundTag::put(std::wstring const&, Tag *)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X20
MOV X1, X23
BL 0x38AF4C  ; TheEndGatewayEntity::load(CompoundTag *)
ADD X0, SP, #0x20
MOV X1, X20
MOV X2, XZR
BL 0x128024
MOV X0, X22
ADD X1, SP, #0x10
ADD X2, SP, #0x20
BL 0x201CE8 ; Level::setBlockEntity((BlockPos const &, boost::shared_ptr__tm__14_11BlockEntity))
ADD X0, SP, #0x20
BL 0x1280FC
B _SUCCESS
NOP <= _panoramaCommand
BL 0x67DB90 ; Minecraft::GetInstance
LDR X0, [X0, #0x58] ; mc::Minecraft::getInstance()->LocalPlayer
CBZ X0, _THEEND
LDR X0, [X0, #0x5B0] ; Player->Enventory
BL 0x1B1610 ; Inventory::getSelected((void))
MOV X1, X0
ADD X0, SP, #0x10
BL 0xCE60
LDR X21, [SP, #0x10] ; getSelectedIteminstance
MOV X0, X21
CBZ X0, _THEEND
MOV W0, #52 ; Spawner
BL 0x159088 ; Item::byId(int)
STR X0, [X21, #0x18]
MOV W0, #0x30 ; baseTag
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
MOV X0, X21
MOV X1, X22
BL 0x1777C4 ; ItemInstance::setTag(struct CompoundTag* _tag)
ADRP X0, #0xD6C000 ; "display"
ADD X0, X0, #0xEE0
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV W0, #0x30 ; displayTag
BL 0x9C9A78 ; operator new(ulong)
MOV X23, X0
BL 0xE5A44 ; CompoundTag(void)
MOV X0, X22
MOV X1, X19
MOV X2, X23
BL 0xE1F4C ; CompoundTag::put(std::wstring const&, Tag *)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD77000 ; "Name"
ADD X0, X0, #0x50
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X20, X0
MOV X0, X26 
MOV X1, #2
BL 0x52B780 ; void getArgment(start, getKey) ; getCustomname
ADRP X1, #0x1876000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X23
MOV X1, X20
MOV X2, X19
BL 0xE1EE8 ; CompoundTag::putString(std::wstring const&, std::wstring const&)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X20
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X22
BL 0x5211E4 ; Tag CompoundTag::AddBlockEntityTag();
MOV X22, X0
ADRP X0, #0xD6D000 ; "Delay"
ADD X0, X0, #0x714
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #0
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "MinSpawnDelay"
ADD X0, X0, #0x794
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #100
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "MaxSpawnDelay"
ADD X0, X0, #0x7CC
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #100
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "SpawnCount"
ADD X0, X0, #0x804
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #1
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "MaxNearbyEntities"
ADD X0, X0, #0x830
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #8
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "RequiredPlayerRange"
ADD X0, X0, #0x878
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #4
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "SpawnRange"
ADD X0, X0, #0x8C8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #0
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X24, X22
ADRP X0, #0xD6D000 ; "SpawnData"
ADD X0, X0, #0x76C
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
MOV X0, X24
MOV X1, X19
MOV X2, X22
BL 0xE1F4C ; CompoundTag::put(std::wstring const&, Tag *)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "id"
ADD X0, X0, #0x6F8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X20, X0
ADRP X0, #0xD81000 ; "minecraft:area_effect_cloud"
ADD X0, X0, #0xA2C
ADRP X1, #0x1876000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X20
MOV X2, X19
BL 0xE1EE8 ; CompoundTag::putString(std::wstring const&, std::wstring const&)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X20
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X24
ADRP X1, #0xD6D000 ; "SpawnPotentials"
ADD X1, X1, #0x72C
BL 0x52116C ; List CompoundTag::AddList(wchat_t const*);
MOV X24, X0
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
ADRP X0, #0xD93000
ADD X0, X0, #0x3DC ; "Weight"
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #1
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X23, X22
ADRP X0, #0xD93000 ; "Entity"
ADD X0, X0, #0x3F8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
MOV X0, X23
MOV X1, X19
MOV X2, X22
BL 0xE1F4C ; CompoundTag::put(std::wstring const&, Tag *)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "id"
ADD X0, X0, #0x6F8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X20, X0
ADRP X0, #0xD81000 ; "minecraft:area_effect_cloud"
ADD X0, X0, #0xA2C
ADRP X1, #0x1876000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X20
MOV X2, X19
BL 0xE1EE8 ; CompoundTag::putString(std::wstring const&, std::wstring const&)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X20
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD79000 ; "CustomName"
ADD X0, X0, #0x3F8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X20, X0
MOV X0, X26 
MOV X1, #2
BL 0x52B780 ; void getArgment(start, getKey) ; getCustomname
ADRP X1, #0x1876000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X20
MOV X2, X19
BL 0xE1EE8 ; CompoundTag::putString(std::wstring const&, std::wstring const&)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X20
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD79000 ; "CustomNameVisible"
ADD X0, X0, #0x4E4
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #1
BL 0xE1370 ; CompoundTag::putBoolean(std::wstring const&, bool)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6C000 ; "Age"
ADD X0, X0, #0x91C
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #0
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6C000 ; "Duration"
ADD X0, X0, #0x91C
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #0x7FFFFFFF
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6C000 ; "Particle"
ADD X0, X0, #0xC10
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #0
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6C000 ; "ReapplicationDelay"
ADD X0, X0, #0xB08
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #0
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6C000 ; "Waittime"
ADD X0, X0, #0xAE4
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #0
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, 0xD6C000 ; "DurationOnUse"
ADD X0, X0, #0xB54
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
FMOV S0, 0
BL 0xE626C ; CompoundTag::putFloat(std::wstring const&, Float)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, 0xD6C000 ; "Radiuspertick"
ADD X0, X0, #0xBBC
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
FMOV S0, 0
BL 0xE626C ; CompoundTag::putFloat(std::wstring const&, Float)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, 0xD6C000 ; "RadiusOnUse"
ADD X0, X0, #0xB8C
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
FMOV S0, 0
BL 0xE626C ; CompoundTag::putFloat(std::wstring const&, Float)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, 0xD6C000 ; "Radius"
ADD X0, X0, #0xBF4
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
FMOV S0, 2
BL 0xE626C ; CompoundTag::putFloat(std::wstring const&, Float)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X24
MOV X1, X23
BL 0x20BFC8 ; ListTag::add((Tag *))
B _SUCCESS
NOP <= _shopCommand
BL 0x67DB90 ; Minecraft::GetInstance
LDR X0, [X0, #0x58] ; mc::Minecraft::getInstance()->LocalPlayer
CBZ X0, _THEEND
LDR X0, [X0, #0x5B0] ; Player->Enventory
MOV X20, X0
ADD X0, X20, #8
MOV W1, #0 ; get 1st slot
BL 0xF530
MOV X1, X0
ADD X0, SP, #0x10
BL 0xCE60
LDR X21, [SP, #0x10] ; getSelectedIteminstance
MOV X0, X21
CBZ X0, _THEEND
MOV X0, X21
BL 0x1748BC ; ItemInstance::hasTag((void))
CBNZ W0, _hasTag2
MOV W0, #52 ; Spawner
BL 0x159088 ; Item::byId(int)
STR X0, [X21, #0x18]
MOV W0, #0x30 ; baseTag
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
MOV X0, X21
MOV X1, X22
BL 0x1777C4 ; ItemInstance::setTag(struct CompoundTag* _tag)
MOV X0, X22
BL 0x5211E4 ; Tag CompoundTag::AddBlockEntityTag();
MOV X22, X0
ADRP X0, #0xD6D000 ; "Delay"
ADD X0, X0, #0x714
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #0
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "MinSpawnDelay"
ADD X0, X0, #0x794
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #100
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "MaxSpawnDelay"
ADD X0, X0, #0x7CC
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #100
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "SpawnCount"
ADD X0, X0, #0x804
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #1
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "MaxNearbyEntities"
ADD X0, X0, #0x830
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #8
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "RequiredPlayerRange"
ADD X0, X0, #0x878
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #4
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "SpawnRange"
ADD X0, X0, #0x8C8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #0
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X24, X22
ADRP X0, #0xD6D000 ; "SpawnData"
ADD X0, X0, #0x76C
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
MOV X0, X24
MOV X1, X19
MOV X2, X22
BL 0xE1F4C ; CompoundTag::put(std::wstring const&, Tag *)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "id"
ADD X0, X0, #0x6F8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X20, X0
ADRP X0, #0xD82000 ; "minecraft:villager"
ADD X0, X0, #0xF74
ADRP X1, #0x1876000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X20
MOV X2, X19
BL 0xE1EE8 ; CompoundTag::putString(std::wstring const&, std::wstring const&)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X20
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X24
ADRP X1, #0xD6D000 ; "SpawnPotentials"
ADD X1, X1, #0x72C
BL 0x52116C ; List CompoundTag::AddList(wchat_t const*);
MOV X24, X0
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
ADRP X0, #0xD93000
ADD X0, X0, #0x3DC ; "Weight"
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #1
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X23, X22
ADRP X0, #0xD93000 ; "Entity"
ADD X0, X0, #0x3F8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
MOV X0, X23
MOV X1, X19
MOV X2, X22
BL 0xE1F4C ; CompoundTag::put(std::wstring const&, Tag *)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "id"
ADD X0, X0, #0x6F8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X20, X0
ADRP X0, #0xD82000 ; "minecraft:villager"
ADD X0, X0, #0xF74
ADRP X1, #0x1876000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X20
MOV X2, X19
BL 0xE1EE8 ; CompoundTag::putString(std::wstring const&, std::wstring const&)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X20
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD85000 ; "NoAI"
ADD X0, X0, #0x54C
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #1
BL 0xE1370 ; CompoundTag::putBoolean(std::wstring const&, bool)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD79000 ; "Silent"
ADD X0, X0, #0x52C
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #1
BL 0xE1370 ; CompoundTag::putBoolean(std::wstring const&, bool)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD7A000 ; "Profession"
ADD X0, X0, #0xF1C
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #0
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD98000 ; "Career"
ADD X0, X0, #0x7CC
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #0
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD98000 ; "CarrerLevel"
ADD X0, X0, #0x7E8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #4
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD79000 ; "Invulnerable"
ADD X0, X0, #0x374
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #1
BL 0xE1370 ; CompoundTag::putBoolean(std::wstring const&, bool)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD98000 ; "Offer"
ADD X0, X0, #0x838
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X25, X0
BL 0xE5A44 ; CompoundTag(void)
MOV X0, X22
MOV X1, X19
MOV X2, X25
BL 0xE1F4C ; CompoundTag::put(std::wstring const&, Tag *)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X25
ADRP X1, #0xD85000 ; "Recipes"
ADD X1, X1, #0x24
BL 0x52116C ; List CompoundTag::AddList(wchat_t const*);
MOV X0, X24
MOV X1, X23
BL 0x20BFC8 ; ListTag::add((Tag *))
NOP <= _hasTag2
MOV X0, X21
BL 0x1748DC ; ItemInstance::getTag()
MOV X20, X0
ADRP X0, #0xD74000 ; "BlockEntityTag"
ADD X0, X0, #0x5AC
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X20
MOV X1, X19
BL 0xE1D80 ; CompoundTag::getCompound("BlockEntityTag")
MOV X20, X0
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "SpawnPotentials"
ADD X0, X0, #0x72C
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X20
MOV X1, X19
MOV W2, #10
BL 0xE6764 ; CompoundTag::getList("SpawnPotentials", 10)
MOV X20, X0
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X20
MOV W1, #0
BL 0x20B954 ; ListTag::getCompound(0)
MOV X20, X0
ADRP X0, #0xD93000 ; "Entity"
ADD X0, X0, #0x3F8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X20
MOV X1, X19
BL 0xE1D80 ; CompoundTag::getCompound("Entity")
MOV X20, X0
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD98000 ; "Offers"
ADD X0, X0, #0x838
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X20
MOV X1, X19
BL 0xE1D80 ; CompoundTag::getCompound("Offer")
MOV X20, X0
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD85000 ; "Recipes"
ADD X0, X0, #0x24
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X20
MOV X1, X19
MOV W2, #10
BL 0xE6764 ; CompoundTag::getList("Recipes", 10)
MOV X20, X0
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
ADRP X0, #0xD84000 ; "MaxUses"
ADD X0, X0, #0xFDC
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #2147483647
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD84000 ; "Uses"
ADD X0, X0, #0xFC8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #0
BL 0xE4458 ; CompoundTag::putInt(std::wstring const&, int)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD84000 ; "rewardExp"
ADD X0, X0, #0xFFC
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV W2, #1
BL 0xE6140 ; CompoundTag::putByte(std::wstring const&, unsigned char)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
BL 0x67DB90 ; Minecraft::GetInstance
LDR X0, [X0, #0x58] ; mc::Minecraft::getInstance()->LocalPlayer
CBZ X0, _THEEND
LDR X25, [X0, #0x5B0] ; Player->Enventory
ADD X0, X25, #8
MOV W1, #1 ; get 2nd slot
BL 0xF530
MOV X1, X0
ADD X0, SP, #0x10
BL 0xCE60
LDR X0, [SP, #0x10] ; getSelectedIteminstance
CBZ X0, _THEEND
BL ItemInstance2CompoundTag
MOV X23, X0
ADRP X0, #0xD84000 ; "buy"
ADD X0, X0, #0xF90
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV X2, X23
BL 0xE1F4C ; CompoundTag::put(std::wstring const&, Tag *)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADD X0, X25, #8
MOV W1, #2 ; get 3rd slot
BL 0xF530
MOV X1, X0
ADD X0, SP, #0x10
BL 0xCE60
LDR X0, [SP, #0x10] ; getSelectedIteminstance
CBZ X0, _noBitem
BL ItemInstance2CompoundTag
MOV X23, X0
ADRP X0, #0xD84000 ; "buyB"
ADD X0, X0, #0xFB4
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV X2, X23
BL 0xE1F4C ; CompoundTag::put(std::wstring const&, Tag *)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
NOP <= _noBitem
ADD X0, X25, #8
MOV W1, #3 ; get 3rd slot
BL 0xF530
MOV X1, X0
ADD X0, SP, #0x10
BL 0xCE60
LDR X0, [SP, #0x10] ; getSelectedIteminstance
CBZ X0, _THEEND
BL ItemInstance2CompoundTag
MOV X23, X0
ADRP X0, #0xD84000 ; "sell"
ADD X0, X0, #0xFA0
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV X2, X23
BL 0xE1F4C ; CompoundTag::put(std::wstring const&, Tag *)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X20
MOV X1, X22
BL 0x20BFC8 ; ListTag::add((Tag *))
B _SUCCESS
SUB SP, SP, #0x160 <= ItemInstance2CompoundTag
STP X20, X19, [SP,#0x10]
STP X22, X21, [SP,#0x20]
STP X24, X23, [SP,#0x30]
STP X29, X30, [SP,#0x40]
ADD X29, SP, #0x150
MOV X21, X0
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
MOV X0, X21
BL 0x158108 ; ItemInstance::getItem(void)
MOV X1, X0
ADRP X0, #0x176F000
LDR  X0, [X0,#0xF60]
ADD X8, SP, #0x50
BL 0x1C9FD4
ADD X8, SP, #0x140
ADD X0, SP, #0x50
BL 0x718D40
ADRP X0, #0xD6D000 ; "id"
ADD X0, X0, #0x6F8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X20, X0
MOV X0, X22
MOV X1, X20
ADD X2, SP, #0x140
BL 0xE1EE8 ; CompoundTag::putString(std::wstring const&, std::wstring const&)
ADD X0, SP, #0x140
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X20
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD80000 ; "Count"
ADD X0, X0, #0xDEC
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X21
BL 0x176A18 ; ItemInstance::getCount(void)
MOV W2, W0
MOV X0, X22
MOV X1, X19
BL 0xE6140 ; CompoundTag::putByte(std::wstring const&, unsigned char)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "Damage"
ADD X0, X0, #0xECC
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
LDR W2, [X21, #0x2C]
MOV X0, X22
MOV X1, X19
BL 0xE61A4 ; CompoundTag::putShort(std::wstring const&, short)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X21
BL 0x1748BC ; ItemInstance::hasTag((void))
CBZ W0, _hasNotTag3
MOV X0, X21
BL 0x1748DC ; Iteminstance::getTag
MOV X23, X0
ADRP X0, #0xD80000 ; "tag"
ADD X0, X0, #0xB18
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV X2, X23
BL 0xE1F4C ; CompoundTag::put(std::wstring const&, Tag *)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X22 <= _hasNotTag3
LDP X29, X30, [SP,#0x40]
LDP X24, X23, [SP,#0x30]
LDP X22, X21, [SP,#0x20]
LDP X20, X19, [SP,#0x10]
ADD SP, SP, #0x160
RET
NOP <= _unsellCommand
BL 0x67DB90 ; Minecraft::GetInstance
LDR X0, [X0, #0x58] ; mc::Minecraft::getInstance()->LocalPlayer
CBZ X0, _THEEND
LDR X0, [X0, #0x5B0] ; Player->Enventory
MOV X20, X0
ADD X0, X20, #8
MOV W1, #0 ; get 1st slot
BL 0xF530
MOV X1, X0
ADD X0, SP, #0x10
BL 0xCE60
LDR X21, [SP, #0x10] ; getSelectedIteminstance
CBZ X21, _THEEND
MOV X0, X21
BL 0x1748BC ; ItemInstance::hasTag((void))
CBZ W0, _THEEND
MOV X0, X21
BL 0x1748DC ; ItemInstance::getTag()
MOV X20, X0
ADRP X0, #0xD74000 ; "BlockEntityTag"
ADD X0, X0, #0x5AC
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X20
MOV X1, X19
BL 0xE1D80 ; CompoundTag::getCompound("BlockEntityTag")
CBZ X0, _THEEND
MOV X20, X0
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD6D000 ; "SpawnPotentials"
ADD X0, X0, #0x72C
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X20
MOV X1, X19
MOV W2, #10
BL 0xE6764 ; CompoundTag::getList("SpawnPotentials", 10)
CBZ X0, _THEEND
MOV X20, X0
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
MOV X0, X20
MOV W1, #0
BL 0x20B954 ; ListTag::getCompound(0)
CBZ X0, _THEEND
MOV X20, X0
ADRP X0, #0xD93000 ; "Entity"
ADD X0, X0, #0x3F8
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X20
MOV X1, X19
BL 0xE1D80 ; CompoundTag::getCompound("Entity")
CBZ X0, _THEEND
MOV X20, X0
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD98000 ; "Offers"
ADD X0, X0, #0x838
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X20
MOV X1, X19
BL 0xE1D80 ; CompoundTag::getCompound("Offer")
CBZ X0, _THEEND
MOV X20, X0
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X0, #0xD85000 ; "Recipes"
ADD X0, X0, #0x24
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X20
MOV X1, X19
MOV W2, #10
BL 0xE6764 ; CompoundTag::getList("Recipes", 10)
CBZ X0, _THEEND
MOV X20, X0
MOV X0, X26
MOV X1, #2
BL 0x52B780 ; void getArgment(start, getKey)
CBZ X0, _THEEND
MOV X1, X0
ADRP X0, 0x1856000
MOV W2, #0x10
BL 0x9C9F88 ; int wcstombs_0(const wchar_t *s1, const wchar_t *s2, size_t n)
ADRP X0, 0x1856000
BL 0x9CA288 ; int atoi_0(const char *nptr)
STR W0, [SP, #0x30]
CMP W0, #0
B.LT _THEEND
MOV X0, X20
BL 0x20B944 ; listtag::size
LDR W1, [SP, #0x30]
CMP W1, W0
B.GE _THEEND
MOV X0, X20
LDR W1, [SP, #0x30]
BL 0x216820 ; ListTag::Remove(int)
B _SUCCESS
