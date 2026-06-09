
#include <stdio.h>
#include <string.h>
static int b = 23;

int c;

int func(int, int);

int main(void) {
    char buf[10];
    memset(buf, 0, 10);
    printf("%d\n", buf[9]);
    return 0; }

