void DrawStickOverlay()
{
    auto cache = (float*)0x180007C;

    float LX = cache[0];
    float LX_MIN = -0.125f;
    float LY = cache[2];
    float LY_MAX = 0.125f;

    cache[1] = LX_MIN;
    cache[3] = LY_MAX;

    int baseX = 0x19A;
    int baseY = 0x90;

    int size = 0x45;
    int offset = 6;

    baseX -= offset;
    baseX -= baseY;
    baseX -= (size << 1);

    //
    // ===== Dキー =====
    //
    if (LX <= LY_MAX)
    {
        display2DBox(
            baseX + size + offset,
            baseY + size + offset,
            size,
            size,
            0x00000000,
            0x6F
        );
    }

    if (LX > LY_MAX)
    {
        display2DBox(
            baseX + size + offset,
            baseY + size + offset,
            size,
            size,
            0x6F6F6F6F,
            0x6F
        );
    }

    //
    // ===== Aキー =====
    //
    if (LX >= LX_MIN)
    {
        display2DBox(
            baseX - (size + offset),
            baseY + size + offset,
            size,
            size,
            0x00000000,
            0x6F
        );
    }

    if (LX < LX_MIN)
    {
        display2DBox(
            baseX - (size + offset),
            baseY + size + offset,
            size,
            size,
            0x6F6F6F6F,
            0x6F
        );
    }

    //
    // ===== Wキー =====
    //
    if (LY <= LY_MAX)
    {
        display2DBox(
            baseX,
            baseY,
            size,
            size,
            0x00000000,
            0x6F
        );
    }

    if (LY > LY_MAX)
    {
        display2DBox(
            baseX,
            baseY,
            size,
            size,
            0x6F6F6F6F,
            0x6F
        );
    }

    //
    // ===== Sキー =====
    //
    if (LY >= LX_MIN)
    {
        display2DBox(
            baseX,
            baseY + size + offset,
            size,
            size,
            0x00000000,
            0x6F
        );
    }

    if (LY < LX_MIN)
    {
        display2DBox(
            baseX,
            baseY + size + offset,
            size,
            size,
            0x6F6F6F6F,
            0x6F
        );
    }

    //
    // ===== ZR =====
    //
    if (IsButtonPressed(0x22))
    {
        display2DBox(..., 0x6F6F6F6F, 0x6F);
    }
    else
    {
        display2DBox(..., 0x0, 0x6F);
    }

    //
    // ===== ZL =====
    //
    if (IsButtonPressed(0x21))
    {
        display2DBox(..., 0x6F6F6F6F, 0x6F);
    }
    else
    {
        display2DBox(..., 0x0, 0x6F);
    }
}
