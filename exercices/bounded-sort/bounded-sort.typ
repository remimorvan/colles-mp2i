#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Tri d'un tableau borné],
  language: "c",
  difficulty: 2,
  themes: ("tri", "tableaux", "complexité")
)

Le but de cet exercice est de trier un tableau d'entiers *positifs*, lorsque l'on connaît une *borne (strictement)
supérieure $b$ sur les entrées du tableau*.
L'idée de l'algorithme est la suivante : 
on va créer un nouveau tableau `count` provisoire, de taille $b$, qui va compter le nombre d'occurrences de chaque élément :
plus précisément ```c count[i]``` (pour $i in [|0,B[|$) sera le nombre d'éléments du tableau d'entrée égaux à $i$.
À partir de ce tableau, on pourra alors trier le tableau d'origine simplement
en réécrivant les éléments dans le bon ordre.
+ Écrire une fonction\
	```c void bounded_sort(int arr[], int n, int b)```\
	qui prend en entrée un tableau `arr` de taille `n`, dont les entrées sont toutes comprises entre $0$ (inclus) et $b$ (exclus),
	et qui trie le tableau `arr` avec la méthode décrite précédemment.
+ L'hypothèse que l'on connaît une borne supérieure $b$ est-elle contraignante ? Comment s'en débarasser ?
	Implémentez votre solution dans une fonction\
	```c void bounded_sort_bis(int arr[], int n)```.\
+ Quelle est la complexité en temps et en espace de cet algorithme, dans le pire cas ? Dans le meilleur cas ?
+ Pour quels types de tableaux cet algorithme est-il bien plus intéressant à utiliser plutôt qu'un algorithme de tri
	par comparaison s'exécutant au pire cas en temps $O(n log(n))$ ?
	_La réponse attendue n'est pas mathématique, mais une description en quelques mots de la «~forme~» des données._