#include "TXLib.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#include "patcher.h"

int main(int argc, char *argv[]) {

    HWND VzlomWindow = CreateVzlomWindow();

    int commands_count = 0;

    FILE *file_to_crack = NULL;

    if (argc > 1)
        file_to_crack = fopen(argv[1], "rb+");
    else
        file_to_crack = fopen(DEFAULT_CRACK_FILE_NAME, "rb+");

    assert(file_to_crack);

    if (CheckIfButtonPressed()) { 
        fseek(file_to_crack, COMPARE_CYCLE_BEGIN, SEEK_SET);

        for (int i = 0; i <= COMPARE_CYCLE_END - COMPARE_CYCLE_BEGIN; i++)
            fprintf(file_to_crack, "%c", NOP_COMMAND);

        fclose(file_to_crack);
        
        txSleep(MUSIC_INTRO_TIME);
        CreateAnimationOnWindow();
    }
    return 0;
}