#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

int binom_naive(int k, int n);
void print_sierpinski_naive(int n);
int *binom_list(int n, int *coefs_prec);
void print_sierpinski(int n);

int main(int argc, char *argv[]) {
	assert(binom_naive(3, 6) == 20);
	assert(binom_naive(10, 10) == 1);
	assert(binom_naive(0, 7) == 1);
	assert(binom_naive(2, 9) == 9 * 8 / 2);
	// print_sierpinski_naive(15);
	int binom3[] = {1, 3, 3, 1};
	int *binom4 = binom_list(4, binom3);
	assert(binom4[0] == 1);
	assert(binom4[1] == 4);
	assert(binom4[2] == 6);
	assert(binom4[3] == 4);
	assert(binom4[4] == 1);
	assert(argc == 2);
	print_sierpinski(atoi(argv[1]));
	return 0;
}

int binom_naive(int k, int n) {
	// Returns 'n choose k'.
	assert(n >= 0);
	assert(k >= 0 && k <= n);
	if (k == 0 || k == n) {
		return 1;
	}
	return binom_naive(k - 1, n - 1) + binom_naive(k, n - 1);
}

/* Terminaison : on choisit comme variant le second paramètre ('n').
Il est bien toujours positif ('assert(n >= 0);').
Par ailleurs, à chaque appel récursif, il décroit strictement (il vaut n-1).
Donc l'algorithme termine. */

/* Borne supérieure sur la complexité temporelle de binom_naive(int k, int n):
on fait au plus deux appels récursifs, dans lesquels le second paramètre vaut
n-1. Ainsi, on obtient une borne supérieure en 2^n. */

void print_sierpinski_naive(int n) {
	assert(n >= 0);
	for (int m = 0; m <= n; m++) {
		for (int k = 0; k <= m; k++)
			printf("%s", binom_naive(k, m) % 2 ? "■" : " ");
		printf("\n");
	}
}

int *binom_list(int n, int *coefs_prec) {
	/* Inputs: an integer n, and the array of 'n-1 choose k' for k between 0 and
	n-1 (inclusive). When n=0, we assume that the array given as input is
	ingnored (and can be NULL). Output: The array of 'n choose k' for all k
	between 0 and n (inclusive). */
	assert(n >= 0);
	int *coefs = calloc(n + 1, sizeof(int));
	assert(coefs != NULL);
	coefs[0] = coefs[n] = 1;
	if (n == 0) {
		return coefs;
	}
	assert(coefs_prec != NULL);
	for (int k = 1; k < n; k++) {
		coefs[k] = coefs_prec[k - 1] + coefs_prec[k];
	}
	return coefs;
}

/* Borne supérieure sur la complexité temporelle de binom_list(int n, int
*coefs_prec) : le calcul de coefs[k] se fait en temps constant, donc au total on
obtient une complexité linéaire en n. */

void print_sierpinski(int n) {
	assert(n >= 0);
	int *coefs_prec = NULL;
	int *coefs = NULL;
	for (int m = 0; m <= n; m++) {
		free(coefs_prec);
		coefs_prec = coefs;				   // Coefficients m-1 choose k
		coefs = binom_list(m, coefs_prec); // Coefficients m choose k
		for (int k = 0; k < n - m; k++)
			printf(" ");
		for (int k = 0; k <= m; k++)
			printf("%s", coefs[k] % 2 ? "■ " : "  ");
		printf("\n");
	}
	free(coefs);
}