#ifndef __MYLISTH__
#define __MYLISTH__

#include <stdbool.h>

#define elt_type char *
#define elt_fmt "%s "

typedef struct s_list list;

// Constructeur
list *list_create();

// Accesseurs
int list_length(list *l);
bool list_is_empty(list *l);
void list_print(list *l);
elt_type list_get_ith(list *l, int i);

// Transformateurs
void list_set_ith(list *l, int i, elt_type v);
void list_insert_ith(list *l, int i, elt_type v);
elt_type list_rotate(list *l, int i);
elt_type list_delete_ith(list *l, int i);
void list_delete_all(list *l);

// Destructeur
extern void list_free(list **addr_l);
#endif
