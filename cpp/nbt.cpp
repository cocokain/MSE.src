struct ItemInstance;
struct CompoundTag;
struct ListTag;
struct Player;
struct Inventory;
struct Minecraft;
struct ServerLevel;
struct BlockPos;
struct BlockState;
struct BlockEntity;

void callKeyboard() {
    auto keyboardMgr = *(void**)(*(void**)(*(uintptr_t*)0x1779EC8));
    auto requestKeyboard =
        (void(*)(void*, const wchar_t*, const wchar_t*, int, int, void*, const wchar_t*, int))
        (*(uintptr_t*)((*(uintptr_t*)keyboardMgr) + 0x130));

    requestKeyboard(
        keyboardMgr,
        L"HEADER_TEXT",
        L"/nbt",
        0,
        0x3F,
        (void*)0x52B860, // callback
        L"/nbt",
        0
    );
}

void onKeyboardClosed(bool confirmed) {
    if (!confirmed) return;

    wchar_t input[0x80];
    getKeyboardText(input, 0x7F);

    splitArguments(input, L' ');

    wchar_t* cmd = getArgument(input, 1);
    if (!cmd) return;

    if (isSame(cmd, L"/nbt")) {
        handleNBT(input);
    }
    else if (isSame(cmd, L"/nick")) {
        handleNick(input);
    }
    else if (isSame(cmd, L"/gate")) {
        handleEndGateway(input);
    }
    else if (isSame(cmd, L"/panorama")) {
        handlePanorama(input);
    }
    else if (isSame(cmd, L"/shop")) {
        handleShop(input);
    }
    else if (isSame(cmd, L"/unsell")) {
        handleUnsell(input);
    }
}

void handleNBT(wchar_t* input) {
    auto mc = Minecraft::getInstance();
    auto player = mc->localPlayer;
    if (!player) return;

    ItemInstance* item = player->inventory->getSelected();
    if (!item) return;

    if (!item->hasTag()) {
        auto tag = new CompoundTag();
        item->setTag(tag);
    }

    CompoundTag* baseTag = item->getTag();

    int argIndex = 2;
    while (true) {
        wchar_t* sub = getArgument(input, argIndex++);
        if (!sub) break;

        if (isSame(sub, L"e")) addEnchantment(baseTag, input, argIndex);
        else if (isSame(sub, L"a")) addAttribute(baseTag, input, argIndex);
        else if (isSame(sub, L"p")) addEffect(baseTag, input, argIndex);
        else if (isSame(sub, L"u")) setUnbreakable(baseTag, input, argIndex);
        else if (isSame(sub, L"s")) item->setCount(64);
        else if (isSame(sub, L"h")) setHideFlag(baseTag, input, argIndex);
        else if (isSame(sub, L"d")) setDamage(item, input, argIndex);
        else break;
    }
}

void addEnchantment(CompoundTag* tag, wchar_t* input, int& i) {
    if (!tag->contains(L"ench"))
        tag->AddEnchList();

    ListTag* list = tag->getList(L"ench", 10);

    int id = _wtoi(getArgument(input, i++));
    int lvl = _wtoi(getArgument(input, i++));

    list->AddEnchTag(id, lvl);
}

void addEffect(CompoundTag* tag, wchar_t* input, int& i) {
    if (!tag->contains(L"CustomPotionEffects"))
        tag->AddCustomEffectList();

    ListTag* list = tag->getList(L"CustomPotionEffects", 10);

    int amp = _wtoi(getArgument(input, i++));
    int id  = _wtoi(getArgument(input, i++));
    int dur = _wtoi(getArgument(input, i++));

    list->AddEffectTag(amp, id, dur);
}


void handleNick(wchar_t* input) {
    wchar_t* name = getArgument(input, 2);
    if (!name) return;

    auto playerData = *(void**)(*(uintptr_t*)0x177CE40);

    memcpy((char*)playerData + 0x124, name, 0x80);
    memcpy((char*)playerData + 0x208, name, 0x80);
}

void handleEndGateway(wchar_t* input) {
    int x = _wtoi(getArgument(input, 2));
    int y = _wtoi(getArgument(input, 3));
    int z = _wtoi(getArgument(input, 4));

    bool exact = _wtoi(getArgument(input, 9)) != 0;

    BlockPos pos(x, y, z);
    auto state = Block::byId(209)->defaultBlockState();

    auto level = MinecraftServer::getInstance()->getLevel(0);
    level->setBlock(pos, state, 3, false);
    level->removeBlockEntity(pos);

    auto gateway = createEndGatewayInstance();

    CompoundTag* tag = new CompoundTag();
    gateway->save(tag);

    tag->putBoolean(L"ExactTeleport", exact);

    CompoundTag* exit = new CompoundTag();
    exit->putInt(L"X", _wtoi(getArgument(input, 5)));
    exit->putInt(L"Y", _wtoi(getArgument(input, 6)));
    exit->putInt(L"Z", _wtoi(getArgument(input, 7)));

    tag->put(L"ExitPortal", exit);

    gateway->load(tag);
    level->setBlockEntity(pos, gateway);
}

void handlePanorama(wchar_t* input) {
    auto item = getSelectedItem();
    item->setItem(Item::byId(52)); // Spawner

    auto tag = new CompoundTag();
    item->setTag(tag);

    tag->putString(L"display.Name", getArgument(input, 2));
    auto beTag = tag->AddBlockEntityTag();

    beTag->putShort(L"Delay", 0);
    beTag->putShort(L"MinSpawnDelay", 100);
    beTag->putShort(L"MaxSpawnDelay", 100);
    beTag->putShort(L"SpawnCount", 1);
    beTag->putShort(L"MaxNearbyEntities", 8);
    beTag->putShort(L"RequiredPlayerRange", 4);
    beTag->putShort(L"SpawnRange", 0);

    // SpawnData + SpawnPotentials
    // Entity = minecraft:area_effect_cloud
}
