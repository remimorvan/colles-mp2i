#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

// Question 1

// 10 = 8 + 2
// 20 = 13 + 5 + 2
// 30 = 21 + 8 + 1

// Question 2

// Pour calculer l'écriture de Fibonacci de n,
// on commence cherche le plus grand k tel que f_k <= n : il fera partie de
// l'écriture de Fibonacci de n, et on applique ensuite la procédure
// récursivement à n - f_k.

#define elt_type int
#define elt_spec "%d"
#define default_val -1

typedef struct resizable_array {
	int size;
	elt_type *values;
} resizable_array;

resizable_array *rar_create() {
	resizable_array *rar = malloc(sizeof(resizable_array));
	assert(rar != NULL);
	rar->size = 0;
	rar->values = malloc(0);
	assert(rar->values != NULL);
	return rar;
}

int rar_is_empty(resizable_array *rar) { return rar->size == 0; }

int rar_get_size(resizable_array *rar) { return rar->size; }

elt_type rar_get_elem(resizable_array *rar, int i) {
	assert(i >= 0);
	if (i < rar->size) {
		return rar->values[i];
	}
	return default_val;
}

void rar_set_elem(resizable_array *rar, int i, elt_type x) {
	assert(i >= 0);
	if (i >= rar->size) {
		// We create a new raray of twice the original size (or of size i+1 if
		// this is bigger)
		elt_type *old_values = rar->values;
		int old_size = rar->size;
		rar->size = i < 2 * rar->size ? 2 * rar->size : i + 1;
		rar->values = malloc(rar->size * sizeof(elt_type));
		for (int j = 0; j < old_size; j++)
			rar->values[j] = old_values[j];
		for (int j = old_size; j < rar->size; j++)
			rar->values[j] = default_val;
		free(old_values);
	}
	rar->values[i] = x;
}

void rar_print(resizable_array *rar) {
	for (int i = 0; i < rar->size; i++) {
		elt_type val = rar_get_elem(rar, i);
		if (val == default_val)
			printf("? ");
		else {
			printf(elt_spec, val);
			printf(" ");
		}
	}
	printf("\n");
}

void rar_free(resizable_array *rar) {
	free(rar->values);
	free(rar);
}

resizable_array *fib_values; // global variable

int fib(int n) {
	if (rar_get_elem(fib_values, n) == default_val) {
		int val;
		if (n >= 2)
			val = fib(n - 2) + fib(n - 1);
		else if (n == 1)
			val = 2;
		else
			val = 1;
		rar_set_elem(fib_values, n, val);
		return val;
	}
	return rar_get_elem(fib_values, n);
}

/* Complexité de fib(int n); si on connaît déjà les
valeurs i < n :
- si on a pas besoin de resize fib_values, temps constant (on fait l'addition
de deux valeurs qu'on va chercher dans un tableau)
- sinon, temps linéaire en n (pour créer le novueau fib_values->values). */

/* Complexité de for (int i = 0; i < n; i++) { fib(i); } :
 - les étapes 1, 2, 4, 8, ..., 2^(floor(log(n))) nécessitent de resize le
 tableau et sont en temps linéaire en k
 - les autres étapes sont en temps constant.
 On obtient un algo en O((1 + 2 + ... + 2^(floor(log(n)))) + (n - log(n))),
 et donc en O(n). La mémoïzation, c'est super. */

int int_of_zeck_repr(int *repr) {
	int res = 0;
	int i = 0;
	while (repr[i] != default_val) {
		assert(repr[i] == 0 || repr[i] == 1);
		res += repr[i] * fib(i);
		i++;
	}
	return res;
}

int *zeck_repr_of_int(int n) {
	// Compute s = 2 + max{k | fib(k) <= n};
	int s = 0;
	while (fib(s) <= n) {
		s++;
	}
	s += 2;
	// Create array {0,0,...,0,-1} of size s;
	int *res = calloc(s, sizeof(int));
	res[s - 1] = default_val;
	// Compute Fibonacci representation
	while (n > 0) {
		int k = 0;
		while (fib(k) <= n) {
			k++;
		}
		res[k - 1] = 1;
		n -= fib(k - 1);
	}
	return res;
}

void print_zeck_repr(int *repr) {
	int i = 0;
	while (repr[i] != default_val) {
		printf("%d ", repr[i]);
		i++;
	}
	printf("\n");
}

// Checks if an array is a valid Fibonacci representation:
// no two consecutive 1s, only 0s and 1s
int is_zeck_repr_repr_correct(int *x) {
	int i = 0;
	while (x[i] != default_val) {
		if (x[i] != 0 && x[i] != 1)
			return 0;
		if (i > 0 && x[i - 1] == 1 && x[i] == 1)
			return 0;
		i++;
	}
	return 1;
}

int *add_zeck_repr(int *x, int *y) {
	int sx = 0, sy = 0;
	while (x[sx] != default_val)
		sx++;
	while (y[sy] != default_val)
		sy++;
	// We create an array z of approriate size for storing the represnetation of
	// the addition. We initialize it to {0,0,...,0,-1}?
	// x represents a number <= fib(0) + fib(2) + fib(4) + … +
	// fib(sx - 1) and fib(0) + fib(2) + fib(4) + … + fib(sx - 1) < fib(sx) y
	// represents a number < fib(sy)
	// => x+y will be < fib(sx)+fib(sy) <= fib(max(sx,sy)+2)
	// => we need an array of size max(sx,sy)+4
	int z_size = (sx > sy ? sx : sy) + 4;
	int *z = calloc(z_size, sizeof(int));
	z[z_size - 1] = default_val;
	for (int i = 0; i <= z_size - 2; i++) {
		if (i < sx && i < sy) {
			z[i] = x[i] + y[i];
		} else if (i < sx) {
			z[i] = x[i];
		} else if (i < sy) {
			z[i] = y[i];
		}
	}
	// We apply rewriting rules to z
	while (!is_zeck_repr_repr_correct(z)) {
		// Rule to get rid of consecutives 1
		// Change the right-most a b 0 into (a-1) (b-1) 1 (when a > 0 and b > 0)
		int i = z_size - 2;
		while (i > 0 && (z[i - 1] == 0 || z[i] == 0)) {
			i--;
		}
		if (i > 0) {
			z[i - 1]--;
			z[i]--;
			z[i + 1]++;
		}
		// Rule to get rid of numbers >= 2
		/* 2*fib(n) = (fib(n) + fib(n-1)) + (fib(n) - fib(n-1))
		= fib(n+1) + fib(n) - fib(n-1)
		= fib(n+1) + fib(n-2) */
		// Change any `a b c d` with c >= 2 into `(a+1) b (c-2) (d+1)`.
		i = z_size - 2;
		while (i >= 0 && z[i] < 2) {
			i--;
		}
		if (i >= 2) {
			z[i - 2]++;
			z[i] -= 2;
			z[i + 1]++;
		}
		/* 2*fib(1) = 4 = 3 + 1 = fib(2) + fib(0)
		and 2*fib(0) = 2 = fib(1) */
		if (z[1] >= 2) {
			z[1] -= 2;
			z[2]++;
			z[0]++;
		}
		if (z[0] >= 2) {
			z[0] -= 2;
			z[1]++;
		}
	}
	return z;
}

// Tests if add_zeck_repr returns the expected result on the Fibonacci
// representations of x and y.
void test_addition(int x, int y) {
	int *x_repr = zeck_repr_of_int(x);
	int *y_repr = zeck_repr_of_int(y);
	int *sum_repr = add_zeck_repr(x_repr, y_repr);
	assert(int_of_zeck_repr(sum_repr) == x + y);
	free(x_repr);
	free(y_repr);
	free(sum_repr);
}

int gcd(int x, int y) {
	if (y == 0) {
		return x;
	}
	return gcd(y, x % y);
}

int main(int argc, char **argv) {
	// Tests de resizable_array
	resizable_array *rar = rar_create();
	rar_set_elem(rar, 2, 0);
	rar_set_elem(rar, 5, 1);
	rar_set_elem(rar, 8, 2);
	assert(rar_get_size(rar) > 8);
	assert(!rar_is_empty(rar));
	assert(rar_get_elem(rar, 2) == 0);
	assert(rar_get_elem(rar, 5) == 1);
	assert(rar_get_elem(rar, 8) == 2);
	assert(rar_get_elem(rar, 42000) == default_val);
	rar_print(rar);
	rar_free(rar);
	// Tests Fibo
	fib_values = rar_create();
	assert(fib(0) == 1);
	assert(fib(1) == 2);
	assert(fib(6) == 21);
	fib(30);
	rar_print(fib_values);
	// Tests Fibonacci numeration
	int *repr = zeck_repr_of_int(13842);
	print_zeck_repr(repr);
	assert(int_of_zeck_repr(repr) == 13842);
	free(repr);
	// Tests addition
	int x[] = {0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, -1};
	int y[] = {1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, -1};
	assert(is_zeck_repr_repr_correct(x));
	assert(is_zeck_repr_repr_correct(y));
	int *z = add_zeck_repr(x, y);
	print_zeck_repr(z);
	free(z);
	// Systematic test of addition
	for (int x = 0; x < 50; x++) {
		for (int y = x; y < 50; y++) {
			test_addition(x, y);
		}
	}
	// Free global variable
	rar_free(fib_values);
}
