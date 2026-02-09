#import "@preview/tdtr:0.4.3" : *
#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

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
  title: [Colle 9 · Sujet A]
)
#set enum(numbering: "1.a.")

= Colle 9 · Sujet A

*_À lire avant toute chose :_*
Apportez du soin à la qualité de vos réponses plus qu'à la quantité, et pensez à écrire des tests. 
Il faudra faire un premier rendu sur Moodle à la fin de la colle. Vous avez la possibilité de faire
un second rendu, également sur Moodle, jusqu'à ce dimanche à midi. Vous pouvez me contacter
par mail à l'adresse `remi@morvan.xyz`.

Lisez les exercices dans leur intégralité avant de vous lancer et ayez toujours de quoi écrire
devant vous. *#text(red)[Tout fichier rendu doit pouvoir être
compilé (en C, avec l'option `-Wall`), ou interprété (OCaml) sans erreur ni warning,
et contenir des tests codés en dur avec des assert.]*

== Exercice A1 : Correction d'une boucle while

_Fichier à rendre sur papier ou sous le nom `NOM-correction-while42.{txt/pdf}`._
// Beaucoup plus dur qu'il n'y parait en première lecture : le variant est un peu subtil.
// L'exo 9B1 est bien plus facile.

On considère la fonction suivante en C :
```c
int get_first(int *arr, int n) {
	int i = 0;
	while (i < n && arr[i] < 42) {
		i++;
	}
	return i;
}
```
Démontrez que la fonction `get_first`, sur un tableau `arr`, de taille `n`, retourne
- le plus petit indice `i` tel que `arr[i] >= 42`, si un tel indice existe ;
- `n`, sinon.

== Exercice A2 : Files en OCaml
// La question 3 est un peu dure / pas très intéressante car en avance sur le programme.

_Fichier à rendre sous le nom `NOM-queue.ml`._

On souhaite implémenter une structure de files immuables en OCaml à l'aide de deux listes.
+ En deux à trois lignes, expliquer brièvement le principe d'une telle implémentation 
	(notamment : pourquoi avoir deux listes ?)
+ On se donne le type suivant
	```ocaml
	type 'a queue = {
		front: 'a list;
		back: 'a list;
	};;```
	Implémentez des fonctions\
	```ocaml
	new_queue: unit -> 'a queue 
	is_empty: 'a queue -> bool
	enqueue: 'a queue -> 'a -> 'a queue
	dequeue: 'a queue -> 'a * 'a queue
	```
	permettant respectivement de créer une nouvelle file, de tester si une file est vide, d'enfiler et de défiler.
	*Testez chacune de vos fonctions avant d'implémenter la suivante.*
+ Écrire une fonction\
	```ocaml print_queue: int queue -> unit```
	qui affiche les éléments d'une file (de la tête à la queue).
+ *Application : parcours en largeur d'un arbre.*
	#figure(
		tidy-tree-graph(compact: true)[
			- 0
				- 1
					- 3
					- 4
				- 2
					- 5
						- 7
						- 8
					- 6
		],
		caption: [Parcours en largeur d'un arbre. Les nombres indiquent l'ordre de visite des nœuds.]
	) <bfs>
	On définit un type pour encoder des arbres binaires (voir la @bfs).
	```ocaml
	type 'a tree =
		| Node of 'a * 'a tree * 'a tree 
		| Leaf of 'a
	```
	Le *parcours en largeur* (_breadth-first search_ ou _BFS_ en anglais) d'un arbre consiste à visiter tous les nœuds d'une certaine profondeur avant de visiter ceux de la profondeur suivante (voir la @bfs). Écrivez une fonction 
	```ocaml bfs: 'a tree -> 'a queue
	```
	qui associe à un arbre une file contenant ses nœuds dans l'ordre du parcours en largeur.
	Par exemple, la file retournée par votre fonction `bfs` sur l'arbre de la @bfs sera telle que, en la défilant, on obtiendra d'abord la valeur 0, puis 1, puis 2, etc.

== Exercice A3 : Correction et complexité d'une fonction récursive

_Fichier à rendre sur papier ou sous le nom `NOM-correction-fact.{txt/pdf}`._
On considère la fonction suivante en OCaml, qui implémente le calcul de la factorielle avec une fonction récursive terminale.
```ocaml
let fact n =
	assert(n >= 0);
  let rec fact_aux n acc =
    if n = 0 then
			acc
    else
			fact_aux (n - 1) (n * acc)
  in fact_aux n 1
```
+ Démontrez que la fonction `fact` termine sur toute entrée.
+ Déterminez la complexité temporelle de cette fonction.
+ Démontrez que la fonction `fact` est correcte, c'est-à-dire que `fact n` vaut $n!$ pour tout entier positif $n$.