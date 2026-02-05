#pragma once
#include <cstdint>

// ==================================================
// 基本型
// ==================================================
using u8  = uint8_t;
using u16 = uint16_t;
using u32 = uint32_t;
using u64 = uint64_t;
using f32 = float;

// ==================================================
// 入力キャッシュ（解析済）
// ==================================================
struct StickCache {
    float lx;      // +0x0
    float lx_min;  // +0x4
    float ly;      // +0x8
    float ly_max;  // +0xC
};

static StickCache* gStick =
    (StickCache*)0x180007C;

// ==================================================
// CInput（フック元）
// ==================================================
class CInput {
public:
    static float GetJoypadStick_LX(int pad, bool raw);
    static float GetJoypadStick_LY(int pad, bool raw);
};

// ==================================================
// HUD / UI
// ==================================================
namespace UI {

    // 0x521620
    using display2DBox_t = void(*)(
        int x,
        int y,
        int sx,
        int sy,
        int color,
        int opacity
    );

    static inline display2DBox_t display2DBox =
        (display2DBox_t)0x521620;
}

// ==================================================
// Minecraft Core
// ==================================================
class Minecraft {
public:
    static inline Minecraft* GetInstance() {
        return ((Minecraft*(*)())0x67DB90)();
    }
};

// ==================================================
// InputHandler（vtable）
// ==================================================
class InputHandler {
public:
    virtual bool isPressed(int buttonId, int unk);
};

static inline InputHandler* GetInputHandler() {
    return **(InputHandler***)(0x1779000 + 0xEC8);
}

// ==================================================
// ボタンID
// ==================================================
enum ButtonID {
    BUTTON_ZL = 0x21,
    BUTTON_ZR = 0x22
};

// ==================================================
// HUD 定数（解析値）
// ==================================================
namespace HUD {

    // スティック判定
    constexpr float DEADZONE_MIN = -0.125f;
    constexpr float DEADZONE_MAX =  0.125f;

    // レイアウト
    constexpr int BASE_X   = 0x19A;
    constexpr int BASE_Y   = 0x90;
    constexpr int KEY_SIZE = 0x45;
    constexpr int KEY_PAD  = 6;

    // 描画
    constexpr int COLOR_OFF = 0x00000000;
    constexpr int COLOR_ON  = 0x6F6F6F6F;
    constexpr int OPACITY   = 0x6F;
}

// ==================================================
// フック関数（GetStick）
// ==================================================
static inline float Hook_GetLX(float s0, float s1) {
    float v = s0 * s1;
    gStick->lx = v;
    return v;
}

static inline float Hook_GetLY(float s0, float s1) {
    float v = s0 * s1;
    gStick->ly = v;
    return v;
}

// ==================================================
// HUD 描画補助
// ==================================================
static inline void DrawKeyBox(
    int x,
    int y,
    bool pressed
) {
    UI::display2DBox(
        x,
        y,
        HUD::KEY_SIZE,
        HUD::KEY_SIZE,
        pressed ? HUD::COLOR_ON : HUD::COLOR_OFF,
        HUD::OPACITY
    );
}

// ==================================================
// WASD + ZL/ZR HUD 描画（解析一致）
// ==================================================
static inline void DrawInputHUD() {

    // 閾値保存（元asm通り）
    gStick->lx_min = HUD::DEADZONE_MIN;
    gStick->ly_max = HUD::DEADZONE_MAX;

    int baseX = HUD::BASE_X;
    int baseY = HUD::BASE_Y;

    int size  = HUD::KEY_SIZE;
    int pad   = HUD::KEY_PAD;

    // asm の SUB 群再現
    baseX -= pad;
    baseX -= baseY;
    baseX -= (size << 1);

    float lx = gStick->lx;
    float ly = gStick->ly;

    // D
    DrawKeyBox(
        baseX + size + pad,
        baseY + size + pad,
        lx > HUD::DEADZONE_MAX
    );

    // A
    DrawKeyBox(
        baseX - (size + pad),
        baseY + size + pad,
        lx < HUD::DEADZONE_MIN
    );

    // W
    DrawKeyBox(
        baseX,
        baseY,
        ly > HUD::DEADZONE_MAX
    );

    // S
    DrawKeyBox(
        baseX,
        baseY + size + pad,
        ly < HUD::DEADZONE_MIN
    );

    // ZR
    bool zr = GetInputHandler()->isPressed(BUTTON_ZR, 0);
    UI::display2DBox(
        baseX + (size >> 1) + (pad >> 1),
        baseY + ((size + pad) << 1),
        size,
        size,
        zr ? HUD::COLOR_ON : HUD::COLOR_OFF,
        HUD::OPACITY
    );

    // ZL
    bool zl = GetInputHandler()->isPressed(BUTTON_ZL, 0);
    UI::display2DBox(
        baseX - (size + pad),
        baseY + ((size + pad) << 1),
        size,
        size,
        zl ? HUD::COLOR_ON : HUD::COLOR_OFF,
        HUD::OPACITY
    );
}
