#import "@preview/tdtr:0.4.1" : *

#set page(
  paper: "a4",
  header: text(size: 0.85em, emph[
    MP2I · Lycée Montaigne
    #h(1fr)
    2025--26 · Rémi Morvan
  ])
)
#set par(justify: true)
#set text(
  font: "Libertinus Serif",
  size: 11pt,
)
#set document(
  title: [Colle 6]
)
#set enum(numbering: "1.a.")

= Colle 6 · Sujet

*_À lire avant toute chose :_*
Apportez du soin à la qualité de vos réponses plus qu'à la quantité, et pensez à écrire des tests. 
Il faudra faire un premier rendu sur Moodle à la fin de la colle. Vous avez la possibilité de faire
un second rendu, également sur Moodle, jusqu'à ce dimanche à midi. Vous pouvez me contacter
par mail à l'adresse `remi@morvan.xyz`.

Lisez les exercices dans leur intégralité avant de vous lancer et ayez toujours de quoi écrire
devant vous. *#text(red)[Tout fichier rendu doit pouvoir être
compilé (en C), ou interprété (OCaml) sans erreur ni warning,
et contenir des tests codés en dur avec des assert.]*

== Exercice : Recherche dichotomique en OCaml

_Fichier à rendre sous le nom `NOM-dichotomy.ml`._

Écrire une fonction\
```ocaml 
dichotomy_search: 'a -> 'a array -> bool
```
déterminant si un élément appartient à un tableau *trié*.
Votre algorithme devra utiliser une fonction auxilliaire qui sera
*récursive terminale*, et qui sera
basée sur le principe de la dichotomie.

== Exercice : Un peu de géométrie du plan en OCaml

_Fichier à rendre sous le nom `NOM-geometry.ml`._

On souhaite représenter des points, des segments de droites, et des disques
en OCaml. Un point sera représenté par une paire d'abscisse et d'ordonnée
(qui seront des `float`), un segment de droite par une paire de points (ses extrémités), et un disque par un point (son centre) et un rayon (un `float`).

+ Définir un type `point` représentant un point.
+ Définir un type `object` représentant un objet géométrique (soit un segment, soit un disque).
+ Écrire une fonction\
	```ocaml is_subset object -> object -> bool```
	qui détermine si un objet est un sous-ensemble d'un autre.
	#footnote[On rappelle qu'un disque est plein, contrairement à un cercle. Par exemple, le point de coordonnées $(1, frac(1,2))$ appartient au disque
	de centre $(0,0)$ et de rayon $2$.]


== Exercice : Drapeau hollandais en C

_Fichier à rendre sous le nom `NOM-dutch.c`._

+ Écrire une fonction \
	```c void swap(int *arr, int i, int j)```\
	qui échange les éléments n°`i` et `j` du tableau `arr`.
+ Écrire une fonction \
	```c dutch_flag(int *arr, int n)```\
	qui prend en entrée un tableau et sa taille,
	et qui le *trie en place*. On supposera que le tableau ne contient
	que les valeurs 0, 1 ou 2, et la seule opération qui est vous permise
	est la fonction `swap` de la question précédente.
	La complexité temporelle de votre algorithme doit être au pire linéaire.\
	_Cette question nécessite une réflexion algorithmique non-triviale. Plus encore que pour les autres questions, *faites des dessins sur une feuille*._ 


== Exercice : Liste circulaire doublement chaînée en C

_Fichier à rendre sous le nom `NOM-circular.c`._

On veut ici implémenter une structure
de *liste doublement chaînée circulaire*.
Concrètement, contrairement à une liste chaînée, cette structure est circulaire
(un élément a toujours un successeur), et on veut aussi pouvoir accéder
au prédécesseur d'un élément de la liste. Un exemple est donné en @liste-circulaire-double. Notons qu'une telle liste a toujours un élément
spécial, appelé « élément de tête ».

#figure(
  image("liste-circulaire-double.svg", width: 50%),
  caption: [Une liste circulaire doublement chaînée.],
) <liste-circulaire-double>

On propose d'implémenter cette structure avec des *maillons*, chaque
*maillon* contenant une valeur (des entiers sur la @liste-circulaire-double),
un pointeur vers l'élément suivant, et un pointeur vers l'élément suivant.
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
		sur l'élément de tête. Ce pas pourra est positif, négatif ou nul.
	+ En musique, le *cycle des quintes* est une liste circulaire obtenue
		à partir de l'échelle chromatique en la parcourant par pas de 7.
		#footnote[Un intervelle de 7 demi-tons (l'intervalle élémentaire séparant
		'do' de 'do\#', ou encore 'mi' de 'fa') est appelé *quinte*, d'où le nom « cycle des quintes ».]
		Calculez et affichez ce cycle.