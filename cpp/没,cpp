#include <string>

// 外部関数（実際はゲーム/アプリ内部の関数）
extern std::wstring Wchar2Wstring(const wchar_t* src, void* temp);
extern void displayString(const std::wstring& text, int x, int y,
                          int textcolor, int textalign, float scale);

extern "C" void LunarSEver() {
    // 文字列の実体がメモリ上にあると仮定
    const wchar_t* src = reinterpret_cast<const wchar_t*>(0x1870420);
    void* tempBuffer   = reinterpret_cast<void*>(0x1870F00);

    // wchar_t* → std::wstring に変換
    std::wstring text = Wchar2Wstring(src, tempBuffer);

    // 文字列を画面に表示
    displayString(text,
                  480,         // X座標
                  261,         // Y座標
                  0xF0FFFFFF,  // 色（ARGBかRGBA）
                  2,           // テキスト配置（中央揃え？）
                  4.0f);       // スケール

    // text はスコープを抜けると自動的にデストラクタ呼び出し
}
