#include <stdio.h>
#include <stdlib.h>

// int* foo(int step) {
//     int p[9] = {0};
//     for (int i = 0; i < 9; i += step) {
//         p[i] = 1;
//     }
//     return p;
// }

// int main(int argc, char** argv) {
//     int* p = foo(2);
//     printf("%d\n", p[4]);
//     return 0;
// }

int* foo(int step) {
    int* p = (int*)calloc(9, sizeof(int));
    for (int i = 0; i < 9; i += step) {
        p[i] = 1;
    }
    return p;
}

int main(int argc, char** argv) {
    int* p = foo(2);
    printf("%d\n", p[4]);
    free(p);
    return 0;
}