#include "TXLib.h"

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#include "patcher.h"

HWND VzlomWindow = CreateVzlomWindow();

HWND CreateVzlomWindow() {

    HWND NewVzlomWindow = txCreateWindow(WINDOW_X_SIZE, WINDOW_Y_SIZE, true);

    //txSetColor(TX_BROWN);
    //txSelectFont("Comic Sans MS", TEXT_SIZE);

    HDC button_image = txLoadImage("button.bmp");

    //txBitBlt(txDC(), WINDOW_X_SIZE - BUTTON_IMG_WIDTH/2, WINDOW_Y_SIZE - BUTTON_IMG_HEIGHT, 0, 0, button_image);

    txBitBlt ( 0, 0, button_image);

    return NewVzlomWindow;
}

bool CheckIfButtonPressed() {

    mouse_t mouse = {};

    while (true) {
        if (txMouseButtons() & 2) {         // левая кнопка мыши
            mouse.x_cord = txMouseX();
            mouse.y_cord = txMouseY();

            if (true)
                return true;

            return false;
        }
    }

    return false;
}









