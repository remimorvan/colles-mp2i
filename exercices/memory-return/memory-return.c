#include <stdio.h>
#include <stdlib.h>

// Le code donné a un comportement indéterminé car la ligne `int p[9] = {0};`
// alloue de la mémoire sur la pile. Lorsque la fonction termine, cette zone
// mémoire n'existe donc plus : il ne faut donc surtout pas retourner un
// pointeur vers cette zone.

// Question 2

int *foo(int step) {
	int *p = calloc(9, sizeof(int)); // Mémoire allouée sur le tas.
	assert(p != NULL);
	// Calloc est similaire à malloc, mais initialise en plus la mémoire.
	// On aurait pu le remplacer par :
	// int* p = malloc(9 * sizeof(int));
	// assert(p != NULL);
	// for (int i = 0; i < 9; i++) {
	//     p[i] = 0;
	// }
	for (int i = 0; i < 9; i += step) {
		p[i] = 1;
	}
	return p;
}

int main(int argc, char *argv[]) {
	int *p = foo(2);
	printf("%d\n", p[4]);
	free(p);
	return 0;
}