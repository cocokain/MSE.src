LDR X21,[X21,#0x38] ; Black Shulker Box
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
ADRP X21, #0x17BE000
ADD X21, X21, #0x6C8
LDR X21,[X21]
