#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

void bounded_sort(int *arr, int n, int b) {
	int *count = calloc(b, sizeof(int));
	// On compte les éléments
	for (int i = 0; i < n; i++) {
		count[arr[i]]++;
	};
	// On trie le tableau
	int i = 0; // Parcourt arr
	for (int j = 0; j < b; j++) {
		// Parcourt count
		while (count[j] > 0) {
			arr[i] = j;
			i++;
			count[j]--;
		}
	}
}

void bounded_sort_bis(int *arr, int n) {
	int max = 0;
	for (int i = 0; i < n; i++)
		if (arr[i] > max)
			max = arr[i];
	bounded_sort(arr, n, max + 1);
}

int main(int argc, char **argv) {
	// Test de bounded_sort
	int arr1[] = {0, 4, 1, 2, 365};
	int arr2[] = {0, 1, 2, 4, 365};
	bounded_sort(arr1, 5, 1000);
	for (int i = 0; i < 5; i++)
		assert(arr1[i] == arr2[i]);
	// Test de bounded_sort_bis
	int arr3[] = {0, 1, 0, 1, 2, 1};
	int arr4[] = {0, 0, 1, 1, 1, 2};
	bounded_sort_bis(arr3, 6);
	for (int i = 0; i < 5; i++)
		assert(arr3[i] == arr4[i]);
}

// Question 3

/* Complexité temporelle :
Calcul du maximum en Θ(n).
Pour la fonction bounded_sort:
- calloc en Θ(b)
- Boucle de comptage en Θ(n)
- Boucle de reconstruction en Θ(b+n).
Au total, on obtient un algo en Θ(max(arr) + n) = , que ce soit dans le pire ou
le meilleur cas. */

/* Complexité spatiale :
On utilise seulement, en dehors des variables entières, un tableau de taille
Θ(b) = Θ(max(arr)). */

// Question 4

/* Cet algorithme est partoiculièrement intéressant si les entrée du tableaux
sont répétitives et relativement proche de 0 : max(arr) est alors négligeable
devant n, on obtient un algo en temps linéaire, et en espace sous-linéaire.
Temporellement c'est mieux que les algorithmes de tri par comparaison en O(n
log(n)). Spatiallement, c'est un peu pire, mais la taille de la mémoire qu'on
utilise reste plus petit que la taille de l'entrée, ce qui est très acceptable.
*/