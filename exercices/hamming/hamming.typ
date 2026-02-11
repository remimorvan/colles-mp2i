#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Nombres de Hamming],
  language: "c",
  difficulty: 2,
  themes: ("piles/files", "complexité", "I/O", "arithmétique"),
  source: [#link("https://info-llg.fr/option-mpsi/pdf/05.piles_et_files.pdf")[Cours de Jean-Pierre Becirspahic au lycée Louis-le-Grand]]
)

Le but de cet exercice est d'implémenter une structure de files en C.
Je vous laisse le choix de l'implémentation (maillons chaînés, tableau circulaire, etc.).

+ Définir un type `Queue` permettant de stocker des files d'entiers.
+ Définir des fonctions
	```c
	Queue *queue_create(void);
	void queue_enqueue(Queue *, int);
	void queue_print(Queue *);
	int queue_peek(Queue *);
	int queue_dequeue(Queue *);
	int queue_is_empty(Queue *);
	void queue_free(Queue *);
	```
	Chaque fonction devra être testée, et la complexité temporelle de la fonction
	donnée en commentaire. *Testez chaque fonction avant d'implémenter la suivante.*
+ *Application.* Une _nombre de Hamming_ est un entier naturel non-nul qui n'est divisible
	que par 2, 3, et 5. Les plus petits nombres de Hamming sont 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, etc.
	On se propose de générer les nombres de Hamming en utilisant la remarque suivante :
	tout nombre de Hamming autre que 1 est le produit d'un nombre de Hamming strictement inférieur
	avec 2, 3 ou 5. Et réciproquement, le produit d'un nombre de Hamming avec 2, 3 ou 5 est toujours un nombre de Hamming. On considère l'algorithme suivant :
	on maintient trois files d'entiers, `h2`, `h3` et `h5`, toutes initialisées pour ne contenir qu'une valeur : l'entier 1.
	Tant qu'on veut produire un nombre de Hamming,
	on chosit le plus petit entier `n` parmi les sommets de `h2`, `h3` et `h5`, on le défile,
	on affiche `n`, puis on enfile `2 * n` à `h2`, `3 * n` à `h3` et `5 * n` à h5.\
	Écrire une fonction
	```c void hamming(int m)```
	qui affiche tous les entiers de Hamming inférieur à $m$.
+ *Comparaison avec un algorithme naïf.* On considère ici un algorithme plus naïf,
	qui se contente d'énumérer les entiers de $1$ à $m-1$ et de tester pour chacun s'il est
	un nombre de Hamming. Pour tester si un entier $n$ est un nombre de Hamming, on peut
	par exemple le diviser par 2 tant qu'il est divisible par 2, puis par 3, puis par 5.
	Le résultat final est égal à 1 si et seulement si $n$ est un nombre de Hamming.
	+ Empiriquement, pour $m=10^9$, mon ordinateur met $10$s à exécuter l'algorithme naïf,
		contre moins de $0.01$s pour l'algorithme avec files.
		Expliquez cette différence.
	+ Implémentez cette fonction naïve (et vérifiez qu'elle donne les même résultats
		que la fonction précédente).
		_Si le besoin se fait sentir, vous pouvez utiliser les commandes Unix `time` pour mesurer le temps d'exécution d'un programme, `wc -l` pour compter le nombre de lignes d'un fichier et l'opérateur `>` pour rediriger la sortie vers un fichier._