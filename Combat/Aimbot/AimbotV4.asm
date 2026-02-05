0x1872000 : TargetEntity

0x52A6A0:
SUB SP, SP, #0x40
STP X21, X20, [SP,#0x20]
STP X29, X30, [SP,#0x30]
ADD X29, SP, #0x30
ADRP X20,0x1872000
LDR X2, [X20]
CBNZ X2, _SkipGetTarget
ADRP X21, #0x17C4000
ADD X21, X21, #0xC28
LDR X21,[X21]
LDR X21,[X21,#0xF8]
LDR X21,[X21,#0x28]
LDR X21,[X21,#0x10]
LDR X2,[X21,#0x60]
STR X2,[X20]
CBZ X2, _END
MOV X21, X2 <= _SkipGetTarget
MOV X0, X21
BL 0x157804 ; Entity::isAlive(void)
CBNZ W0, _isAlive
ADRP X20,0x1872000 <= _Reset
STR XZR, [X20]
B _END
MOV X0, X21 <= _isAlive
BL 0x122788 ; LivingEntity::getHealth(void)
FCMP S0, 0.0
B.EQ _Reset
BL 0x67db90 ; Minecraft::GetInstance
LDR X1, [X0,#0x58] ; mc::Minecraft::getInstance()->LocalPlayer;
MOV X20, X1 ; X1 = lPlayer
LDR D8,[X20,#0x78]
LDR D9,[X21,#0x78]
FSUB D1,D9,D8 ; D1 = diffX
LDR D9,[X20,#0x88]
LDR D10,[X21,#0x88]
FSUB D0, D10, D9 ; D0 = diffZ
STP D1, D0, [SP, #0x10]
BL 0x52A880 ; hypot
FMOV D10, 7.5
FCMP D0, D10
B.GT _Reset
LDP D1, D0, [SP, #0x10]
BL 0x9C9C48 ; double atan2_0(double)
MOV W8, #180
SCVTF D1, W8
FMUL D0, D0, D1
ADRP X8,#0xD6A000
ADD X8,X8,#0x808
LDR D1,[X8] ; get Double PI
FDIV D0,D0,D1
MOV W8,#90
SCVTF D1,W8
FSUB D0,D0,D1
MOV W8,#360
SCVTF D1,W8 ; D1 = 360
FSUB D2, D0, D1 ; D2 = yaw - 360
FCMP D0, 0.0
B.LT _YawSkip1
FADD D0,D0,D1
FCMP D2,0.0 <= _YawSkip1
B.GT _YawSkip2
FSUB D0,D0,D1
FCVT S0,D0 <= _YawSkip2
STR S0,[X20,#0xA8]
MOV X0,X20
Bl 0x2D16E8 ; LocalPlayer::getEyeHeight(void)
FCVT D7,S0 ; D7 = lPlayer->eyeHeight
LDP D1, D0, [SP, #0x10]
BL 0x52A880 ; hypot
FMOV D10, D0 ; D10 = dist
LDR D0,[X20,#0x80] ; D0 = lPlayer->y
FADD D0,D0,D7 ; D0 = lPlayer->y + eyeHeight
LDR D1,[X21,#0x80] ; D1 = target->y
FCMP D1,D0 ; target->y < lPlayer->y + eyeHeight の場合にスキップ
B.LT _PitchSkip1
FSUB D0,D1,D0
B _PitchSkip2
FMOV D2,#1.875 <= _PitchSkip1
FADD D1,D1,D2
FCMP D1,D0 ; target->y + 1.875 > lPlayer->y + eyeHeight の場合にスキップ
B.GT _PitchSkip3
LDR D0,[X20,#0x80] ; D0 = lPlayer->y
LDR D1,[X21,#0x80] ; D1 = target->y
FSUB D0, D1, D0
B _PitchSkip2
FMOV D0, 0.0 <= _PitchSkip3
FMOV D1, D10 <= _PitchSkip2
BL 0x9C9C48 ; double atan2_0(double)
MOV W8,#180
SCVTF D1,W8
FMUL D0,D0,D1
ADRP X8,#0xD6A000
ADD X8,X8,#0x808
LDR D1,[X8] ; gee Double PI
FDIV D0,D0,D1
FMOV D1,-1.0
FMUL D0,D0,D1
FCVT S0,D0
STR S0,[X20,#0xAC]
LDP X29, X30, [SP,#0x30] <= _END
LDP X21, X20, [SP,#0x20]
ADD SP, SP, #0x40
RET

[Release Target]
08000000 01872000 00000000 00000000
