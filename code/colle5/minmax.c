#include <stdio.h>
#include <stdlib.h>

void min_max(int l, int t[], int* min, int* max) {
    *min = *max = t[0];
    /* for (int i = 0; i < l; i = i+1) {
      if (*(t+i) < *min) *min = *(t+i);
      if (*(t+i) > *max) *max = *(t+i);
    } */
    while (l > 0) {
        if (*t < *min) *min = *t;
        if (*t > *max) *max = *t;
        t = t + 1;
        l = l - 1;
    }
}

int main(int argc, char* argv[]) {
    int arr[] = {10, 5, 4, 8, 7, -12, 18, 3, 4};
    int arr_len = 9;
    int min = 0;
    int max = 0;
    min_max(arr_len, arr, &min, &max);
    printf("%d %d\n", min, max);
    return 0;
}
