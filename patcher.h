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

const int TEXT_SIZE = 24;

const HDC button_image          = txLoadImage("button.bmp");
const HDC pressed_button_image  = txLoadImage("button_pressed.bmp");

//-----------------------------------------------------------------------------

HWND CreateVzlomWindow();
void DestroyAkinatorWindow();

bool CheckIfButtonPressed();
bool CreateAnimationOnWindow();
void ChangeTexColorAndSleep(int color);

//-----------------------------------------------------------------------------

struct mouse_t {
    double x_cord;
    double y_cord;
    //bool mouse_button_status;
};

//=============================================================================

#endif
