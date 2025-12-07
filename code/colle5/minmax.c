#include <assert.h>
#include <stdio.h>

void min_max(int l, int t[], int* min, int* max) {
    *min = *max = t[0];
    for (int i = 0; i < l; i++) {
        if (t[i] < *min) {
            *min = t[i];
        }
        if (t[i] > *max) {
            *max = t[i];
        }
    }
}

int main(int argc, char* argv[]) {
    int arr[] = {10, 5, 4, 8, 7, -12, 18, 3, 4};
    int arr_len = 9;
    int min = 0;
    int max = 0;
    min_max(arr_len, arr, &min, &max);
    assert(min == -12 && max == 18);
    return 0;
}
