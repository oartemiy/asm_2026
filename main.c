
// #include <stdio.h>
#include <stdio.h>
#include <string.h>
int a;
static int b = 23;

int c;

int func(int, int);

int main(void) {
    // printf("%u\n", sizeof(double));
    FILE* fin = fopen("input.bin", "rb");
    fread(&a, sizeof(a), 1, fin);

    fclose(fin);
    return 0;
}