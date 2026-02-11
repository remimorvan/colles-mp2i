#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Le cycle des quintes],
  language: "c",
  difficulty: 2,
  themes: ("mémoire", "listes chaînées"),
  source: [L'interface de la structure est adaptée du TP de Géraldine Olivier sur les listes chaînées en C.]
)

On veut ici implémenter une structure
de *liste circulaire doublement chaînée*.
Concrètement, contrairement à une liste chaînée, cette structure est circulaire
(un élément a toujours un successeur), et on veut aussi pouvoir accéder
au prédécesseur d'un élément de la liste. Un exemple est donné en @liste-circulaire-double. Notons qu'une telle liste a toujours un élément
spécial, appelé «~élément de tête~».

#figure(
  image("./liste-circulaire-double.svg", width: 50%),
  caption: [Une liste circulaire doublement chaînée.],
) <liste-circulaire-double>

On propose d'implémenter cette structure avec des *maillons*, chaque
*maillon* contenant une valeur (des entiers sur la @liste-circulaire-double),
un pointeur vers l'élément *suivant*, et un pointeur vers l'élément *précédent*.
*Vous avez le droit, et êtes même très vivement encouragé·e·s, de travailler à partir de la correction du TP sur les listes chaînées.*

Voici l'interface abstraite de la structure.
```c
// Constructeur
list    *list_create();

// Accesseurs
int      list_length(list *l);
bool     list_is_empty(list *l);
void     list_print(list *l);
elt_type list_get_ith(list *l, int i);

// Transformateurs
void     list_set_ith(list *l, int i, elt_type v);
void     list_insert_ith(list *l, int i, elt_type v);
elt_type list_rotate(list *l, int i);
elt_type list_delete_ith(list *l, int i);
void     list_delete_all(list *l);

// Destructeur
extern void list_free(list **addr_l);
```

Notons par ailleurs que *l'entier `i` peut désormais 
être négatif* : par exemple, le (-3)-ème élément d'une liste circulaire doublement chaînée, c'est le prédécesseur du prédécesseur du prédécesseur de l'élément de tête.
Il n'y a pas ici de fonction de concaténation.
#footnote[On pourrait toutefois donner un sens à une telle opération si on le souhaitait.]
On a cependant rajouté une nouvelle opération `list_rotate` : celle-ci fait
rotationner la liste, c'est-à-dire qu'elle déplace l'élément de tête de la liste. Elle retourne par ailleurs le nouvel élément de tête.
Par exemple, sur la @liste-circulaire-double, une rotation de -2 (ou de 3)
ferait que 5 serait le nouvel élément de tête.

+ Implémentez les fonctions de l'interface. Après chaque fonction, *compilez et testez*.
+ Application.
	+ Créez une liste circulaire doublement chaînée `chromatic_scale`
		dont les éléments sont,
		dans l'ordre, les chaînes de caractères "do", "do\#", "ré", "ré\#", "mi", 
		"fa", "fa\#", "sol", "sol\#", "la", "la\#" et "si".
	+ Écrire une fonction \
		```c list* list_walk(list *l, int step)```,\
		qui, à partir d'une liste circulaire doublement chaînée,
		retourne une structure du même type, obtenue en lisant les éléments
		à partir de l'élément de tête par pas de `step`, jusqu'à retomber
		sur l'élément de tête. Ce pas pourra être positif, négatif ou nul.
	+ En musique, le *cycle des quintes* est une liste circulaire obtenue
		à partir de l'échelle chromatique en la parcourant par pas de 7.
		#footnote[Un intervalle de 7 demi-tons (l'intervalle élémentaire séparant
		'do' de 'do\#', ou encore 'mi' de 'fa') est appelé *quinte*, d'où le nom «~cycle des quintes~».]
		Calculez et affichez ce cycle.