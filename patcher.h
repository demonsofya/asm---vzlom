#ifndef PATCHER_H_INCLUDED
#define PATCHER_H_INCLUDED

//=============================================================================

#include "TXLib.h"

const int WINDOW_X_SIZE             = 800;
const int WINDOW_Y_SIZE             = 600;

const int BUTTON_IMG_WIDTH          = 612;
const int BUTTON_IMG_HEIGHT         = 448;

const int SCREEN_WIDTH              = 1920;
const int SCREEN_HEIGHT             = 1200;

const int TEXT_SIZE                 = 24;

const HDC button_image              = txLoadImage("button.bmp");
const HDC pressed_button_image      = txLoadImage("button_pressed.bmp");

const int LEFT_MOUSE_BUTTON_CODE    = 0b01;

const int MUSIC_INTRO_TIME          = 17000;

//-----------------------------------------------------------------------------

const char * const DEFAULT_CRACK_FILE_NAME = "CRACKF_1.COM";

const int COMPARE_CYCLE_BEGIN = 0x4a;
const int COMPARE_CYCLE_END   = 0x51;
const int NOP_COMMAND         = 0x90;

//-----------------------------------------------------------------------------

HWND CreateVzlomWindow();

bool CheckIfButtonPressed();
bool CreateAnimationOnWindow();
void ChangeTexColorAndSleep(int color);

int CrackFile(FILE *file_to_crack);

//-----------------------------------------------------------------------------

struct mouse_t {
    double x_cord;
    double y_cord;
    //bool mouse_button_status;
};

//=============================================================================

#endif
