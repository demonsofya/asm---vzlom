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

    CrackFile(file_to_crack);
    return 0;
}