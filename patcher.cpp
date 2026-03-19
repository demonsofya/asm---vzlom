#include "TXLib.h"
#include "patcher.h"

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>


HWND CreateVzlomWindow() {

    HWND NewVzlomWindow = txCreateWindow(BUTTON_IMG_WIDTH, BUTTON_IMG_HEIGHT, true);

    txSetColor(TX_BLACK);
    txSetFillColor(TX_WHITE);
    txSelectFont("Comic Sans MS", TEXT_SIZE);

    txBitBlt(0, 0, button_image);
    txPlaySound("ringtone.wav", SND_ASYNC);

    return NewVzlomWindow;
}

bool CheckIfButtonPressed() {

    mouse_t mouse = {};

    while (true) {
        if (txMouseButtons() & LEFT_MOUSE_BUTTON_CODE) {         // ëåâàÿ êíîïêà ìûøè
            mouse.x_cord = txMouseX();
            mouse.y_cord = txMouseY();

            if (mouse.x_cord > BUTTON_IMG_WIDTH*0.25    && mouse.x_cord < BUTTON_IMG_WIDTH*0.75 && 
                mouse.y_cord > BUTTON_IMG_HEIGHT*0.35   && mouse.y_cord < BUTTON_IMG_HEIGHT*0.8) {
                
                txBitBlt(0, 0, pressed_button_image);
                txTextOut(200, 0, "ÈÄÅÒ ÂÇËÎÌ ÆÎÏÛ...",  txDC());
                txPlaySound("murder_in_my_mind.wav", SND_ASYNC);

                return true;
            }

            txTextOut(250, 0, "ÂÇËÎÌ ÎÒÌÅÍÀ",  txDC());
            return false;
        }
    }

    return false;
}

bool CreateAnimationOnWindow() {
    
    while(!txMouseButtons()) {

        ChangeTexColorAndSleep(TX_BLUE);
        ChangeTexColorAndSleep(TX_RED);
    }

    txPlaySound(NULL, SND_ASYNC);
    return true;
}

void ChangeTexColorAndSleep(int color) {

    txSetColor(color);
    txTextOut(200, 0, "ÈÄÅÒ ÂÇËÎÌ ÆÎÏÛ...",  txDC());
    txSleep(100);
}









