#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#include "circular.h"

struct s_cell {
	elt_type val;
	struct s_cell *addr_prev;
	struct s_cell *addr_next;
};

typedef struct s_cell cell;

struct s_list {
	int siz;
	cell *addr_first;
};

typedef struct s_list list;

list *list_create() {
	list *l = malloc(sizeof(list));
	assert(l != NULL);

	l->siz = 0;
	l->addr_first = NULL;
	return l;
}

//***********************************//
// accesseurs

int list_length(list *l) {
	assert(l != NULL);
	return l->siz;
}

bool list_is_empty(list *l) {
	assert(l != NULL);
	return (l->siz == 0);
}

void list_print(list *l) {
	assert(l != NULL);
	cell *c = l->addr_first;
	// Ici, attention à ne pas boucler tant que c != NULL :
	// avec une liste circulaire, ça ne termine pas…
	for (int i = 0; i < l->siz; i++) {
		// Le compteur i ne sert qu'à afficher le bon nombre d'éléments
		printf(elt_fmt, c->val);
		printf(" ");
		c = c->addr_next;
	}
	printf("\n");
}

cell *get_ith_cell(list *l, int i) {
	assert(l != NULL);
	cell *c = l->addr_first;
	int sgn = i >= 0 ? 1 : -1;
	for (unsigned int j = 0; j < sgn * i; j++) {
		assert(c != NULL);
		if (sgn == 1) {
			c = c->addr_next;
		} else {
			c = c->addr_prev;
		}
	}
	assert(c != NULL);
	return c;
}

elt_type list_get_ith(list *l, int i) {
	assert(l != NULL);
	cell *c = get_ith_cell(l, i);
	assert(c != NULL);
	return c->val;
}

//***********************************//
// transformateurs

void list_set_ith(list *l, int i, elt_type v) {
	assert(l != NULL);
	cell *c = get_ith_cell(l, i);
	assert(c != NULL);
	c->val = v;
}

void list_insert_ith(list *l, int i, elt_type v) {
	assert(l != NULL);

	cell *c_new = malloc(sizeof(cell));
	assert(c_new != NULL);
	c_new->val = v;
	l->siz = l->siz + 1;

	if (l->siz == 1) {
		c_new->addr_next = c_new;
		c_new->addr_prev = c_new;
		l->addr_first = c_new;
	} else {
		cell *c_prev = get_ith_cell(l, i - 1);
		assert(c_prev != NULL);
		cell *c_next = c_prev->addr_next;
		assert(c_next != NULL);
		c_prev->addr_next = c_new;
		c_new->addr_prev = c_prev;
		c_next->addr_prev = c_new;
		c_new->addr_next = c_next;
		if (i % l->siz == 0)
			l->addr_first = c_new;
	}
}

elt_type list_rotate(list *l, int i) {
	assert(l != NULL);
	cell *c = get_ith_cell(l, i);
	assert(c != NULL);
	l->addr_first = c;
	return c->val;
}

elt_type list_delete_ith(list *l, int i) {
	assert(l != NULL);
	cell *c = get_ith_cell(l, i);
	assert(c != NULL);
	elt_type v = c->val;
	l->siz = l->siz - 1;
	if (l->siz == 0) {
		l->addr_first = NULL;
	} else {
		cell *c_prev = c->addr_prev;
		cell *c_next = c->addr_next;
		assert(c_prev != NULL && c_next != NULL);
		c_prev->addr_next = c_next;
		c_next->addr_prev = c_prev;
		if (l->addr_first == c)
			l->addr_first = c_next;
	}
	free(c);
	return v;
}

void list_delete_all(list *l) {
	while (!list_is_empty(l)) {
		list_delete_ith(l, 0);
	}
}

//******************************
// destructeur
// le passage par adresse est nécessaire pour être certain
// de bien remettre l'adresse de la liste NULL
void list_free(list **addr_l) {
	assert(addr_l != NULL);
	list_delete_all(*addr_l);
	*addr_l = NULL;
}

// Question 2b

list *list_walk(list *l, int step) {
	assert(l != NULL);
	list *walk = list_create();
	assert(walk != NULL);
	if (!list_is_empty(l)) {
		int i = 0;
		do {
			elt_type v = list_get_ith(l, i * step);
			list_insert_ith(walk, i, v);
			i++;
		} while (i * step % l->siz != 0);
	}
	return walk;
}

// tests en dur dans le main
int main(void) {
	list *chromatic_scale = list_create();
	list_print(chromatic_scale);
	list_insert_ith(chromatic_scale, 0, "do");
	list_insert_ith(chromatic_scale, 1, "do#");
	list_insert_ith(chromatic_scale, 2, "ré");
	list_insert_ith(chromatic_scale, 3, "ré#");
	list_insert_ith(chromatic_scale, 4, "mi");
	list_insert_ith(chromatic_scale, 5, "fa");
	list_insert_ith(chromatic_scale, 6, "fa#");
	list_insert_ith(chromatic_scale, 7, "sol");
	list_insert_ith(chromatic_scale, 8, "sol#");
	list_insert_ith(chromatic_scale, 9, "la");
	list_insert_ith(chromatic_scale, 10, "la#");
	list_insert_ith(chromatic_scale, 11, "si");
	list_print(chromatic_scale);
	list *circle_of_fifths = list_walk(chromatic_scale, 7);
	list_print(circle_of_fifths);
	list_free(&chromatic_scale);
	list_free(&circle_of_fifths);
	return 0;
}
