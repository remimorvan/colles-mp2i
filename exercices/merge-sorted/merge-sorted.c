#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

int *merge_sorted(int arr1[], int n1, int arr2[], int n2) {
	int *merged = calloc(n1 + n2, sizeof(int));
	assert(merged != NULL);
	int i1 = 0, i2 = 0;
	while (i1 + i2 < n1 + n2) {
		// Il faut faire attention à ne pas accéder
		// à arr1[i1] lorsque i1 = n1 ou à arr2[i2] lorsque i2 = n2
		// On utilise avantageusement l'évalution paresseuse pour ce faire.
		if (i2 == n2 || (i1 < n1 && arr1[i1] < arr2[i2])) {
			merged[i1 + i2] = arr1[i1];
			i1++;
		} else {
			merged[i1 + i2] = arr2[i2];
			i2++;
		}
	}
	return merged;
}

int main(int argc, char *argv[]) {
	int arr1[] = {2, 3, 5, 7, 11, 13, 17};
	int arr2[] = {0, 1, 4, 6, 8, 9, 10, 12, 14, 15, 16};
	int *merged12 = merge_sorted(arr1, 7, arr2, 11);
	for (int i = 0; i < 18; i++) {
		assert(merged12[i] == i);
	}
	free(merged12);
	int arr3[] = {};
	int arr4[] = {-42};
	int *merged34 = merge_sorted(arr3, 0, arr4, 1);
	assert(merged34[0] == -42);
	free(merged34);
	int *merged43 = merge_sorted(arr4, 1, arr3, 0);
	assert(merged43[0] == -42);
	free(merged43);
	return 0;
}
