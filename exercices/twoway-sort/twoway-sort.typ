#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Tri d'un tableau 0/1 en place],
  language: "c",
  difficulty: 2,
  themes: ("tableaux", "tri", "complexité"),
	source: [Exercices 25, 27 et 28 du livre « Informatique - MP2I/MPI - CPGE 1re et 2e années - Cours et exercices corrigés », de Balabonski Thibaut, Conchon Sylvain, Filliâtre Jean-Christophe, Nguyen Kim, Sartre Laurent.]
)

+ Écrire une fonction \
	```c void swap(int arr[], int i, int j)```\
	qui échange les éléments n°`i` et `j` du tableau `arr`.
+ Écrire une fonction \
	```c twoway_sort(int arr[], int n)```\
	qui prend en entrée un tableau et sa taille,
	et qui le *trie en place*. *On supposera que le tableau ne contient
	que les valeurs 0 et 1*, et la seule opération qui vous est permise
	est la fonction `swap` de la question précédente.
	La complexité temporelle de votre algorithme doit être au pire linéaire.\
+ *Question bonus, à ne faire que si vous avez terminé tout le reste de la feuille.*\
	Écrire une fonction \
	```c dutch_flag(int arr[], int n)```\
	qui prend en entrée un tableau et sa taille,
	et qui le *trie en place*. On supposera que le tableau ne contient
	que les valeurs 0, 1 ou 2, et la seule opération qui vous est permise
	est la fonction `swap` de la question précédente.
	La complexité temporelle de votre algorithme doit être au pire linéaire.\
	_Cette question nécessite une réflexion algorithmique non-triviale. Plus encore que pour les autres questions, *faites des dessins sur une feuille*._