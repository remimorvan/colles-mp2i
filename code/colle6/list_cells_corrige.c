#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#include "mylist.h"

struct s_cell {
    elt_type val;              // valeur contenue dans ce maillon
    struct s_cell* addr_next;  // pointeur contenant l'adresse
                               // du maillon suivant
};

typedef struct s_cell cell;

// *************
// amelioration: creation d'une structure de donnée list
// qui encapsule les 2 informations: l'adresse du premier
// maillon + la taille de la liste
// la taille est ainsi mise à jour dès que la structure
// est modifiée (suppression ou ajout d'un élément)
// ce qui évite de recalculer trop souvent la taille
struct s_list {
    int siz;  // invariant de structure
    cell* addr_first;
};

typedef struct s_list list;

list* list_create(int s_max) {
    list* l = NULL;
    l = malloc(sizeof(list));
    assert(l != NULL);  // check allocation

    l->siz = 0;
    l->addr_first = NULL;
    return l;
}

//***********************************//
// accesseurs

int list_length(list* l) {
    assert(l != NULL);
    return l->siz;
}

// calcul de la longueur courante de la liste
int list_length2(list* l) {
    assert(l != NULL);
    cell* c = l->addr_first;
    int cpt = 0;

    while (c != NULL) {
        cpt = cpt + 1;
        c = c->addr_next;
    }

    l->siz = cpt;
    return cpt;
}

bool list_is_empty(list* l) {
    assert(l != NULL);
    if (l->siz == 0)
        return true;
    else
        return false;
}

void list_print(list* l) {
    assert(l != NULL);
    cell* c = l->addr_first;

    printf("%d elements: ", l->siz);
    while (c != NULL) {
        printf(elt_fmt, c->val);
        printf(" ");
        c = c->addr_next;
    }
    printf("\n");

    return;
}

elt_type list_get_ith(list* l, int i) {
    assert(l != NULL);
    assert(i >= 0 && i < l->siz);

    cell* c = l->addr_first;
    for (unsigned int j = 0; j < i; j++) {
        assert(c != NULL);
        c = c->addr_next;
    }
    assert(c != NULL);

    return c->val;
}

//***********************************//
// transformateurs

void list_set_ith(list* l, int i, elt_type v) {
    assert(l != NULL);
    assert(i >= 0 && i < l->siz);

    cell* c = l->addr_first;
    for (unsigned int j = 0; j < i; j++) {
        assert(c != NULL);
        c = c->addr_next;
    }
    c->val = v;

    return;
}

void list_insert_ith(list* l, int i, elt_type v) {
    assert(l != NULL);
    assert(i >= 0 && i <= l->siz);

    cell* c_new = NULL;

    if (i == 0) {
        c_new = malloc(sizeof(cell));
        assert(c_new != NULL);
        c_new->val = v;
        c_new->addr_next = l->addr_first;
        l->addr_first = c_new;
        l->siz = l->siz + 1;
        return;
    }

    cell* c = l->addr_first;
    cell* prv = NULL;
    for (unsigned int j = 0; j < i; j++) {
        assert(c != NULL);
        prv = c;
        c = c->addr_next;
    }

    c_new = malloc(sizeof(cell));
    assert(c_new != NULL);
    c_new->val = v;
    c_new->addr_next = c;
    prv->addr_next = c_new;
    l->siz = l->siz + 1;
    return;
}

elt_type list_delete_ith(list* l, int i) {
    assert(l != NULL);
    assert(i >= 0 && i < l->siz);
    elt_type v;

    cell* c = NULL;

    if (i == 0) {
        c = l->addr_first;
        assert(c != NULL);
        v = c->val;
        l->addr_first = c->addr_next;
        l->siz = l->siz - 1;
        free(c);  // free memory allocated to this cell
        return v;
    }

    c = l->addr_first;
    cell* prv = NULL;
    cell* nxt = NULL;

    for (unsigned int j = 0; j < i; j++) {
        assert(c != NULL);
        prv = c;
        c = c->addr_next;
    }

    assert(c != NULL);
    nxt = c->addr_next;
    prv->addr_next = nxt;

    v = c->val;
    free(c);  // free memory allocated to this cell
    l->siz = l->siz - 1;

    return v;
}

void list_delete_all(list* l) {
    cell* c = l->addr_first;
    cell* tmp = NULL;

    while (c != NULL) {
        tmp = c;
        c = c->addr_next;
        free(tmp);
    }
    l->siz = 0;
    l->addr_first = NULL;

    return;
}

// attention: cette fonction a un effet de bord: l1 est modifiée
// en sortie de la fonction!!!
list* list_concatenate(list* l1, list* l2) {
    if (l2 == NULL)
        return l1;
    if (l1 == NULL)
        return l2;

    cell* c = l1->addr_first;
    if (c == NULL)
        return l2;

    cell* prv = NULL;

    while (c != NULL) {
        prv = c;
        c = c->addr_next;
    }
    prv->addr_next = l2->addr_first;

    l1->siz = l1->siz + l2->siz;
    return l1;
}

//******************************
// destructeur
// le passage par adresse est nécessaire pour être certain
// de bien remettre l'adresse de la liste NULL
void list_free(list** addr_l) {
    assert(addr_l != NULL);

    list* l = *addr_l;
    if (l == NULL)
        return;

    cell* c = l->addr_first;
    cell* tmp = NULL;

    while (c != NULL) {
        tmp = c;
        c = c->addr_next;
        if (tmp != NULL)
            free(tmp);
    }
    free(l);
    *addr_l = NULL;

    return;
}

// tests en dur dans le main
int main(void) {
    list* l = list_create(100);
    list_insert_ith(l, 0, "do");
    list_insert_ith(l, 1, "do#");
    list_insert_ith(l, 2, "ré");
    list_insert_ith(l, 3, "ré#");
    list_insert_ith(l, 3, "mi");
    list_print(l);
    list_free(&l);

    return 0;
}
