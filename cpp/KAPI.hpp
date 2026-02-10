#ifndef __KAPI_H__
#define __KAPI_H__

#include <stdio.h>
#include "Obfuscation.hpp"
#include "library/basic_string.hpp"
#include "library/kernel.hpp"
#include "library/strlen.hpp"

#include "mc/client/Minecraft.hpp"








#define KAPI_VER_5_INSTANCE_ADDRESS 0x10250800

class KAPI5{
    struct PtrC{
        uint32_t ptr   = 0;
        uint32_t count = 0;
    };
    PtrC addMessagePtr;
    PtrC addMessageFormatPtr;
    uint32_t addMessageBasicStringPtr;
    PtrC messagePtr;
    PtrC messageFormatPtr;
    uint32_t messageBasicStringPtr;
    PtrC kernelWritePtr;
public:
    FORCE_INLINE KAPI5();
    FORCE_INLINE void addMessage(wchar_t text);
    FORCE_INLINE void message(wchar_t text);
    template <typename ... Args>
    FORCE_INLINE void addMessageAssignToFormat(Args ... args);
    template <typename ... Args>
    FORCE_INLINE void messageAssignToFormat(Args ... args);
    template <typename ... Args>
    FORCE_INLINE void addMessageEndLine(Args ... args);
    FORCE_INLINE void kernelWrite(uint32_t address, uint32_t value);
    FORCE_INLINE void addMessageHandler();
    FORCE_INLINE void messageHandler();
    FORCE_INLINE void kernelWriteHandler();
    FORCE_INLINE void update();
    FORCE_INLINE static KAPI5 *getInstance(){ return *(KAPI5**)KAPI_VER_5_INSTANCE_ADDRESS; }
};

FORCE_INLINE KAPI5::KAPI5(){
    addMessagePtr.ptr        = 0x10250D00;
    addMessageFormatPtr.ptr  = 0x10258D00;
    addMessageBasicStringPtr = 0x10250A00;
    messagePtr.ptr           = 0x10260D00;
    messageFormatPtr.ptr     = 0x10268D00;
    messageBasicStringPtr    = 0x10250B00;
    kernelWritePtr.ptr       = 0x10270D00;
}

FORCE_INLINE void KAPI5::addMessage(wchar_t text){
    *(wchar_t*)(addMessagePtr.ptr+addMessagePtr.count) = text;
    addMessagePtr.count += sizeof(wchar_t);
}

FORCE_INLINE void KAPI5::message(wchar_t text){
    *(wchar_t*)(messagePtr.ptr+messagePtr.count) = text;
    messagePtr.count += sizeof(wchar_t);
}

template <typename ... Args>
FORCE_INLINE void KAPI5::addMessageAssignToFormat(Args ... args){
    *(wchar_t*)(addMessagePtr.ptr+addMessagePtr.count) = L'\0';
    uint32_t size = addMessageFormatPtr.count;
    mc_swprintf((wchar_t*)(addMessageFormatPtr.ptr + size), 0x4000 - size, (wchar_t*)addMessagePtr.ptr, args ...);
    uint32_t ad = 0;
    for( ; *(wchar_t*)(addMessageFormatPtr.ptr + ad); ad += sizeof(wchar_t));
    addMessagePtr.count = 0;
    addMessageFormatPtr.count += ad;
}

template <typename ... Args>
FORCE_INLINE void KAPI5::messageAssignToFormat(Args ... args){
    *(wchar_t*)(messagePtr.ptr+messagePtr.count) = L'\0';
    uint32_t size = messageFormatPtr.count;
    mc_swprintf((wchar_t*)(messageFormatPtr.ptr + size), 0x4000 - size, (wchar_t*)messagePtr.ptr, args ...);
    uint32_t ad = 0;
    for( ; *(wchar_t*)(messageFormatPtr.ptr + ad); ad += sizeof(wchar_t));
    messagePtr.count = 0;
    messageFormatPtr.count += ad;
}

template <typename ... Args>
FORCE_INLINE void KAPI5::addMessageEndLine(Args ... args){
    *(wchar_t*)(addMessagePtr.ptr+addMessagePtr.count) = L'\0';
    uint32_t size = addMessageFormatPtr.count;
    mc_swprintf((wchar_t*)(addMessageFormatPtr.ptr + size), 0x4000 - size, (wchar_t*)addMessagePtr.ptr, args ...);
    uint32_t ad = 0;
    for( ; *(wchar_t*)(addMessageFormatPtr.ptr + ad); ad += sizeof(wchar_t));
    addMessagePtr.count = 0;
    addMessageFormatPtr.count += ad;
    *(wchar_t*)(addMessageFormatPtr.ptr + addMessageFormatPtr.count) = 0;
    addMessageFormatPtr.count += sizeof(wchar_t);
}

FORCE_INLINE void KAPI5::kernelWrite(uint32_t address, uint32_t value){
    *(uint32_t*)(kernelWritePtr.ptr+kernelWritePtr.count) = address;
    kernelWritePtr.count += sizeof(uint32_t);
    *(uint32_t*)(kernelWritePtr.ptr+kernelWritePtr.count) = value;
    kernelWritePtr.count += sizeof(uint32_t);
}

FORCE_INLINE void KAPI5::addMessageHandler(){
    mc::Minecraft *minecraft = mc::Minecraft::GetInstance();
    mc_boost::shared_ptr<mc::MultiplayerLocalPlayer> me = nullptr;
    if(minecraft) me = minecraft->thePlayer;
    if(!me || *(wchar_t*)addMessageFormatPtr.ptr == 0);
    else for(uint32_t ad = addMessageFormatPtr.ptr; *(uint32_t*)ad != 0; ad += sizeof(wchar_t)){
        if(ad == addMessageFormatPtr.ptr || (*(wchar_t*)(ad - sizeof(wchar_t)) == 0 && *(uint32_t*)(ad - sizeof(wchar_t)) != 0)){
            bstd::b_basic_string<wchar_t>* text = (bstd::b_basic_string<wchar_t>*)addMessageBasicStringPtr;
            text->buffer   = (wchar_t*)ad;
            text->length   = wstrlen((wchar_t*)ad);
            text->capacity = text->length + 0x10;
            minecraft->gui->addMessage(*text,0,false,false,false,false);
        }
    }
    for(uint32_t offset = 0; offset != addMessagePtr.count; offset += sizeof(wchar_t)){
        *(wchar_t*)(addMessagePtr.ptr + offset) = 0;
    }
    addMessagePtr.count = 0;
    for(uint32_t offset = 0; offset != addMessageFormatPtr.count; offset += sizeof(wchar_t)){
        *(wchar_t*)(addMessageFormatPtr.ptr + offset) = 0;
    }
    addMessageFormatPtr.count = 0;
}

FORCE_INLINE void KAPI5::messageHandler(){
    mc::Minecraft *minecraft = mc::Minecraft::GetInstance();
    mc_boost::shared_ptr<mc::MultiplayerLocalPlayer> me = nullptr;
    if(minecraft) me = minecraft->thePlayer;
    if(me && *(wchar_t*)messageFormatPtr.ptr != 0){
        bstd::b_basic_string<wchar_t>* text = (bstd::b_basic_string<wchar_t>*)messageBasicStringPtr;
        text->buffer   = (wchar_t*)messageFormatPtr.ptr;
        text->length   = wstrlen((wchar_t*)messageFormatPtr.ptr);
        text->capacity = text->length + 0x10;
        minecraft->gui->setSingleMessage(*text,0,0);
    }
    for(uint32_t offset = 0; offset != messagePtr.count; offset += sizeof(wchar_t)){
        *(wchar_t*)(messagePtr.ptr + offset) = 0;
    }
    messagePtr.count = 0;
    for(uint32_t offset = 0; offset != messageFormatPtr.count; offset += sizeof(wchar_t)){
        *(wchar_t*)(messageFormatPtr.ptr + offset) = 0;
    }
    messageFormatPtr.count = 0;
}

FORCE_INLINE void KAPI5::kernelWriteHandler(){
    if(*(uint64_t*)kernelWritePtr.ptr == 0) return;
    for(uint32_t ad = kernelWritePtr.ptr; *(uint64_t*)ad != 0; ad += sizeof(uint64_t)){
        kernel_write_value(ad, ad + sizeof(uint32_t));
        *(uint64_t*)ad = 0;
    }
    kernelWritePtr.count = 0;
}

FORCE_INLINE void KAPI5::update(){
    
    addMessageHandler();
    messageHandler();
    kernelWriteHandler();
}







#define KAPI_VER_5_INSTANCE_ADDRESS_OB ob4(0x10250800)

class KAPI5_OB{
    struct PtrC{
        uint32_t ptr   = ob7(0);
        uint32_t count = ob2(0);
    };
    PtrC addMessagePtr;
    PtrC addMessageFormatPtr;
    uint32_t addMessageBasicStringPtr;
    PtrC messagePtr;
    PtrC messageFormatPtr;
    uint32_t messageBasicStringPtr;
    PtrC kernelWritePtr;
public:
    FORCE_INLINE KAPI5_OB();
    FORCE_INLINE void addMessage(wchar_t text);
    FORCE_INLINE void message(wchar_t text);
    template <typename ... Args>
    FORCE_INLINE void addMessageAssignToFormat(Args ... args);
    template <typename ... Args>
    FORCE_INLINE void messageAssignToFormat(Args ... args);
    FORCE_INLINE void addMessageEndLine();
    FORCE_INLINE void kernelWrite(uint32_t address, uint32_t value);
    FORCE_INLINE void addMessageHandler();
    FORCE_INLINE void messageHandler();
    FORCE_INLINE void kernelWriteHandler();
    FORCE_INLINE void update();
    FORCE_INLINE static KAPI5_OB *getInstance(){ return (KAPI5_OB*)KAPI_VER_5_INSTANCE_ADDRESS_OB; }
};

FORCE_INLINE KAPI5_OB::KAPI5_OB(){
    addMessagePtr.ptr        = ob6(0x10250D00);
    addMessageFormatPtr.ptr  = ob1(0x10258D00);
    addMessageBasicStringPtr = ob5(0x10250A00);
    messagePtr.ptr           = ob8(0x10260D00);
    messageFormatPtr.ptr     = ob7(0x10268D00);
    messageBasicStringPtr    = ob4(0x10250B00);
    kernelWritePtr.ptr       = ob2(0x10270D00);
}

FORCE_INLINE void KAPI5_OB::addMessage(wchar_t text){
    *(wchar_t*)(addMessagePtr.ptr+addMessagePtr.count) = text;
    addMessagePtr.count += sizeof(wchar_t);
}

FORCE_INLINE void KAPI5_OB::message(wchar_t text){
    *(wchar_t*)(messagePtr.ptr+messagePtr.count) = text;
    messagePtr.count += sizeof(wchar_t);
}

template <typename ... Args>
FORCE_INLINE void KAPI5_OB::addMessageAssignToFormat(Args ... args){
    *(wchar_t*)(addMessagePtr.ptr+addMessagePtr.count) = ob4(L'\0');
    uint32_t size = addMessageFormatPtr.count;
    mc_swprintf((wchar_t*)(addMessageFormatPtr.ptr + size), ob3(0x4000) - size, (wchar_t*)addMessagePtr.ptr, args ...);
    uint32_t ad = ob2(0);
    for( ; *(wchar_t*)(addMessageFormatPtr.ptr + ad); ad += sizeof(wchar_t));
    addMessagePtr.count = ob1(0);
    addMessageFormatPtr.count += ad;
}

template <typename ... Args>
FORCE_INLINE void KAPI5_OB::messageAssignToFormat(Args ... args){
    *(wchar_t*)(messagePtr.ptr+messagePtr.count) = ob8(L'\0');
    uint32_t size = messageFormatPtr.count;
    mc_swprintf((wchar_t*)(messageFormatPtr.ptr + size), ob7(0x4000) - size, (wchar_t*)messagePtr.ptr, args ...);
    uint32_t ad = ob6(0);
    for( ; *(wchar_t*)(messageFormatPtr.ptr + ad); ad += sizeof(wchar_t));
    messagePtr.count = ob5(0);
    messageFormatPtr.count += ad;
}

FORCE_INLINE void KAPI5_OB::addMessageEndLine(){
    *(wchar_t*)(addMessageFormatPtr.ptr + addMessageFormatPtr.count) = ob4(0);
    addMessageFormatPtr.count += sizeof(wchar_t);
}

FORCE_INLINE void KAPI5_OB::kernelWrite(uint32_t address, uint32_t value){
    *(uint32_t*)(kernelWritePtr.ptr+kernelWritePtr.count) = address;
    kernelWritePtr.count += sizeof(uint32_t);
    *(uint32_t*)(kernelWritePtr.ptr+kernelWritePtr.count) = value;
    kernelWritePtr.count += sizeof(uint32_t);
}

FORCE_INLINE void KAPI5_OB::addMessageHandler(){
    mc::Minecraft *minecraft = mc::Minecraft::GetInstance();
    if(!minecraft || *(wchar_t*)addMessageFormatPtr.ptr == ob3(0));
    else for(uint32_t ad = addMessageFormatPtr.ptr; *(uint32_t*)ad != ob2(0); ad += sizeof(wchar_t)){
        if(ad == addMessageFormatPtr.ptr || (*(wchar_t*)(ad - sizeof(wchar_t)) == ob1(0) && *(uint32_t*)(ad - sizeof(wchar_t)) != ob8(0))){
            bstd::b_basic_string<wchar_t>* text = (bstd::b_basic_string<wchar_t>*)addMessageBasicStringPtr;
            text->buffer   = (wchar_t*)ad;
            text->length   = wstrlen((wchar_t*)ad);
            text->capacity = text->length + ob7(0x10);
            minecraft->gui->addMessage(*text,ob6(0),false,false,false,false);
        }
    }
    for(uint32_t offset = ob5(0); offset > addMessageFormatPtr.count; offset += sizeof(wchar_t)){
        *(wchar_t*)(addMessageFormatPtr.ptr + offset) = ob4(0);
    }
    addMessageFormatPtr.count = ob3(0);
}

FORCE_INLINE void KAPI5_OB::messageHandler(){
    mc::Minecraft *minecraft = mc::Minecraft::GetInstance();
    if(minecraft && *(wchar_t*)messageFormatPtr.ptr != ob2(0)){
        bstd::b_basic_string<wchar_t>* text = (bstd::b_basic_string<wchar_t>*)messageBasicStringPtr;
        text->buffer   = (wchar_t*)messageFormatPtr.ptr;
        text->length   = wstrlen((wchar_t*)messageFormatPtr.ptr);
        text->capacity = text->length + ob1(0x10);
        minecraft->gui->setSingleMessage(*text,ob8(0),ob7(0));
    }
    for(uint32_t offset = ob6(0); offset > messageFormatPtr.count; offset += sizeof(wchar_t)){
        *(wchar_t*)(messageFormatPtr.ptr + offset) = ob5(0);
    }
    messageFormatPtr.count = ob4(0);
}

FORCE_INLINE void KAPI5_OB::kernelWriteHandler(){
    if(*(uint64_t*)kernelWritePtr.ptr == ob3(0)) return;
    for(uint32_t ad = kernelWritePtr.ptr; *(uint64_t*)ad != ob2(0); ad += sizeof(uint64_t)){
        kernel_write_value(ad, ad + sizeof(uint32_t));
        *(uint64_t*)ad = ob1(0);
    }
}

FORCE_INLINE void KAPI5_OB::update(){
    addMessageHandler();
    messageHandler();
    kernelWriteHandler();
}









#define KAIP_OLD_INITIALIZED *(bool*)0x11C1FF20
#define KAIP_OLD_INITIALIZED_OB *(bool*)ob1(0x11C1FF20)

namespace KAPI_OLD{
    enum class Type{
        kernelWrite,
        singleMessage,
        addMessage
    };
    FORCE_INLINE void *getInstance(Type type){
        if(type == Type::kernelWrite) return (void*)0x11C1FF40;
        if(type == Type::singleMessage) return (void*)0x11C1FF44;
        if(type == Type::addMessage) return (void*)0x11C1FF48;
        return nullptr;
    }
    FORCE_INLINE void kernelWrite(void* instance, uint32_t a, uint32_t b){
        if(*(uint32_t*)a != b){
            *(wchar_t*)(*(uint32_t*)(uintptr_t)instance) = a;
            *(uint32_t*)instance += 4;
            *(wchar_t*)(*(uint32_t*)(uintptr_t)instance) = b;
            *(uint32_t*)(uintptr_t)instance += 4;
        }
    }

    FORCE_INLINE void message(void* instance, wchar_t s){
        *(wchar_t*)(*(uint32_t*)(uintptr_t)instance) = s;
        *(uint32_t*)(uintptr_t)instance += 2;
    }

    FORCE_INLINE void addMessage_EndLine(void* instance){
        *(uint32_t*)(*(uint32_t*)(uintptr_t)instance) = 0xFEFEFEFE;
        *(uint32_t*)(uintptr_t)instance += 0x20;
    }

}

namespace KAPI_OLD_OB{
    enum class Type{
        kernelWrite,
        singleMessage,
        addMessage
    };
    FORCE_INLINE void *getInstance(Type type){
        if(type == Type::kernelWrite) return (void*)ob1(0x11C1FF40);
        if(type == Type::singleMessage) return (void*)ob1(0x11C1FF44);
        if(type == Type::addMessage) return (void*)ob1(0x11C1FF48);
        return nullptr;
    }
    FORCE_INLINE void kernelWrite(void* instance, uint32_t a, uint32_t b){
        if(*(uint32_t*)a != b){
            *(wchar_t*)(*(uint32_t*)(uintptr_t)instance) = a;
            *(uint32_t*)instance += 4;
            *(wchar_t*)(*(uint32_t*)(uintptr_t)instance) = b;
            *(uint32_t*)(uintptr_t)instance += 4;
        }
    }

    FORCE_INLINE void message(void* instance, wchar_t s){
        *(wchar_t*)(*(uint32_t*)(uintptr_t)instance) = s;
        *(uint32_t*)(uintptr_t)instance += 2;
    }

    FORCE_INLINE void addMessage_EndLine(void* instance){
        *(uint32_t*)(*(uint32_t*)instance) = ob1(0xFEFEFEFE);
        *(uint32_t*)(uintptr_t)instance += ob2(0x20);
    }

}

namespace KAPI_OLD_Handle{

    FORCE_INLINE void addMessage(int address){
        int wcharCount = 0;
        for( ; *(short*)(address + wcharCount * 2) != 0; wcharCount++){
            if(*(uint32_t*)(address + wcharCount * 2) == 0xFEFEFEFE) *(uint32_t*)(address + wcharCount * 2) = 0;
        }
        *(int*)(address + wcharCount * 2 + 4 + 0x14) = address;
        *(int*)(address + wcharCount * 2 + 4 + 0x18) = wcharCount * 2;
        *(int*)(address + wcharCount * 2 + 4 + 0x1C) = wcharCount * 2 + 0x10;
        ((void(*)(int, int* ,bool, bool, bool, bool, bool))0x0313873C)(*(int*)(*(int*)0x109cd8e4 + 0x144),(int*)(address + wcharCount * 2 + 4),
        false,false,false,false,false);
    }
    FORCE_INLINE void setSingleMessage(int address){
        int wcharCount = 0;
        for( ; *(short*)(address + wcharCount * 2) != 0; wcharCount++);
        *(int*)(address + wcharCount * 2 + 4 + 0x14) = address;
        *(int*)(address + wcharCount * 2 + 4 + 0x18) = wcharCount * 2;
        *(int*)(address + wcharCount * 2 + 4 + 0x1C) = wcharCount * 2 + 0x10;
        ((void(*)(int, int* ,int, int))0x031390F8)(*(int*)(*(int*)0x109cd8e4 + 0x144),(int*)(address + wcharCount * 2 + 4),0,0);
    }

}

namespace KAPI_OLD_Handle_OB{

    FORCE_INLINE void addMessage(int address){
        int a = *(int*)0x0303F054;
        int b = *(int*)0x02C40360;
        for(int i = (*(char*)0x023A8877 >> 4) * 0x1000000; i != ((*(char*)0x023A8877 >> 4) * 0x1000000) + *(char*)0x02900336 * *(char*)0x0290077F; i++){
            a += *(int*)i >> 3;
        }
        for(
            int i = (*(char*)0x023A8877 >> 4) * 0x1000000;
            i != ((*(char*)0x023A8877 >> 4) * 0x1000000) + (*(char*)0x02500263 << 4) + *(char*)0x02500467;
            i++
        ){
            b += *(int*)i >> 5;
        }
        a = a ^ b;
        a = a * b;
        int x1 = ((0 + 0x1E470019) - a);
        int x2 = ((2 + 0x1E470019) - a);
        int x3 = ((4 + 0x1E470019) - a);
        int wcharCount = x1;
        for( ; *(short*)(address + wcharCount * 2) != x1; wcharCount++){
            if(*(uint32_t*)(address + wcharCount * 2) == ((0xFEFEFEFE + 0x1E470019) - a)) *(uint32_t*)(address + wcharCount * 2) = 0;
        }
        *(int*)(address + wcharCount * x2 + x3 + 0x14) = address;
        *(int*)(address + wcharCount * x2 + x3 + 0x18) = wcharCount * x2;
        *(int*)(address + wcharCount * x2 + x3 + 0x1C) = wcharCount * x2 + 0x10;
        ((void(*)(int, int* ,bool, bool, bool, bool, bool))((0x0313873C + 0x1E470019) - a))
        (*(int*)(*(int*)((0x109cd8e4 + 0x1E470019) - a) + ((0x144 + 0x1E470019) - a)),
        (int*)(address + wcharCount * x2 + x3),false,false,false,false,false);
    }

    FORCE_INLINE void setSingleMessage(int address){
        int a = *(int*)0x0303F054;
        int b = *(int*)0x02C40360;
        for(int i = (*(char*)0x023A8877 >> 4) * 0x1000000; i != ((*(char*)0x023A8877 >> 4) * 0x1000000) + *(char*)0x02900336 * *(char*)0x0290077F; i++){
            a += *(int*)i >> 3;
        }
        for(
            int i = (*(char*)0x023A8877 >> 4) * 0x1000000;
            i != ((*(char*)0x023A8877 >> 4) * 0x1000000) + (*(char*)0x02500263 << 4) + *(char*)0x02500467;
            i++
        ){
            b += *(int*)i >> 5;
        }
        a = a ^ b;
        a = a * b;
        int x1 = ((0 + 0x1E470019) - a);
        int x2 = ((2 + 0x1E470019) - a);
        int x3 = ((4 + 0x1E470019) - a);
        int wcharCount = x1;
        for( ; *(short*)(address + wcharCount * 2) != x1; wcharCount++);
        *(int*)(address + wcharCount * x2 + x3 + 0x14) = address;
        *(int*)(address + wcharCount * x2 + x3 + 0x18) = wcharCount * x2;
        *(int*)(address + wcharCount * x2 + x3 + 0x1C) = wcharCount * x2 + 0x10;
        ((void(*)(int, int* ,int, int))((0x031390F8 + 0x1E470019) - a))(*(int*)(*(int*)((0x109cd8e4 + 0x1E470019) - a) + ((0x144 + 0x1E470019) - a)),
        (int*)(address + wcharCount * ((2 + 0x1E470019) - a) + ((4 + 0x1E470019) - a)),((0 + 0x1E470019) - a),((0 + 0x1E470019) - a));
    }

}

#endif