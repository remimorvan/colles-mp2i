#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

int are_mutually_visible(int *elevation, int x1, int x2);
int is_solution_valid(int *elevation, int *towers, int n);
int *build_towers_highest(int *elevation, int n);

int main(int argc, char **argv) {
	// Q1
	int elevation1[] = {0, 3, 2, 7, 4, 2, 3, 6, 1};
	assert(are_mutually_visible(elevation1, 0, 1));
	assert(!are_mutually_visible(elevation1, 0, 2));
	assert(!are_mutually_visible(elevation1, 0, 3));
	assert(!are_mutually_visible(elevation1, 2, 5));
	assert(!are_mutually_visible(elevation1, 1, 7));

	// Q2
	int towers1[] = {1, 1, 0, 1, 0, 0, 0, 1, 1};
	int towers2[] = {1, 0, 0, 1, 0, 0, 0, 1, 1};
	int towers3[] = {1, 1, 0, 1, 0, 0, 0, 0, 1};
	assert(is_solution_valid(elevation1, towers1, 9));
	assert(!is_solution_valid(elevation1, towers2, 9));
	assert(!is_solution_valid(elevation1, towers3, 9));

	// Q3
	int *towers4 = build_towers_highest(elevation1, 9);
	assert(is_solution_valid(elevation1, towers4, 9));
	int nb_towers = 0;
	for (int x = 0; x < 9; x++)
		if (towers4[x])
			nb_towers++;
	assert(nb_towers == 5);
	free(towers4);
	return 0;
}

// Question 1

int are_mutually_visible(int *elevation, int x1, int x2) {
	if (x1 == x2) {
		return 1;
	}
	for (int x = x1 + 1; x < x2; x++) {
		float slope = (elevation[x2] - elevation[x1]) / (x2 - x1);
		if ((slope * (x - x1) + elevation[x1]) < elevation[x]) {
			return 0;
		}
	}
	return 1;
}

// Question 2

int is_solution_valid(int *elevation, int *towers, int n) {
	if (!towers[0] || !towers[n - 1]) {
		return 0;
	}
	for (int x1 = 0; x1 < n; x1++) {
		if (towers[x1]) {
			int x2 = x1 + 1;
			while (x2 < n && !towers[x2])
				x2++;
			// x2 is the tower following x1
			if (towers[x2] && !are_mutually_visible(elevation, x1, x2))
				return 0;
		}
	}
	return 1;
}

// Question 3b

void build_towers_highest_aux(int *elevation, int *towers, int n, int a,
							  int z) {
	assert(a <= z);
	if (are_mutually_visible(elevation, a, z))
		return;
	// On détermine le point M
	int max = a + 1;
	for (int x = a + 1; x < z; x++) {
		if (elevation[x] > elevation[max])
			max = x;
	}
	towers[max] = 1;
	build_towers_highest_aux(elevation, towers, n, a, max);
	build_towers_highest_aux(elevation, towers, n, max, z);
}

int *build_towers_highest(int *elevation, int n) {
	assert(n >= 0);
	int *towers = calloc(n, sizeof(int));
	assert(towers != NULL);
	towers[0] = towers[n - 1] = 1;
	build_towers_highest_aux(elevation, towers, n, 0, n - 1);
	return towers;
}

// Question 3c
/* La fonction build_towers_highest_aux est en Theta(n)
	+ deux appels récursifs sur des tableaux dont la SOMME vaut n
	=> relation de type T(n) = 2*T(n/2) + Theta(n)
	complexité en Theta(n*log(n)). */

// Question 3d
/* Sur le profil topographique {0,2,0,0,0,0,0,0,8,10}
l'algorithme va mettre des tours en x=0, en x=9 (extrémité) puis en
x=8 (les tours ne se voient pas + x=8 a l'altitude maximale).
Ensuite les tours 0 et 8 ne se verront toujours pas, et il faudra rajouter
une tour en x=1. => On obtient 4 tours.
La solution optimale est de placer des tours en x=0, x=1 et x=9. */
