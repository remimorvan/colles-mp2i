#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

void remove_multiples(int *arr, int n, int k);
int *sieve_eratosthenes(int m);

int main(int argc, char **argv) {
	int arr[10] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
	remove_multiples(arr, 10, 3);
	for (int i = 0; i < 10; i++) {
		if (i % 3 == 0 && i > 3) {
			assert(arr[i] == 0);
		} else {
			assert(arr[i] == 1);
		}
	}
	int *is_prime = sieve_eratosthenes(64);
	assert(is_prime[2] && is_prime[17] && is_prime[31]);
	assert(!is_prime[0] && !is_prime[1] && !is_prime[6] && !is_prime[57]);
	free(is_prime);

	return 0;
}

void remove_multiples(int *arr, int n, int k) {
	for (int i = 2 * k; i < n; i += k) {
		arr[i] = 0;
	}
	/* Complexité temporelle de remove_multiples :
	Theta(n/k) dans tous les cas. */
}

int *sieve_eratosthenes(int m) {
	int *is_prime = malloc(m * sizeof(int));
	assert(is_prime != NULL);
	is_prime[0] = is_prime[1] = 0;
	for (int i = 2; i < m; i++)
		is_prime[i] = 1;
	int p = 2;
	while (p * p < m) {
		if (is_prime[p]) {
			remove_multiples(is_prime, m, p);
		}
		p++;
	}
	return is_prime;
	/* Complexité de sieve_eratosthenes :
	Theta(m) (création de la liste)
	À chaque étape de la boucle:
		Theta(m/p) si p est premier
		Theta(1) sinon.
	Au total on obtient un algo en
	Theta(m + m/2 + m/3 + … + m/p(m)) où p(m) est le
	plus grand nombre premier ≤ sqrt(m).
	Si on veut une borne sup plus facile à exprimer :
	O(m*'nb. de nombres premiers < sqrt(m)'). */
}
