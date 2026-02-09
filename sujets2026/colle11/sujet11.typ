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
  title: [Colle 11]
)
#set enum(numbering: "1.a.")

= Colle 11

*_À lire avant toute chose :_*
Apportez du soin à la qualité de vos réponses plus qu'à la quantité, et pensez à écrire des tests. 
Il faudra faire un premier rendu sur Éléa à la fin de la colle. Vous avez la possibilité de faire
un second rendu, également sur Éléa, jusqu'à ce dimanche à midi. Vous pouvez me contacter
par mail à l'adresse `remi@morvan.xyz`.

Lisez les exercices dans leur intégralité avant de vous lancer et ayez toujours de quoi écrire
devant vous. *#text(red)[Tout fichier rendu doit pouvoir être
compilé (en C, avec l'option `-Wall`), ou interprété (OCaml) sans erreur ni warning,
et contenir des tests codés en dur avec des assert.]*

== Exercice 1 : Un compteur en OCaml

_Fichier à rendre sous le nom `NOM-countdown.ml`._

On considère la fonction (partielle) suivante, qui transforme une pile de 0 et de 1 en
une autre pile de 0 et de 1.
- initialement, on part d'une pile remplie d'un nombre arbitraire de 1;
- ensuite, on itère la construction suivante sur la pile :
	- si le sommet de la pile est un 1, on le remplace par un 0.
	- sinon, on dépile tous les 0 jusqu'à tomber sur le premier 1 ; on remplace ce 1 par un 0,
		puis on réempile un 1 pour chaque 0 dépilé.
	- sinon (càd s'il n'y a que des 0), on s'arrête.

+ Itérez cette fonction sur la pile [1;1;1], jusqu'à ce que l'algorithme termine.
	Que semble faire cette fonction ?
+ On souhaite maintenant l'implémenter en OCaml. Comme notre fonction est *partielle* (sur la 
	pile remplie de 0, on ne retourne rien), on va utiliser le *type option*.
	On rappelle que le type `'a option` permet de représenter soit un objet de
	type `'a`, avec la syntaxe `Some (x)`, soit rien (`None`).
	Par ailleurs on représentera les piles avec des listes.
	+ Écrire une fonction\
		```ocaml next_stack: int list -> int list option```
		qui prend une pile et retourne soit `Some(p)` où p est la pile obtenue par la fonction décrite dans l'énoncé, soit `None` s'il n'y a rien à retourner.
	+ Écrire une fonction récursive\
		```ocaml countdown: int list option -> unit```\
		qui ne fait rien sur `None`, et sur `Some(p)` applique récursivement la fonction
		`next_stack` à `p` en affichant l'état de la pile à chaque étape.
+ Donnez un variant permettant de montrer que la fonction `countdown` termine.
+ Quelle est la complexité temporelle *moyenne* de la fonction `next_stack` ?

== Exercice 2 : Numération de Zeckendorf en C
// Dur
// Todo : retirer les questions int rar_is_empty(resizable_array *rar);
// et int rar_get_size(resizable_array *rar);
// elles ne servent à rien (et posent la question de ce qu'est la taille : la capacité ? le nombre d'éléments != -1 ?)
// q2 : pseudocode => description haut niveau
_Fichier à rendre sur papier ou sous le nom `NOM-zeckendorf.c`._

Vous connaissez l'écriture en base 10, en base 2, et plus généralement en base $b in NN_(>0)$, où la
séquence $(x_0, x_1, x_2, ..., x_(n-1))$ (avec $n in NN$ et $x_i in [|0,b-1|]$ pour tout $i < n$) représente l'entier $sum_(i=0)^(n-1) x_i b^i$.
On s'intéresse ici à système de numération plus excentrique : le *système de numération de Zeckendorf*.
Dans ce système, on représente un nombre en le décomposant comme la somme de *nombres*
appartenant à la suite de Fibonacci. Pour rappel, la suite de Fibonacci est définie récursivement par
$f_0 = 1$, $f_1 = 2$ et $f_(n+2) = f_n + f_(n+1)$ pour $n in NN$ : ses premiers termes sont donc
$1, 2, 3, 5, 8, 13$, etc.#footnote[Il est plus commun de choisir comme premiers termes 0 et 1, ou même 1 et 1, mais le choix de $f_0 = 1$ et $f_1 = 2$ est important pour cet exercice : nous avons besoin que tous les entiers de la suite soient distincts.]
Par exemple, on peut écrire 6 comme $5 + 1$ et $17$ comme $13 + 3 + 1$.
On remarque vite que cette écriture n'est pas unique : 5 peut s'écrire comme 5 (c'est un nombre de Fibonacci)
mais aussi comme $2+3$. Par suite, on peut écrire 6 comme $5+1$, mais aussi $2+3+1$.
Le *théorème de Zeckendorf*, énoncé et démontré par le médecin belge Édouard Zeckendorf dans les années 1950, montre
que tout entier peut s'écrire de façon unique comme la *somme de nombres de Fibonacci distincts
et tels que deux nombres de Fibonacci consécutifs ne puissent apparaître dans cette somme*.
C'est-à-dire que, par exemple, on s'interdit d'utiliser à la fois $3$ et $5$ (on utilisera à la place leur somme, $8$, qui par un heureux miracle est aussi un nombre de Fibonacci).
On admet ici ce théorème : étant donné un entier $n in NN$,
l'unique suite $(x_i)_(i in NN) in {0,1}^NN$ telle que $n = sum_(i=0)^(+infinity) x_i f_i$,
et $forall i in NN, not (x_i = 1 and x_(i+1) = 1)$, est appelée *écriture de Zeckendorf* (ou _représentation de Zeckendorf_) de $n$.
1. Calculez à la main l'écriture de Zeckendorf des entiers $10$, $20$ et $30$. 
2. Proposez un algorithme en pseudo-code permettant de calculer l'écriture de Zeckendorf d'un nombre.

Dans le reste de cet exercice, on va manipuler ce système de numération en C.
Sans surprise, le calcul des nombres de la suite de Fibonacci va donc jouer un rôle crucial.
Pour des raisons de performance,#footnote[(Et pour coller au programme de colle.)] nous souhaitons éviter de répéter ces calculs. Pour ce faire, on va utiliser la *mémoïzation*,
c'est-à-dire qu'on va 
stocker dans une structure de données les valeurs de la suite qui ont déjà été calculées.
Naturellement, on veut une structure qui permette d'accéder à tout élément en temps constant, mais aussi
qui soit redimensionnable. On va donc utiliser des… tableaux redimensionnables !
3.
	+ Définir un type `resizable_array` permettant de représenter un tableau redimensionnable
		contenant des entier positifs.
	+ Définir des fonctions\
		```c
		resizable_array *rar_create();
		int rar_is_empty(resizable_array *rar);
		int rar_get_size(resizable_array *rar);
		int rar_get_elem(resizable_array *rar, int i);
		void rar_set_elem(resizable_array *rar, int i, int x);
		void rar_print(resizable_array *rar);
		```
		La fonction `rar_get_elem` devra toujours retourner quelque chose : on retournera une valeur par défaut, par exemple -1, si
		l'élément n'existe pas ou n'a pas été initialisé. 
		La fonction `rar_set_elem` changera la valeur d'un élément du tableau : bien sûr,
		si le tableau n'est pas assez grand, on l'aggrandira auparavant. 
		Vous vous assurerez que votre implémentation a une complexité amortie raisonnable; je ne vous demande cependant pas de le justifier par écrit.
	+ Écrire une fonction ```c int fib(int n)```, qui :
		- vérifie dans une variable globale stockant un pointeur vers un `resizable_array`
			si on y a stocké le $n$-ème élément de la suite de Fibonacci, et
		- le retourne si c'est le cas,
		- sinon, le calcule, l'y stocke, puis le retourne.
	+ Quelle est la complexité temporelle dans le pire cas de ```c fib(n);``` en fonction de $n$, sos l'hypothèse qu'on a déjà calculé $f_i$ pour $i < n$ ?\ Et de 
		```c for (int i = 0; i < n; i++) { fib(i); }```, sous l'hypothèse que l'on n'a encore calculé aucune valeur ?
+ On se propose de représenter une écriture de Zeckendorf $(x_i)_(i in NN)$ comme un array contenant les valeurs
	${x_0, x_1, ..., x_(k-1), -1}$ où $k$ un entier tel que $x_n = 0$ pour tout $n >= k$.
	+ Écrire une fonction ```c void print_zeck_repr(int *repr)``` qui affiche une telle représentation (on n'affichera pas le -1 final, celui-ci ne sert qu'à marquer la fin du tableau).
	+ Écrire une fonction ```c int int_of_zeck_repr(int *repr)``` qui prend un array représentant $(x_i)_(i in NN)$,
		et retourne $sum_(i=0)^(+infinity) x_i dot f_i$.
	+ Écrire une fonction ```c int *zeck_repr_of_int(int n)``` qui retourne l'écriture de Zeckendorf de son entrée.
+ *Bonus (difficile).* Déterminez un algorithme pour additionner des nombres écrits sous leur écriture de Zeckendorf.
	On s'interdira de calculer les entiers qu'ils représentent : on souhaite trouver un algorithme qui travaille
	directement sur les écritures de Zeckendorf.
	Implémentez cet algorithme en une fonction ```c int *add_zeck_repr(int *x, int *y)```.
	// _Indice :_ Commencez par additionner naïvement $(x_i)_(i in NN)$ et $(y_i)_(i in NN)$, ce qui nous donne
	// la représentation $(z_i)_(i in NN) = (x_i + y_i)_(i in NN)$. Elle ne satisfait les règles de Zeckendorf (càd que
	// z_i in {0,1} et qu'il ne peut y avoir de $i$ tel que $z_i = 1$ et $z_(i+1) = 1$) : trouvez des règles de réécriture
	// à appliquer à $(z_i)_(i in NN)$ pour lui faire respecter les contraintes souhaitées. 