#ifndef __MYLISTH__
#define __MYLISTH__

#include <stdbool.h>

#define elt_type char*
#define elt_fmt "%s "

typedef struct s_list list;

// constructeur
list* list_create(int s_max);

// accesseurs
int list_length(list* l);
bool list_is_empty(list* l);
void list_print(list* l);
elt_type list_get_ith(list* l, int i);

// transformateurs
void list_set_ith(list* l, int i, elt_type v);
void list_insert_ith(list* l, int i, elt_type v);
elt_type list_delete_ith(list* l, int i);
void list_delete_all(list* l);
list* list_concatenate(list* l1, list* l2);

// destructeur
extern void list_free(list** addr_l);
#endif
