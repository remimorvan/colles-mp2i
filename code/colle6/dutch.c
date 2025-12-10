#include <assert.h>
#include <stdio.h>

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void dutch_flag(int* arr, int n) {
    int i = 0, j = 0, k = n;
    // Invariant : i ≤ j ≤ k
    // tous les élements entre 0 (inclus) et i (exclus) sont égaux à 0,
    // tous les élements entre i (inclus) et j (exclus) sont égaux à 1,
    // ceux entre j (inclus) et k (exclus) sont ceux à examiner,
    // tous les élements entre k (inclus) et n (exclus) sont égaux à 2.
    // En dessin :
    //  0           i       j                   k           n
    // -----------------------------------------------------
    // | 0 | 0 | 0 | 1 | 1 | ? | ? | … | ? | ? | 2 | 2 | 2 |
    // -----------------------------------------------------
    while (j < k) {
        switch (arr[j]) {
            case 0:
                swap(arr + j, arr + i);
                // `arr + j` est l'adresse mémoire de la j-ème case du tableau arr
                // c'est équivalent à `&(arr[k])`.
                i++;
                j++;
                break;
            case 2:
                swap(arr + j, arr + k - 1);
                k--;
                break;
            default:
                j++;
        }
    }
}

int main(int argc, char** argv) {
    int arr[] = {1, 2, 0, 1, 1, 2, 2, 2, 2, 1, 1, 2, 0, 0, 1};
    dutch_flag(arr, 15);
    for (int i = 0; i < 15 - 1; i++) {
        assert(arr[i] <= arr[i + 1]);
    }
    assert(arr[0] == 0);
    assert(arr[2] == 0);
    assert(arr[3] == 1);
    assert(arr[8] == 1);
    assert(arr[9] == 2);
    assert(arr[14] == 2);
    return 0;
}