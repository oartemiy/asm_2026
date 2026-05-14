#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

union Foo {
    float a;
    unsigned c;
};

int main(void) {
    union Foo w;
    w.a = -0.0;
    printf("%u\n", w.c);
    return 0;
}