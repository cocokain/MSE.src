#include <string>

using namespace std;

// ---- 元関数ポインタ ----
typedef std::wstring (*Wchar2Wstring_t)(const wchar_t*, std::wstring&);
typedef void (*DisplayString_t)(const std::wstring&, int, int, int, int, float);
typedef void (*WstringDestructor_t)(std::wstring*);

// ---- アドレス ----
static Wchar2Wstring_t      Wchar2Wstring      = (Wchar2Wstring_t)0x521340;
static DisplayString_t      displayString      = (DisplayString_t)0x521530;
static WstringDestructor_t  destroyWstring     = (WstringDestructor_t)0x9C9AA8;


// =================================================
// 0x52A950
// =================================================
void DrawKeyOverlay()
{
    std::wstring temp;

    //
    // ========================
    // WASD
    // ========================
    Wchar2Wstring((const wchar_t*)0x1870900, temp);

    displayString(
        temp,
        0x155,
        0x19,
        0xF0FFFFFF,
        2,
        5.5f
    );

    destroyWstring(&temp);



    //
    // ========================
    // W
    // ========================
    Wchar2Wstring((const wchar_t*)0x187093C, temp);

    displayString(
        temp,
        0x13E,
        0x9,
        0xF0FFFFFF,
        0,
        5.5f
    );

    destroyWstring(&temp);



    //
    // ========================
    // LMB
    // ========================
    Wchar2Wstring((const wchar_t*)0x1870944, temp);

    displayString(
        temp,
        0x14B,
        0x2E,
        0xF0FFFFFF,
        0,
        5.0f
    );

    destroyWstring(&temp);



    //
    // ========================
    // RMB
    // ========================
    Wchar2Wstring((const wchar_t*)0x1870954, temp);

    displayString(
        temp,
        0x16E,
        0x2E,
        0xF0FFFFFF,
        1,
        5.0f
    );

    destroyWstring(&temp);
}
