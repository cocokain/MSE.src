0x524554

RET
SUB SP, SP, #0x70
STP X26, X25, [SP,#0x20]
STP X24, X23, [SP,#0x30]
STP X20, X19, [SP,#0x40]
STP X22, X21, [SP,#0x50]
STP X29, X30, [SP,#0x60]
ADD X29, SP, #0x60 
ADRP X21,#0x17BE000 ; spg
ADD X21,X21,#0x6C8
LDR X21,[X21]
LDR X21,[X21] ; get connpass
LDR X20,[X21,#0x28] ; get connpass tag
CBNZ X20, _END
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
ADD X20, X21, #8
MOV X0, X20
MOV X1, X22
BL 0x1777C4 ; ItemInstance::setTag(struct CompoundTag* _tag)
LDR X0, [X21,#0x28]
BL 0x521004 ; List CompoundTag::AddCustomEffectList();
MOV X22, X0
MOV X0, X22
MOV W1, #0x1 ; Amplifier
MOV W2, #0x1 ; Id
MOV W3, #0x7FFFFFFF ; Duration
BL 0x520C54 ; void ListTag::AddEffectTag(Amplifier,Id,Duration)
MOV X0, X22
MOV W1, #0x1 ; Amplifier
MOV W2, #0x5 ; Id
MOV W3, #0x7FFFFFFF ; Duration
BL 0x520C54 ; void ListTag::AddEffectTag(Amplifier,Id,Duration)
MOV X0, X22
MOV W1, #0x9 ; Amplifier
MOV W2, #0x10 ; Id
MOV W3, #0x7FFFFFFF ; Duration
BL 0x520C54 ; void ListTag::AddEffectTag(Amplifier,Id,Duration)
LDR X0, [X21,#0x28]
BL 0x52107C ; List CompoundTag::AddEnchList();
MOV X22, X0
MOV X0, X22
MOV W1, #0x47 ; ID
MOV W2, #0xA ; lvl
BL 0x520D94 ; void ListTag::AddEnchTag(id,lvl)
ADRP X19,#0x178B000
ADD X19,X19,#0x790
LDR X19,[X19]
LDR X19,[X19,#2984] ; itemid * 8 
STR X19,[X21,#0x20]
ADRP X21,#0x17BE000 ; 即死ポ
ADD X21,X21,#0x6C8
LDR X21,[X21]
LDR X21,[X21,#8] ; get leather head
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
ADD X20, X21, #8
MOV X0, X20
MOV X1, X22
BL 0x1777C4 ; ItemInstance::setTag(struct CompoundTag* _tag)
LDR X0, [X21,#0x28]
BL 0x521004 ; List CompoundTag::AddCustomEffectList();
MOV X22, X0
MOV X0, X22
MOV W1, #0x1D ; Amplifier
MOV W2, #0x6 ; Id
MOV W3, #0x0 ; Duration
BL 0x520C54 ; void ListTag::AddEffectTag(Amplifier,Id,Duration)
LDR X0, [X21,#0x28]
BL 0x52107C ; List CompoundTag::AddEnchList();
MOV X22, X0
MOV X0, X22
MOV W1, #0x47 ; ID
MOV W2, #0xA ; lvl
BL 0x520D94 ; void ListTag::AddEnchTag(id,lvl)
ADRP X19,#0x178B000
ADD X19,X19,#0x790
LDR X19,[X19]
LDR X19,[X19,#2984] ; itemid * 8 
STR X19,[X21,#0x20]

ADRP X21,#0x17BE000 ; 即死ポスプラッシュ
ADD X21,X21,#0x6C8
LDR X21, [X21]  ; get food menu
LDR X21, [X21, #0x10]
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
ADD X20, X21, #8
MOV X0, X20
MOV X1, X22
BL 0x1777C4 ; ItemInstance::setTag(struct CompoundTag* _tag)
LDR X0, [X21,#0x28]
BL 0x521004 ; List CompoundTag::AddCustomEffectList();
MOV X22, X0
MOV X0, X22
MOV W1, #0x1D ; Amplifier
MOV W2, #0x6 ; Id
MOV W3, #0x0 ; Duration
BL 0x520C54 ; void ListTag::AddEffectTag(Amplifier,Id,Duration)
LDR X0, [X21,#0x28]
ADRP X19,#0x178B000
ADD X19,X19,#0x790
LDR X19,[X19]
LDR X19,[X19,#3504] ; itemid * 8 
STR X19,[X21,#0x20]
ADRP X21,#0x17BE000 ; 即死ポスプラッシュ
ADD X21,X21,#0x6C8
LDR X21, [X21]  ; get food menu
LDR X21, [X21, #0x18]
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
ADD X20, X21, #8
MOV X0, X20
MOV X1, X22
BL 0x1777C4 ; ItemInstance::setTag(struct CompoundTag* _tag)
LDR X0, [X21,#0x28]
BL 0x521004 ; List CompoundTag::AddCustomEffectList();
MOV X22, X0
MOV X0, X22
MOV W1, #0x1D ; Amplifier
MOV W2, #0x6 ; Id
MOV W3, #0x0 ; Duration
BL 0x520C54 ; void ListTag::AddEffectTag(Amplifier,Id,Duration)
LDR X0, [X21,#0x28]
ADRP X19,#0x178B000
ADD X19,X19,#0x790
LDR X19,[X19]
LDR X19,[X19,#3528] ; itemid * 8 
STR X19,[X21,#0x20]
ADRP X21,#0x17BE000 ; ダイヤ剣
ADD X21,X21,#0x6C8
LDR X21, [X21]  ; get food menu
LDR X21, [X21, #0x20]
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X26, X0
BL 0xE5A44 ; CompoundTag(void)
MOV X0, X26
MOV W1, #1
BL 0x520F8C ; void CompoundTag::AddUnbreakableTag(bool)
MOV X0, X26
BL 0x52107C ; List CompoundTag::AddEnchList();
MOV X22, X0
MOV X0, X22
MOV W1, #16 ; ID鋭さ
MOV W2, #0x7FFF ; lvl
BL 0x520D94 ; void ListTag::AddEnchTag(id,lvl)
ADD X20, X21, #8
MOV X0, X20
MOV X1, X26
BL 0x1777C4 ; ItemInstance::setTag(struct CompoundTag* _tag)
ADRP X19,#0x178B000
ADD X19,X19,#0x790
LDR X19,[X19]
LDR X19,[X19, #2208] ; itemid * 8 
STR X19,[X21,#0x20]

ADRP X21,#0x17BE000 ; 鍵シュルカー
ADD X21,X21,#0x6C8
LDR X21, [X21]  ; get weapon menu
LDR X21, [X21, #0x58]
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
ADD X20, X21, #8
MOV X0, X20
MOV X1, X22
BL 0x1777C4 ; ItemInstance::setTag(struct CompoundTag* _tag)
LDR X0, [X21,#0x28]
BL 0x5211E4 ; Tag CompoundTag::AddBlockEntityTag();
MOV X22, X0
ADRP X0, #0xD84000 ; "Lock"
ADD X0, X0, #0x898
ADRP X1, #0x1875000
BL 0x521340 ; wstring Wchar2Wstring(wchat_t const*, temp)
MOV X19, X0
MOV X0, X22
MOV X1, X19
MOV X2, X19
BL 0xE1EE8 ; CompoundTag::putString(std::wstring const&, std::wstring const&)
MOV X0, X19
BL 0x9C9AA8 ; std::wstring::~wstring(void)
ADRP X19,#0x178B000
ADD X19,X19,#0x790
LDR X19,[X19]
LDR X19,[X19,#0x6d8] ; itemid * 8 
STR X19,[X21,#0x20]
ADRP X21,#0x17BE000 ; バリブロ
ADD X21,X21,#0x6C8
LDR X21, [X21]  ; get food menu
LDR X21, [X21, #0x60]
ADRP X19,#0x178B000
ADD X19,X19,#0x790
LDR X19,[X19]
LDR X19,[X19,#1328] ; itemid * 8 
STR X19,[X21,#0x20]
ADRP X21,#0x17BE000 ; 偽バリブロ
ADD X21,X21,#0x6C8
LDR X21, [X21] 
LDR X21, [X21, #0x68]
ADRP X19,#0x178B000
ADD X19,X19,#0x790
LDR X19,[X19]
LDR X19,[X19,#18040] ; itemid * 8 
STR X19,[X21,#0x20]
ADRP X21,#0x17BE000 ; スピードブーツ
ADD X21,X21,#0x6C8
LDR X21, [X21]  ; get food menu
LDR X21, [X21, #0x70]
MOV W0, #0x30
BL 0x9C9A78 ; operator new(ulong)
MOV X22, X0
BL 0xE5A44 ; CompoundTag(void)
ADD X20, X21, #8
MOV X0, X20
MOV X1, X22
BL 0x1777C4 ; ItemInstance::setTag(struct CompoundTag* _tag)
LDR X0, [X21,#0x28]
BL 0x5210F4 ; List CompoundTag::AddAttributeList();
MOV W1, #0x3 ; ID
MOV W2, #0x2 ; Operation
MOV W3, #0x4 ; UUID
FMOV D0, 2.5
BL 0x520E5C ; void ListTag::AddAttributeTag(ID,Operation,UUID,Amount)
ADRP X19,#0x178B000
ADD X19,X19,#0x790
LDR X19,[X19]
LDR X19,[X19,#2384] ; itemid * 8 
STR X19,[X21,#0x20]
LDP X29, X30, [SP,#0x60] <= _END
LDP X22, X21, [SP,#0x50]
LDP X20, X19, [SP,#0x40]
LDP X24, X23, [SP,#0x30]
LDP X26, X25, [SP,#0x20]
ADD SP, SP, #0x70
RET
