#include <assert.h>
#include <stdio.h>
#include <stdlib.h>


const char *DEFAULT_CRACK_FILE_NAME = "CRACKF_1.COM";

const int COMPARE_CYCLE_BEGIN = 0x4a;
const int COMPARE_CYCLE_END   = 0x51;
const int NOP_COMMAND         = 0x90;


int main(int argc, char *argv[]) {

    int commands_count = 0;
    int *output_arr = NULL;

    FILE *file_to_crack = NULL;

    if (argc > 1)
        file_to_crack = fopen(argv[1], "rb+");
    else
        file_to_crack = fopen(DEFAULT_CRACK_FILE_NAME, "rb+");

    assert(file_to_crack);

    fseek(file_to_crack, COMPARE_CYCLE_BEGIN, SEEK_SET);

    for (int i = 0; i <= COMPARE_CYCLE_END - COMPARE_CYCLE_BEGIN; i++)
        fprintf(file_to_crack, "%c", NOP_COMMAND);

    fclose(file_to_crack);
    return 0;
}
