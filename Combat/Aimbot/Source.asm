
[Release Target]
08000000 01872000 00000000 00000000

———————————————————————————



static float calculatePitch(mc::Player* lPlayer, mc::Player* target) {
                float pitch = 0.0;
                double diffX = target->x - lPlayer->x;
                double diffZ = target->z - lPlayer->z;
                float dist =  sqrt((float) pow(diffX, 2) + (float) pow( diffZ, 2));
                if ((float) target->y > (float) lPlayer->y + lPlayer->getEyeHeight()){

                    float pitch = atan2f( target->y - Player->y - (double) lPlayer->getEyeHeight() , dist);

                }else if(0 > target->y + 1.875 - lPlayer->y - (double) lPlayer->getEyeHeight() ){

                    float pitch = atan2f(target->y + 1.875 - lPlayer->y - (double) lPlayer->getEyeHeight() , dist);

                }
                pitch = pitch * (180.0 / M_PI) * -1;

                return pitch;
                ———————————————————————————
           calculatePitch{
MOV X20,X1 ; X1 = lPlayer
MOV X21,X2 ; X2 = target

LDR D8,[X20,#0x78]
LDR D9,[X21,#0x78]
FSUB D8,D9,D8 ; D8 = diffX
LDR D9,[X20,#0x88]
LDR D10,[X21,#0x88]
FSUB D9,D10,D9 ; D9 = diffZ
FMOV D1,2
FMOV D0,D8
BL 0x9C9CD8 ; double pow(double , double);
FMOV D8,D0
FMOV D0,D9
BL 0x9C9CD8 ; double pow(double , double);
FADD D0,D0,D8
BL 0x9C9B88 ; double sqrt(double);
FMOV D10,D0 ; D10 = dist


LDR D0,[X21,#0x80] ; D0 = target->y
LDR D1,[X20,#0x80] ; D1 = lPlayer->y
FSUB D0,D0,D1
MOV X0,X20
Bl 0x2D16E8 ; LocalPlayer::getEyeHeight(void)
FCVT D9,S0 ; D9 = lPlayer->eyeHeight
FSUB D0,D0,D9

FCMP D0,#0.0
B.GT #0x ; +8
FMOV D1,D10
BL 0x9C9C48 ; double atan2_0(double)
B #0x ; +1A

LDR D0,[X20,#0x80] ; D0 = lPlayer->y
FADD D0,D0,D9 ; lPlayer->y + eyeHeight
LDR D1,[X21,#0x80] ; D1 = target->y
FSUB D0,D0,D1
FMOV D1,#1.875
FSUB D0,D0,D1

FCMP D0,#0.0
B.GT #0x ; +8
FMOV D1,D10
BL 0x9C9C48 ; double atan2_0(double)
B #0x ; +4

FMOV D0,#0.0

MOV W8,#-180
SCVTF D1,W8
FMUL D0,D0,D1
MOV W8,#355
SCVTF D1,W8
MOV W8,#113
SCVTF D2,W8
FDIV D1,D1,D2
FDIV D0,D0,D1
FCVT S0,D0
STR S0,[X20,#0xAC]

calculateYaw{
MOV X20,X1 ; X1 = lPlayer
MOV X21,X2 ; X2 = target

LDR D8,[X20,#0x78]
LDR D9,[X21,#0x78]
FSUB D8,D9,D8 ; D8 = diffX
LDR D9,[X20,#0x88]
LDR D10,[X21,#0x88]
FSUB D9,D10,D9 ; D9 = diffZ
FCVT S0,D9
FCVT S1,D8
BL 0x9CA0E8 ; float atan2f_0(float y, float x)
MOV W8,#180
SCVTF S1,W8
FMUL S0,S0,S1
MOV W8,#355
SCVTF S1,W8
MOV W8,#113
SCVTF S2,W8
FDIV S1,S1,S2
FDIV S0,S0,S1
MOV W8,#90
SCVTF S1,W8
FSUB S0,S0,S1
MOV W8,#360
SCVTF S1,W8 ; s1 = 360
FSUB S2,S0,S1 ; S2 = yaw - 360

FCMP S0,0
B.LT #0x ; +4
FADD S0,S0,S1

FCMP S2,0
B.GT #0x ; +4
FSUB S0,S0,S1

STR S0,[X20,#0xA8]

MOV X1,X20
MOV X2,X21

setAim(X1 = lPlayer , X2 = target){
MOV X20,X1 ; X1 = lPlayer
MOV X21,X2 ; X2 = target

LDR D8,[X20,#0x78]
LDR D9,[X21,#0x78]
FSUB D1,D9,D8 ; D1 = diffX
LDR D9,[X20,#0x88]
LDR D10,[X21,#0x88]
FSUB D0,D10,D9 ; D0 = diffZ
BL 0x9C9C48 ; double atan2_0(double)
MOV W8,#180
SCVTF D1,W8
FMUL D0,D0,D1
MOV W8,#355
SCVTF D1,W8
MOV W8,#113
SCVTF D2,W8
FDIV D1,D1,D2
FDIV D0,D0,D1
MOV W8,#90
SCVTF D1,W8
FSUB D0,D0,D1
MOV W8,#360
SCVTF D1,W8 ; s1 = 360
FSUB D2,D0,D1 ; D2 = yaw - 360

FCMP D0,0
B.LT #0x ; +4
FADD D0,D0,D1

FCMP D2,0
B.GT #0x ; +4
FSUB D0,D0,S1

FCVT S0,D0
STR S0,[X20,#0xA8]
LDR D8,[X20,#0x78]
LDR D9,[X21,#0x78]
FSUB D8,D9,D8 ; D8 = diffX
LDR D9,[X20,#0x88]
LDR D10,[X21,#0x88]
FSUB D9,D10,D9 ; D9 = diffZ
FMOV D1,2
FMOV D0,D8
BL 0x9C9CD8 ; double pow(double , double);
FMOV D8,D0
FMOV D0,D9
BL 0x9C9CD8 ; double pow(double , double);
FADD D0,D0,D8
BL 0x9C9B88 ; double sqrt(double);
FMOV D10,D0 ; D10 = dist


LDR D0,[X21,#0x80] ; D0 = target->y
LDR D1,[X20,#0x80] ; D1 = lPlayer->y
FSUB D0,D0,D1
MOV X0,X20
Bl 0x2D16E8 ; LocalPlayer::getEyeHeight(void)
FCVT D9,S0 ; D9 = lPlayer->eyeHeight
FSUB D0,D0,D9

FCMP D0,#0.0
B.GT #0x ; +8
FMOV D1,D10
BL 0x9C9C48 ; double atan2_0(double)
B #0x ; +1A

LDR D0,[X20,#0x80] ; D0 = lPlayer->y
FADD D0,D0,D9 ; lPlayer->y + eyeHeight
LDR D1,[X21,#0x80] ; D1 = target->y
FSUB D0,D0,D1
FMOV D1,#1.875
FSUB D0,D0,D1

FCMP D0,#0.0
B.GT #0x ; +8
FMOV D1,D10
BL 0x9C9C48 ; double atan2_0(double)
B #0x ; +4

FMOV D0,#0.0

MOV W8,#-180
SCVTF D1,W8
FMUL D0,D0,D1
MOV W8,#355
SCVTF D1,W8
MOV W8,#113
SCVTF D2,W8
FDIV D1,D1,D2
FDIV D0,D0,D1
FCVT S0,D0
STR S0,[X20,#0xAC]
}

直近に殴った相手取得
ADRP X19,#0x1045000
ADD X19,X19,#0x5C0
LDR X0,[X19]

LDR D0,[X21,#0x80] ; D0 = target->y
LDR D1,[X20,#0x80] ; D1 = lPlayer->y
FSUB D0,D0,D1
MOV X0,X20
Bl 0x2D16E8 ; LocalPlayer::getEyeHeight(void)
FCVT D9,S0 ; D9 = lPlayer->eyeHeight
FSUB D0,D0,D9

FCMP D0,#0.0
B.GT #0x ; +8
FMOV D1,D10
BL 0x9C9C48 ; double atan2_0(double)
B #0x ; +1A

LDR D0,[X20,#0x80] ; D0 = lPlayer->y
FADD D0,D0,D9 ; lPlayer->y + eyeHeight
LDR D1,[X21,#0x80] ; D1 = target->y
FSUB D0,D0,D1
FMOV D1,#1.875
FSUB D0,D0,D1

FCMP D0,#0.0
B.GT #0x ; +8
FMOV D1,D10
BL 0x9C9C48 ; double atan2_0(double)
B #0x ; +4

FMOV D0,#0.0

MOV W8,#-180
SCVTF D1,W8
FMUL D0,D0,D1
MOV W8,#355
SCVTF D1,W8
MOV W8,#113
SCVTF D2,W8
FDIV D1,D1,D2
FDIV D0,D0,D1
FCVT S0,D0
STR S0,[X20,#0xAC]

LDR D8,[X20,#0x78]
LDR D9,[X21,#0x78]
FSUB D8,D9,D8 ; D8 = diffX
LDR D9,[X20,#0x88]
LDR D10,[X21,#0x88]
FSUB D9,D10,D9 ; D9 = diffZ
FMOV D1,2
FMOV D0,D8
BL 0x9C9CD8 ; double pow(double , double);
FMOV D8,D0
FMOV D0,D9
BL 0x9C9CD8 ; double pow(double , double);
FADD D0,D0,D8
BL 0x9C9B88 ; double sqrt(double);
FMOV D10,D0 ; D10 = dist
LDR D0,[X21,#0x80] ; D0 = target->y
FMOV D1,#1.875
FADD D0,D0,D1
LDR D1,[X20,#0x80] ; D1 = lPlayer->y
FSUB D0,D0,D1
MOV X0,X20
Bl 0x2D16E8 ; LocalPlayer::getEyeHeight(void)
FCVT D9,S0 ; D9 = lPlayer->eyeHeight
FSUB D0,D0,D9
FCMP D0,#0.0
B.GT #0x9CBD44; +8
FMOV D1,D10
BL 0x9C9C48 ; double atan2_0(double)
B #0x9CBD6C; +B
LDR D0,[X21,#0x80] ; D0 = target->y
LDR D1,[X20,#0x80] ; D1 = lPlayer->y
FSUB D0,D0,D1
FSUB D0,D0,D9
FCMP D0,#0.0
B.LT #0x9CBD68; +8
FMOV D1,D10
BL 0x9C9C48 ; double atan2_0(double)
B #0x9CBD6C; +2
FMOV D0,#0.0
MOV W8,#-180 ; 集合地点

double targetEyeHeight = selectedPlayer->y + selectedPlayer->getEyeHeight();
                    double diffX = selectedPlayer->x - lPlayer->x;
                    double diffY = targetEyeHeight   - (lPlayer->y + lPlayer->getEyeHeight());
                    double diffZ = selectedPlayer->z - lPlayer->z;

                    double dist = sqrt(pow(diffX, 2) + pow(diffZ, 2));
                    float pitch = WorldEdit::radianToDegree((float) -(atan2(diffY, dist)));

                    lPlayer->yaw   = calculateYaw(lPlayer, selectedPlayer);
                    lPlayer->pitch = pitch;
