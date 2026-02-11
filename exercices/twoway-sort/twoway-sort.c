#include <assert.h>
#include <stdio.h>

void swap(int arr[], int i, int j) {
	int temp = arr[i];
	arr[i] = arr[j];
	arr[j] = temp;
}

void twoway_sort(int arr[], int n) {
	int i = 0, j = n;
	// Invariant : i ≤ j
	// tous les élements entre 0 (inclus) et i (exclus) sont égaux à 0,
	// ceux entre i (inclus) et j (exclus) sont ceux à examiner,
	// tous les élements entre j (inclus) et n (exclus) sont égaux à 1.
	// En dessin :
	//  0           i                           j           n
	// -----------------------------------------------------
	// | 0 | 0 | 0 | ? | ? | ? | ? | … | ? | ? | 1 | 1 | 1 |
	// -----------------------------------------------------
	while (i < j) {
		if (arr[i] == 1) {
			swap(arr, i, j - 1);
			j--;
			// En fait on pourrait écrire swap(arr, i, --j);
			// Attention : c'est bien --j et pas j-- car on veut
			// décrémenter k avant de retourner sa nouvelle valeur
		} else {
			i++;
		}
	}
}

void dutch_flag(int arr[], int n) {
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
			swap(arr, j, i);
			i++;
			j++;
			// Ou : swap(arr, j++, i++);
			break;
		case 2:
			swap(arr, j, k - 1);
			k--;
			// Ou : swap(arr, j, --k)
			// Attention : c'est bien --k et pas k-- car on veut
			// décrémenter k avant de retourner sa nouvelle valeur
			break;
		default:
			j++;
		}
	}
}

int main(int argc, char *argv[]) {
	int arr1[2] = {1, 0};
	twoway_sort(arr1, 2);
	assert(arr1[0] == 0);
	assert(arr1[1] == 1);
	int arr2[] = {1, 2, 0, 1, 1, 2, 2, 2, 2, 1, 1, 2, 0, 0, 1};
	dutch_flag(arr2, 15);
	for (int i = 0; i < 15 - 1; i++) {
		assert(arr2[i] <= arr2[i + 1]);
	}
	assert(arr2[0] == 0);
	assert(arr2[2] == 0);
	assert(arr2[3] == 1);
	assert(arr2[8] == 1);
	assert(arr2[9] == 2);
	assert(arr2[14] == 2);
	return 0;
}