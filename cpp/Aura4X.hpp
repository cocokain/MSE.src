#include "mc/client/Minecraft.hpp"
#include "Basic/Basic.hpp"
#include "Basic/KAPI.hpp"

using namespace mc;
using namespace mc_boost;

#define kaura4XtargetUidList ((int*)0x10CB5000)

struct Kaura4XButtonState{
    bool nextPlayer                     = false;
    bool previousPlayer                 = false;
    bool atkSpeedUp                     = false;
    bool atkSpeedDown                   = false;
    bool multiAtkUp                     = false;
    bool multiAtkDown                   = false;
    bool hitRateUp                      = false;
    bool hitRateDown                    = false;
    bool infiniteAura                   = false;
    bool singleAura                     = false;
    bool targetAura                     = false;
    int infiniteAuraButtonCount         = 0;
    int singleAuraButtonCount           = 0;
    int targetAuraButtonCount           = 0;
    int infiniteAuraButtonTimeOutCount  = 0;
    int singleAuraButtonTimeOutCount    = 0;
    int targetAuraButtonTimeOutCount    = 0;
    bool fullAtk                        = false;
    bool singleAtk                      = false;
    bool targetAtk                      = false;
    bool targetUidList                  = false;
    bool seeSelectMode                  = false;
};

namespace Kaura4XMessageIndex{
    FORCE_INLINE void selectPlayer(void* instance){//[Kaura4X] Target "
        KAPI_OLD::message(instance, L'[');
        KAPI_OLD::message(instance, L'K');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L'u');
        KAPI_OLD::message(instance, L'r');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L']');
        KAPI_OLD::message(instance, L' ');
        KAPI_OLD::message(instance, L'T');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L'r');
        KAPI_OLD::message(instance, L'g');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L' ');
        KAPI_OLD::message(instance, L'\"');
    }
    FORCE_INLINE void selectPlayerEnd(void* instance){//"
        KAPI_OLD::message(instance, L'\"');
        KAPI_OLD::addMessage_EndLine(instance);
    }
    FORCE_INLINE void kaura(void* instance){// [ Kaura4X:v4.0β ] 
        KAPI_OLD::message(instance, L' ');
        KAPI_OLD::message(instance, L'[');
        KAPI_OLD::message(instance, L' ');
        KAPI_OLD::message(instance, L'K');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L'u');
        KAPI_OLD::message(instance, L'r');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L':');
        KAPI_OLD::message(instance, L'v');
        KAPI_OLD::message(instance, L'4');
        KAPI_OLD::message(instance, L'.');
        KAPI_OLD::message(instance, L'0');
        KAPI_OLD::message(instance, L' ');
        KAPI_OLD::message(instance, L']');
        KAPI_OLD::message(instance, L' ');
    }
    FORCE_INLINE void kauraStaus(void* instance){//¦
        KAPI_OLD::message(instance, L'¦');
        KAPI_OLD::message(instance, L' ');
    }
    FORCE_INLINE void kauraStausEnd(void* instance){//¦
        KAPI_OLD::message(instance, L'¦');
        KAPI_OLD::message(instance, L' ');
    }
    FORCE_INLINE void selectedPlayer(void* instance){
        KAPI_OLD::message(instance, L'T');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L'r');
        KAPI_OLD::message(instance, L'g');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L'\"');
    }
    FORCE_INLINE void selectedPlayerEnd(void* instance){
        KAPI_OLD::message(instance, L'\"');
        KAPI_OLD::message(instance, L' ');
    }
    FORCE_INLINE void noTarget(void* instance){//[None]
        KAPI_OLD::message(instance, L'[');
        KAPI_OLD::message(instance, L'N');
        KAPI_OLD::message(instance, L'o');
        KAPI_OLD::message(instance, L'n');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L']');
    }
    FORCE_INLINE void max(void* instance){
        KAPI_OLD::message(instance, L'M');
        KAPI_OLD::message(instance, L'A');
        KAPI_OLD::message(instance, L'X');
    }
    FORCE_INLINE void atkSpeed(void* instance){
        KAPI_OLD::message(instance, L'A');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L'k');
        KAPI_OLD::message(instance, L'S');
        KAPI_OLD::message(instance, L'p');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L'd');
        KAPI_OLD::message(instance, L'[');
    }
    FORCE_INLINE void multiAtk(void* instance){
        KAPI_OLD::message(instance, L'M');
        KAPI_OLD::message(instance, L'u');
        KAPI_OLD::message(instance, L'l');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L'i');
        KAPI_OLD::message(instance, L'A');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L'k');
        KAPI_OLD::message(instance, L'[');
    }
    FORCE_INLINE void hitRate(void* instance){
        KAPI_OLD::message(instance, L'H');
        KAPI_OLD::message(instance, L'i');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L'R');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L'[');
    }
    FORCE_INLINE void end(void* instance){
        KAPI_OLD::message(instance, L']');
        KAPI_OLD::message(instance, L' ');
    }
    FORCE_INLINE void infiniteAura(void* instance){
        KAPI_OLD::message(instance, L'I');
        KAPI_OLD::message(instance, L'n');
        KAPI_OLD::message(instance, L'f');
        KAPI_OLD::message(instance, L'i');
        KAPI_OLD::message(instance, L'n');
        KAPI_OLD::message(instance, L'i');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L'A');
        KAPI_OLD::message(instance, L'u');
        KAPI_OLD::message(instance, L'r');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L' ');
    }
    FORCE_INLINE void singleAura(void* instance){
        KAPI_OLD::message(instance, L'S');
        KAPI_OLD::message(instance, L'i');
        KAPI_OLD::message(instance, L'n');
        KAPI_OLD::message(instance, L'g');
        KAPI_OLD::message(instance, L'l');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L'A');
        KAPI_OLD::message(instance, L'u');
        KAPI_OLD::message(instance, L'r');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L' ');
    }
    FORCE_INLINE void targetAura(void* instance){
        KAPI_OLD::message(instance, L'T');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L'r');
        KAPI_OLD::message(instance, L'g');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L'A');
        KAPI_OLD::message(instance, L'u');
        KAPI_OLD::message(instance, L'r');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L' ');
    }
    FORCE_INLINE void addTargetList(void* instance){
        KAPI_OLD::message(instance, L'[');
        KAPI_OLD::message(instance, L'K');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L'u');
        KAPI_OLD::message(instance, L'r');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L']');
        KAPI_OLD::message(instance, L' ');
        KAPI_OLD::message(instance, L'T');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L'r');
        KAPI_OLD::message(instance, L'g');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L'L');
        KAPI_OLD::message(instance, L'i');
        KAPI_OLD::message(instance, L's');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L' ');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L'd');
        KAPI_OLD::message(instance, L'd');
        KAPI_OLD::message(instance, L' ');
        KAPI_OLD::message(instance, L'\"');
    }
    FORCE_INLINE void addTargetListEnd(void* instance){
        KAPI_OLD::message(instance, L'\"');
        KAPI_OLD::addMessage_EndLine(instance);
    }
    FORCE_INLINE void deleteTargetList(void* instance){
        KAPI_OLD::message(instance, L'[');
        KAPI_OLD::message(instance, L'K');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L'u');
        KAPI_OLD::message(instance, L'r');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L']');
        KAPI_OLD::message(instance, L' ');
        KAPI_OLD::message(instance, L'T');
        KAPI_OLD::message(instance, L'a');
        KAPI_OLD::message(instance, L'r');
        KAPI_OLD::message(instance, L'g');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L'L');
        KAPI_OLD::message(instance, L'i');
        KAPI_OLD::message(instance, L's');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L' ');
        KAPI_OLD::message(instance, L'd');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L'l');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L't');
        KAPI_OLD::message(instance, L'e');
        KAPI_OLD::message(instance, L' ');
        KAPI_OLD::message(instance, L'\"');
    }
    FORCE_INLINE void deleteTargetListEnd(void* instance){
        KAPI_OLD::message(instance, L'\"');
        KAPI_OLD::addMessage_EndLine(instance);
    }
    FORCE_INLINE void targetSign(void* instance){
        KAPI_OLD::message(instance, L'[');
        KAPI_OLD::message(instance, L'T');
        KAPI_OLD::message(instance, L']');
        KAPI_OLD::message(instance, L' ');
    }
    
}

class Kaura4X{
private:
    enum class ButtonFlag{
        none,
        nextPlayer,
        previousPlayer,
        atkSpeedUp,
        atkSpeedDown,
        multiAtkUp,
        multiAtkDown,
        hitRateUp,
        hitRateDown,
        infiniteAura,
        singleAura,
        targetAura,
        fullAtk,
        singleAtk,
        targetAtk,
        targetUidList,
        seeSelect
    };

    Minecraft *minecraft;
    shared_ptr<MultiplayerLocalPlayer> me;
    Level *level;

    Kaura4XButtonState buttonState;
    int  playerUID[4]           = {};
    shared_ptr<Player> target   = nullptr;
    ButtonFlag buttonFlag       = ButtonFlag::none;

    int  atkInterval            = 0;
    int  multiAtkValue          = 0;
    char atkSpeed               = 0;
    char multiAtk               = 0;
    char hitRate                = 0;
    char atkSpeedValue          = 0;
    bool isInfiniteAura         = false;
    bool isSingleAura           = false;
    bool isTargetAura           = false;
    bool targetSign             = false;
    bool seeSelectMode          = false;
    bool isLooking              = false;
    bool targetSelectShow       = false;
    
    FORCE_INLINE void begin();
    FORCE_INLINE void ButtonHandle();
    FORCE_INLINE void setUid(shared_ptr<Player> player);
    FORCE_INLINE bool isMatchUid(shared_ptr<Player> player);
    FORCE_INLINE shared_ptr<Player> isMatchUid(int uid[4]);
    FORCE_INLINE uint32_t getUidOwnerOffset();
    FORCE_INLINE shared_ptr<Player> targetUidListGetPlayer(int listNum);
    FORCE_INLINE void targetUidListPush(int *uid);
    FORCE_INLINE void targetUidListPop(int *uid);
    FORCE_INLINE bool targetUidListIf(int *uid);
    FORCE_INLINE void showTargetNNID(void* instance);
    FORCE_INLINE void showSelectPlayerMsg();
    FORCE_INLINE void selectPlayerHandle();
    FORCE_INLINE void selectShowHandle();
    FORCE_INLINE void buttonFlagHandle();
    FORCE_INLINE void packet(double x, double y, double z, Entity *ptr);
    FORCE_INLINE void attack();
    FORCE_INLINE void statusMessageHandle();
    FORCE_INLINE void targetUidListHandle();
    FORCE_INLINE void seeSelectHandle();
    FORCE_INLINE void posCorrection(double &posx, double &posy, double &posz);

public:
    int attackCount             = 0;
    FORCE_INLINE void kaura();
};

FORCE_INLINE void Kaura4X::begin(){
    targetSelectShow    = false;
    minecraft           = Minecraft::GetInstance();
}

FORCE_INLINE void Kaura4X::ButtonHandle(){
    buttonFlag = ButtonFlag::none;

    if(!operation_prohibited){

        if(PAD_DPAD_DOWN && PAD_R){
            if(!buttonState.nextPlayer) buttonFlag = ButtonFlag::nextPlayer;
            buttonState.nextPlayer = true;
        }
        else buttonState.nextPlayer = false;
        if(PAD_DPAD_DOWN && PAD_L){
            if(!buttonState.previousPlayer) buttonFlag = ButtonFlag::previousPlayer;
            buttonState.previousPlayer = true;
        }
        else buttonState.previousPlayer = false;

        if(PAD_DPAD_LEFT && PAD_R){
            if(!buttonState.atkSpeedUp) buttonFlag = ButtonFlag::atkSpeedUp;
            buttonState.atkSpeedUp = true;
        }
        else buttonState.atkSpeedUp = false;
        if(PAD_DPAD_LEFT && PAD_L){
            if(!buttonState.atkSpeedDown) buttonFlag = ButtonFlag::atkSpeedDown;
            buttonState.atkSpeedDown = true;
        }
        else buttonState.atkSpeedDown = false;

        if(PAD_DPAD_UP && PAD_R){
            if(!buttonState.multiAtkUp) buttonFlag = ButtonFlag::multiAtkUp;
            buttonState.multiAtkUp = true;
        }
        else buttonState.multiAtkUp = false;
        if(PAD_DPAD_UP && PAD_L){
            if(!buttonState.multiAtkDown) buttonFlag = ButtonFlag::multiAtkDown;
            buttonState.multiAtkDown = true;
        }
        else buttonState.multiAtkDown = false;

        if(PAD_DPAD_RIGHT && PAD_R){
            if(!buttonState.hitRateUp) buttonFlag = ButtonFlag::hitRateUp;
            buttonState.hitRateUp = true;
        }
        else buttonState.hitRateUp = false;
        if(PAD_DPAD_RIGHT && PAD_L){
            if(!buttonState.hitRateDown) buttonFlag = ButtonFlag::hitRateDown;
            buttonState.hitRateDown = true;
        }
        else buttonState.hitRateDown = false;

    }

    if(PAD_DPAD_LEFT && !operation_prohibited){
        if(!buttonState.infiniteAura) buttonState.infiniteAuraButtonCount++;
        buttonState.infiniteAura = true;
    }
    else buttonState.infiniteAura = false;

    if(buttonState.infiniteAuraButtonCount){
        if(buttonState.infiniteAuraButtonCount == 5){
            buttonState.infiniteAuraButtonTimeOutCount = 0;
            buttonState.infiniteAuraButtonCount = 0;
            buttonFlag = ButtonFlag::infiniteAura;
        }
        buttonState.infiniteAuraButtonTimeOutCount++;
    }
    if(buttonState.infiniteAuraButtonTimeOutCount > 0x60){
        buttonState.infiniteAuraButtonTimeOutCount = 0;
        buttonState.infiniteAuraButtonCount = 0;
    }

    if(PAD_DPAD_UP && !operation_prohibited){
        if(!buttonState.singleAura) buttonState.singleAuraButtonCount++;
        buttonState.singleAura = true;
    }
    else buttonState.singleAura = false;
    if(buttonState.singleAuraButtonCount){
        if(buttonState.singleAuraButtonCount == 5){
            buttonState.singleAuraButtonTimeOutCount = 0;
            buttonState.singleAuraButtonCount = 0;
            buttonFlag = ButtonFlag::singleAura;
        }
        buttonState.singleAuraButtonTimeOutCount++;
    }
    if(buttonState.singleAuraButtonTimeOutCount > 0x60){
        buttonState.singleAuraButtonTimeOutCount = 0;
        buttonState.singleAuraButtonCount = 0;
    }

    if(PAD_DPAD_DOWN && !operation_prohibited){
        if(!buttonState.targetAura) buttonState.targetAuraButtonCount++;
        buttonState.targetAura = true;
    }
    else buttonState.targetAura = false;
    if(buttonState.targetAuraButtonCount){
        if(buttonState.targetAuraButtonCount == 5){
            buttonState.targetAuraButtonTimeOutCount = 0;
            buttonState.targetAuraButtonCount = 0;
            buttonFlag = ButtonFlag::targetAura;
        }
        buttonState.targetAuraButtonTimeOutCount++;
    }
    if(buttonState.targetAuraButtonTimeOutCount > 0x60){
        buttonState.targetAuraButtonTimeOutCount = 0;
        buttonState.targetAuraButtonCount = 0;
    }
    if(PAD_DPAD_LEFT && PAD_ZR){
        if(!buttonState.fullAtk) buttonFlag = ButtonFlag::fullAtk;
        buttonState.fullAtk = true;
    }
    else buttonState.fullAtk = false;
    if(PAD_DPAD_UP && PAD_ZR){
        if(!buttonState.singleAtk) buttonFlag = ButtonFlag::singleAtk;
        buttonState.singleAtk = true;
    }
    else buttonState.singleAtk = false;
    
    if(PAD_DPAD_DOWN && PAD_ZR){
        if(!buttonState.targetAtk) buttonFlag = ButtonFlag::targetAtk;
        buttonState.targetAtk = true;
    }
    else buttonState.targetAtk = false;

    if(PAD_DPAD_DOWN && PAD_ZL){
        if(!buttonState.targetUidList) buttonFlag = ButtonFlag::targetUidList;
        buttonState.targetUidList = true;
    }
    else buttonState.targetUidList = false;

    if(PAD_DPAD_LEFT && PAD_ZL) seeSelectMode = true;
    else seeSelectMode = false;
}

FORCE_INLINE void Kaura4X::setUid(shared_ptr<Player> player){
    if(!player) return;
    for(int i = 0; i != 4; i++){playerUID[i] = player->firstUid.uid[i];}
}

FORCE_INLINE bool Kaura4X::isMatchUid(shared_ptr<Player> player){
    if(!player) return false;
    bool isMatch = true;
    for(int i = 0; i != 4; i++){
        if(playerUID[i] != player->firstUid.uid[i]) isMatch = false;
    }
    return isMatch;
}

FORCE_INLINE shared_ptr<Player> Kaura4X::isMatchUid(int *uid){
    if(!(level->players.size() > 1)) return nullptr;
    for(shared_ptr<Player> player : level->players){
        bool isMatch = true;
        for(int i = 0; i != 4; i++){
            if(uid[i] != player->firstUid.uid[i]) isMatch = false;
        }
        if(isMatch) return player;
    }
    return nullptr;
}

FORCE_INLINE uint32_t Kaura4X::getUidOwnerOffset(){
    if(!(level->players.size() > 1)) return 0;
    int i = 0;
    for(shared_ptr<Player> player : level->players){
        if(isMatchUid(player)) return i;
        i++;
    }
    return 0;
}

FORCE_INLINE shared_ptr<Player> Kaura4X::targetUidListGetPlayer(int listNum){
    if(!(level->players.size() > 1)) return nullptr;
    listNum *= 4;
    if(
        kaura4XtargetUidList[listNum+0] == 0 &&
        kaura4XtargetUidList[listNum+1] == 0 &&
        kaura4XtargetUidList[listNum+2] == 0 &&
        kaura4XtargetUidList[listNum+3] == 0
    );
    else for(shared_ptr<Player> player : level->players){
        bool isMatch = true;
        for(int i = 0; i != 4; i++){
            if(kaura4XtargetUidList[listNum+i] != player->firstUid.uid[i]) isMatch = false;
        }
        if(isMatch) return player;
    }
    return nullptr;
}

FORCE_INLINE void Kaura4X::targetUidListPush(int *uid){
    targetSign = true;
    int i = 0;
    for( ; kaura4XtargetUidList[i] && i != 400; i+=4);
    if(i >= 400) return;
    for(int c = 0; c != 4; c++){kaura4XtargetUidList[i+c] = uid[c];}
}

FORCE_INLINE void Kaura4X::targetUidListPop(int *uid){
    targetSign = false;
    for(int i = 0; i != 400; i+=4){
        if(
            kaura4XtargetUidList[i+0] == uid[0] &&
            kaura4XtargetUidList[i+1] == uid[1] &&
            kaura4XtargetUidList[i+2] == uid[2] &&
            kaura4XtargetUidList[i+3] == uid[3]
        ){
            for(int c = 0; c != 4; c++){kaura4XtargetUidList[i+c] = 0;}
        }
    }
}

FORCE_INLINE bool Kaura4X::targetUidListIf(int *uid){
    for(int i = 0; i != 400; i+=4){
        if(
            kaura4XtargetUidList[i+0] == 0 &&
            kaura4XtargetUidList[i+1] == 0 &&
            kaura4XtargetUidList[i+2] == 0 &&
            kaura4XtargetUidList[i+3] == 0
        ){
            continue;
        }
        if(
            kaura4XtargetUidList[i+0] == uid[0] &&
            kaura4XtargetUidList[i+1] == uid[1] &&
            kaura4XtargetUidList[i+2] == uid[2] &&
            kaura4XtargetUidList[i+3] == uid[3]
        ){
            return true;
        }
    }
    return false;
}

FORCE_INLINE void Kaura4X::showTargetNNID(void* instance){
    if(!target) return;
    if(targetSign) Kaura4XMessageIndex::targetSign(instance);
    for(uint32_t ad = target->nnidWchar; *(wchar_t*)ad; ad += 2){
        KAPI_OLD::message(instance, *(wchar_t*)ad);
    }
}

FORCE_INLINE void Kaura4X::showSelectPlayerMsg(){
    void* instance = KAPI_OLD::getInstance(KAPI_OLD::Type::addMessage);
    Kaura4XMessageIndex::selectPlayer(instance);
    showTargetNNID(instance);
    Kaura4XMessageIndex::selectPlayerEnd(instance);
}

FORCE_INLINE void Kaura4X::selectPlayerHandle(){
    if(!me || !me->level) return;
    if(!(level->players.size() > 1)) return;
    if(buttonFlag == ButtonFlag::nextPlayer) for(int i = 0; i != 8; i++){
        if(getUidOwnerOffset() >= level->players.size() - 1) setUid(level->players[1]);
        else setUid(level->players[getUidOwnerOffset() + 1]);
        targetSelectShow = true;
        if(!level->players[getUidOwnerOffset()]->spectatorMode) break;
    }
    if(buttonFlag == ButtonFlag::previousPlayer) for(int i = 0; i != 8; i++){
        if(getUidOwnerOffset() <= 1) setUid(level->players[level->players.size() - 1]);
        else setUid(level->players[getUidOwnerOffset() - 1]);
        targetSelectShow = true;
        if(!level->players[getUidOwnerOffset()]->spectatorMode) break;
    }
}

FORCE_INLINE void Kaura4X::selectShowHandle(){
    if(level->players.size() > 1) target = level->players[getUidOwnerOffset()];
    if(!target || target->getEntity() == me->getEntity()) target = nullptr;
    if(target){
        targetSign = targetUidListIf(target->firstUid.uid);
        if(targetSelectShow){
            me->playSound(*(SoundEvent**)0x109C6A68,3.0fl,3.0fl);
            showSelectPlayerMsg();
        }
    }
}

FORCE_INLINE void Kaura4X::buttonFlagHandle(){
    if(!me) return;
    if(buttonFlag == ButtonFlag::atkSpeedUp){
        if(atkSpeed < 10){
            me->playSound(*(SoundEvent**)0x109C69E0,1.0fl,2.0fl);
            atkSpeed++;
        }
        else me->playSound(*(SoundEvent**)0x109C64EC,2.0fl,3.0fl);
    }
    if(buttonFlag == ButtonFlag::atkSpeedDown && atkSpeed > 0){
        me->playSound(*(SoundEvent**)0x109C69E0,1.0fl,1.5fl);
        atkSpeed--;
    }
    if(atkSpeed <= 0)  atkSpeedValue = 0x3C;
    if(atkSpeed == 1)  atkSpeedValue = 0x20;
    if(atkSpeed == 2)  atkSpeedValue = 0x18;
    if(atkSpeed == 3)  atkSpeedValue = 0x10;
    if(atkSpeed == 4)  atkSpeedValue = 0xC;
    if(atkSpeed == 5)  atkSpeedValue = 0xA;
    if(atkSpeed == 6)  atkSpeedValue = 0x8;
    if(atkSpeed == 7)  atkSpeedValue = 0x6;
    if(atkSpeed == 8)  atkSpeedValue = 0x4;
    if(atkSpeed == 9)  atkSpeedValue = 0x2;
    if(atkSpeed >= 10) atkSpeedValue = 0x1;
    if(buttonFlag == ButtonFlag::multiAtkUp){
        if(multiAtk < 10){
            me->playSound(*(SoundEvent**)0x109C69E0,1.0fl,2.0fl);
            multiAtk++;
        }
        else me->playSound(*(SoundEvent**)0x109C64EC,2.0fl,3.0fl);
    }
    if(buttonFlag == ButtonFlag::multiAtkDown && multiAtk > 0){
        me->playSound(*(SoundEvent**)0x109C69E0,1.0fl,1.5fl);
        multiAtk--;
    }
    if(multiAtk == 0)  multiAtkValue = 0;
    if(multiAtk == 1)  multiAtkValue = 5;
    if(multiAtk == 2)  multiAtkValue = 10;
    if(multiAtk == 3)  multiAtkValue = 25;
    if(multiAtk == 4)  multiAtkValue = 50;
    if(multiAtk == 5)  multiAtkValue = 100;
    if(multiAtk == 6)  multiAtkValue = 150;
    if(multiAtk == 7)  multiAtkValue = 250;
    if(multiAtk == 8)  multiAtkValue = 500;
    if(multiAtk == 9)  multiAtkValue = 1000;
    if(multiAtk >= 10) multiAtkValue = 5000;
    if(buttonFlag == ButtonFlag::hitRateUp){
        if(hitRate < 5){
            me->playSound(*(SoundEvent**)0x109C69E0,1.0fl,2.0fl);
            hitRate++;
        }
        else me->playSound(*(SoundEvent**)0x109C64EC,2.0fl,3.0fl);
    }
    if(buttonFlag == ButtonFlag::hitRateDown && hitRate > 0){
        me->playSound(*(SoundEvent**)0x109C69E0,1.0fl,1.5fl);
        hitRate--;
    }
    if(buttonFlag == ButtonFlag::infiniteAura){
        if(isInfiniteAura){
            isInfiniteAura = false;
            me->playSound(*(SoundEvent**)0x109C65AC,1.0fl,1.0fl);
        }
        else{
            isInfiniteAura = true;
            isSingleAura   = false;
            isTargetAura   = false;
            me->playSound(*(SoundEvent**)0x109C65AC,1.0fl,2.0fl);
        }
    }
    if(buttonFlag == ButtonFlag::singleAura){
        if(isSingleAura){
            isSingleAura = false;
            me->playSound(*(SoundEvent**)0x109C6A7C,1.0fl,1.0fl);
        }
        else{
            isSingleAura   = true;
            isInfiniteAura = false;
            isTargetAura   = false;
            me->playSound(*(SoundEvent**)0x109C6A7C,1.0fl,2.0fl);
        }
    }
    if(buttonFlag == ButtonFlag::targetAura){
        if(isTargetAura){
            isTargetAura = false;
            me->playSound(*(SoundEvent**)0x109C6A1C,1.0fl,1.0fl);
        }
        else{
            isTargetAura   = true;
            isInfiniteAura = false;
            isSingleAura   = false;
            me->playSound(*(SoundEvent**)0x109C6A1C,1.0fl,2.0fl);
        }
    }
    if(buttonState.seeSelectMode){
        if(!seeSelectMode){
            me->playSound(*(SoundEvent**)0x109C6A78,1.0fl,2.5fl);
            buttonState.seeSelectMode = false;
        }
    }
    else if(seeSelectMode){
        me->playSound(*(SoundEvent**)0x109C6A78,1.0fl,3.0fl);
        buttonState.seeSelectMode = true;
    }
    
}

FORCE_INLINE void Kaura4X::packet(double x, double y, double z, Entity *ptr){
    ClientPacketListener *listener = me->packetListener;
    if(!listener) return;
    shared_ptr<Packet> move1(ServerboundMovePlayerPosPacket::__ct(
        nullptr, x, y, 0.0fl, z, true, true)
    );
    listener->send(move1);
    move1->deletePacket();
    shared_ptr<Packet> move2(ServerboundMovePlayerPosPacket::__ct(
        nullptr, x, y - 0.1fl, 0.0fl, z, false, false)
    );
    listener->send(move2);
    move2->deletePacket();
    shared_ptr<Packet> interact1(ServerboundInteractPacket::__ct(
        nullptr, ptr)
    );
    for(int multiAtk_c = 0; multiAtk_c <= multiAtkValue; multiAtk_c++){
        listener->send(interact1);
    }
    interact1->deletePacket();
    shared_ptr<Packet> move3(ServerboundMovePlayerPosPacket::__ct(
        nullptr, x, y, 0.0fl, z, true, true)
    );
    listener->send(move3);
    move3->deletePacket();
}

FORCE_INLINE void Kaura4X::attack(){
    if(!me) return;
    double px=0.0fl,py=0.0fl,pz=0.0fl;
    auto pos_set = [&px,&py,&pz](double x, double y, double z){ px = x,py = y,pz = z; };
    Entity *ptr = nullptr;
    if(target){
        pos_set(target->position.x,target->position.y,target->position.z);
        ptr = target->getEntity();
    }
    
    double distance = 8.0fl;
    double hitRatef = intToDouble(hitRate);
    double range = hitRatef*distance;
    if(range < 1.0fl) range = 1.0fl;
    for(shared_ptr<Player> player : level->players){
        if(player->getEntity() == me->getEntity() || player->spectatorMode) continue;
        if(isInfiniteAura || buttonFlag == ButtonFlag::fullAtk){
            pos_set(player->position.x,player->position.y,player->position.z);
            ptr = player->getEntity();
        }
    for(int uidListCount = 0; uidListCount != 100; uidListCount++){

        if(isTargetAura || buttonFlag == ButtonFlag::targetAtk){
            shared_ptr<Player> targets = targetUidListGetPlayer(uidListCount);
            if(!targets) continue;
            pos_set(targets->position.x,targets->position.y,targets->position.z);
            ptr = targets->getEntity();
        }

        for(double x = px-range; x <= px+range; x += distance){
            for(double y = py+range; y >= py-range; y -= distance){
                for(double z = pz-range; z <= pz+range; z += distance){
                    double sx=px,sy=py,sz=pz;
                    if(hitRate) sx = x,sy = y,sz = z;
                    posCorrection(sx,sy,sz);
                    packet(sx, sy, sz, ptr);
                    if(!hitRate) goto end;
                }
            }
        }

        end:
        ClientPacketListener *listener = me->packetListener;
        shared_ptr<Packet> move1(ServerboundMovePlayerPosPacket::__ct(
            nullptr, me->position.x, me->position.y, 0.0fl, me->position.z, true, true)
        );
        listener->send(move1);
        move1->deletePacket();
        
    if(!(isTargetAura || buttonFlag == ButtonFlag::targetAtk)) break;
    }
    if(!(isInfiniteAura || buttonFlag == ButtonFlag::fullAtk)) break;
    }
    attackCount++;
}

FORCE_INLINE void Kaura4X::statusMessageHandle(){
    if(!me) return;
    void* instance = KAPI_OLD::getInstance(KAPI_OLD::Type::singleMessage);
    Kaura4XMessageIndex::kaura(instance);
    if(isInfiniteAura)    Kaura4XMessageIndex::infiniteAura(instance);
    else if(isSingleAura) Kaura4XMessageIndex::singleAura(instance);
    else if(isTargetAura) Kaura4XMessageIndex::targetAura(instance);
    else {
        KAPI_OLD::message(instance, L'-');
        KAPI_OLD::message(instance, L' ');
    }
    Kaura4XMessageIndex::kauraStaus(instance);
    Kaura4XMessageIndex::selectedPlayer(instance);
    if(target) showTargetNNID(instance);
    else Kaura4XMessageIndex::noTarget(instance);
    Kaura4XMessageIndex::selectedPlayerEnd(instance);
    if(atkSpeed){
        Kaura4XMessageIndex::atkSpeed(instance);
        if(atkSpeed != 10) KAPI_OLD::message(instance, 0x30+atkSpeed);
        else Kaura4XMessageIndex::max(instance);
        Kaura4XMessageIndex::end(instance);
    }
    if(multiAtk){
        Kaura4XMessageIndex::multiAtk(instance);
        if(multiAtk != 10) KAPI_OLD::message(instance, 0x30+multiAtk);
        else Kaura4XMessageIndex::max(instance);
        Kaura4XMessageIndex::end(instance);
    }
    if(hitRate){
        Kaura4XMessageIndex::hitRate(instance);
        if(hitRate != 5) KAPI_OLD::message(instance, 0x30+hitRate);
        else Kaura4XMessageIndex::max(instance);
        Kaura4XMessageIndex::end(instance);
    }
    Kaura4XMessageIndex::kauraStausEnd(instance);
}

FORCE_INLINE void Kaura4X::targetUidListHandle(){
    if(buttonFlag != ButtonFlag::targetUidList || !target) return;
    void* instance = KAPI_OLD::getInstance(KAPI_OLD::Type::addMessage);
    int *uid = target->firstUid.uid;
    if(targetUidListIf(uid)){
        targetUidListPop(uid);
        Kaura4XMessageIndex::deleteTargetList(instance);
        showTargetNNID(instance);
        Kaura4XMessageIndex::deleteTargetListEnd(instance);
        me->playSound(*(SoundEvent**)0x109C6A64,1.0fl,1.5fl);
    }
    else{
        targetUidListPush(uid);
        Kaura4XMessageIndex::addTargetList(instance);
        showTargetNNID(instance);
        Kaura4XMessageIndex::addTargetListEnd(instance);
        me->playSound(*(SoundEvent**)0x109C6A64,1.0fl,2.0fl);
    }
    
}

FORCE_INLINE void Kaura4X::seeSelectHandle(){
    if(!me) return;
    if(seeSelectMode){
        *(float*)0x1088E7D0 = 0.6fl;//Fov
        *(float*)0x108911B0 = 0.6fl;//FlyFov
        *(float*)0x108C9AE4 = 120.0fl;//感度
        *(float*)0x108E0BDC = 512.0fl;//クリエイティブモードのリーチ
        *(float*)0x108F5620 = 512.0fl;//サバイバルモードのリーチ
        *(float*)0x108C9C20 = 5.0fl;//長距離リーチをモブに対応
        *(float*)0x108C9C28 = 5.0fl;//長距離リーチをモブに対応
        kernel_write_value(0x020E8334,0x38600000);//壁を抜けて指定
    }
    else{
        *(float*)0x1088E7D0 = 1.0fl;//Fov
        *(float*)0x108911B0 = 1.1fl;//FlyFov
        *(float*)0x108C9AE4 = 100.0fl;//感度
        *(float*)0x108E0BDC = 5.0fl;//クリエイティブモードのリーチ
        *(float*)0x108F5620 = 4.5fl;//サバイバルモードのリーチ
        *(float*)0x108C9C20 = 2.125fl;//長距離リーチをモブに対応
        *(float*)0x108C9C28 = 2.375fl;//長距離リーチをモブに対応
        kernel_write_value(0x020E8334,0x38600001);//壁を抜けて指定
        return;
    }
    mc_boost::shared_ptr<Entity> seeEntity = minecraft->targetEntity;
    if(!seeEntity){
        if(isLooking){
            isLooking = false;
        }
        return;
    }
    mc_boost::shared_ptr<Player> targetPlayer;
    for(mc_boost::shared_ptr<Player> player : level->players){
        if(player->getEntity() == seeEntity->getEntity()){
            targetPlayer = player;
        }
    }
    if(!targetPlayer || (isMatchUid(playerUID) && 
        targetPlayer->getEntity() == isMatchUid(playerUID)->getEntity())
    ) return;

    if(!isLooking){
        setUid(targetPlayer);
        targetSelectShow = true;
    }
    isLooking = true;
}

FORCE_INLINE void Kaura4X::posCorrection(double &posx, double &posy, double &posz){
    double radius = 2.0db;
    double formula = 0.0db;
    bool isCorrection = false;
    for (double x = posx - radius; x < posx + radius; x += 1.0db) {
        for (double y = posy + radius; y > posy - radius; y -= 1.0db) {
            for (double z = posz - radius; z < posz + radius; z += 1.0db) {
                formula = (x-posx)*(x-posx)+
                          (y-posy)*(y-posy)+
                          (z-posz)*(z-posz);
                if(formula >= radius*radius) continue;
                int blockId = level->getBlockId(x,y,z);
                if(
                    (
                        blockId == 8   ||
                        blockId == 9   ||
                        blockId == 10  ||
                        blockId == 11  ||
                        blockId == 65  ||
                        blockId == 106
                    )&& !isCorrection
                ){
                    radius = 4.0db;
                    x = posx - radius;
                    y = posy + radius;
                    z = posz - radius;
                    isCorrection = true;
                    continue;
                }
                if(isCorrection){
                    posx = x, posy = y, posz = z;
                    return;
                }
            }
        }
    }
}

FORCE_INLINE void Kaura4X::kaura(){
    begin();
    if(!minecraft) return;
    me = minecraft->thePlayer;
    if(me){
        level = me->level;
        if(!level) return;
        LevelChunk::CreateNewThreadStorage();
        ElementStorage::CreateNewThreadStorage(
            ElementStorage::eHESThreadId::kaura
        );
        atkInterval++;
        ButtonHandle();
        buttonFlagHandle();
        selectPlayerHandle();
        seeSelectHandle();
        selectShowHandle();
        targetUidListHandle();
        statusMessageHandle();
        if(((atkInterval > atkSpeedValue && (isInfiniteAura || (isSingleAura && target) || isTargetAura)) || 
            buttonFlag == ButtonFlag::fullAtk ||
            (buttonFlag == ButtonFlag::singleAtk && target) ||
            buttonFlag == ButtonFlag::targetAtk)
        ){
            attack();
            atkInterval = -(hitRate > 2 ? (hitRate*hitRate)*(hitRate*hitRate) : 0);
        }
        LevelChunk::ReleaseThreadStorage();
        ElementStorage::ReleaseThreadStorage();
    }
    else{
        atkInterval             = 0;
        atkSpeed                = 0;
        multiAtk                = 0;
        hitRate                 = 0;
        atkSpeedValue           = 0;
        multiAtkValue           = 0;
        isInfiniteAura          = false;
        isSingleAura            = false;
        isTargetAura            = false;
        seeSelectMode           = false;
        isLooking               = false;
        targetSelectShow        = false;
        target                  = nullptr;
        buttonFlag              = ButtonFlag::none;
    }

}
