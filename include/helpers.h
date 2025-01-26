#include <nds.h>
#include <stdio.h>

void iputs(const char* str) {
        iprintf("%s", str);
}

bool isTouching() {
        return keysHeld() & KEY_TOUCH;
}

int getTouchX() {
        touchPosition position;
        touchRead(&position);
        return position.px;
}

int getTouchY() {
        touchPosition position;
        touchRead(&position);
        return position.py;
}


u16* oamMainGraphics;

void oamMainInit() {
        int i;

        videoSetMode(MODE_0_2D);
        vramSetBankA(VRAM_A_MAIN_SPRITE);
        oamInit(&oamMain, SpriteMapping_1D_32, false);
        oamMainGraphics = oamAllocateGfx(&oamMain, SpriteSize_16x16,
                                         SpriteColorFormat_256Color);

        for(i = 0; i < 16 * 16 / 2; i++) {
                oamMainGraphics[i] = 257;
        }
}

void oamMainSet(int x, int y) {
        oamSet(&oamMain, 0, x, y, 0, 0, SpriteSize_16x16,
               SpriteColorFormat_256Color, oamMainGraphics, -1, false, false,
               false, false, false);
}

void oamMainColor(int r, int g, int b) {
        SPRITE_PALETTE[1] = RGB15(r, g, b);
}

void oamMainUpdate() {
        oamUpdate(&oamMain);
}
