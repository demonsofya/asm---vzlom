#ifndef PATCHER_H_INCLUDED
#define PATCHER_H_INCLUDED

//=============================================================================

#include "TXLib.h"

const int WINDOW_X_SIZE = 800;
const int WINDOW_Y_SIZE = 600;

const int BUTTON_IMG_WIDTH  = 612;
const int BUTTON_IMG_HEIGHT = 448;

const int SCREEN_WIDTH  = 1920;
const int SCREEN_HEIGHT = 1200;

const int TEXT_SIZE = 12;

//-----------------------------------------------------------------------------

HWND CreateVzlomWindow();
void DestroyVzlomWindow();

bool CheckIfButtonPressed();

//-----------------------------------------------------------------------------

struct mouse_t {
    int x_cord;
    int y_cord;
    //bool mouse_button_status;
};

//=============================================================================

#endif
