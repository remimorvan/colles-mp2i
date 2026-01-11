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
  title: [Colle 7 · Sujet A]
)
#set enum(numbering: "1.a.")

= Colle 7 · Sujet A

*_À lire avant toute chose :_*
Apportez du soin à la qualité de vos réponses plus qu'à la quantité, et pensez à écrire des tests. 
Il faudra faire un premier rendu sur Moodle à la fin de la colle. Vous avez la possibilité de faire
un second rendu, également sur Moodle, jusqu'à ce dimanche à midi. Vous pouvez me contacter
par mail à l'adresse `remi@morvan.xyz`.

Lisez les exercices dans leur intégralité avant de vous lancer et ayez toujours de quoi écrire
devant vous. *#text(red)[Tout fichier rendu doit pouvoir être
compilé (en C), ou interprété (OCaml) sans erreur ni warning,
et contenir des tests codés en dur avec des assert.]*

== Exercice A1 : Exponentiation rapide en OCaml

_Fichier à rendre sous le nom `NOM-exp-square.ml`._

+ Implémentez un algorithme d'exponentiation rapide.
+ Justifiez sa terminaison.
+ Quelle est sa complexité temporelle dans le pire cas ?

== Exercice A2 : Tri d'un tableau borné en C

_Fichier à rendre sous le nom `NOM-bounded-sort.c`._

Le but de cet exercice est de trier un tableau d'entiers *positifs*, lorsque l'on connaît une *borne (strictement)
supérieure $b$ sur les entrées du tableau*.
L'idée de l'algorithme est la suivante : 
on va créer un nouveau tableau `count` provisoire, de taille $b$, qui va compter le nombre d'occurrences de chaque élément :
plus précisément ```c count[i]``` (pour $i in [|0,B[|$) sera le nombre d'éléments du tableau d'entrée égaux à $i$.
À partir de ce tableau, on pourra alors trier le tableau d'origine simplement
en réécrivant les éléments dans le bon ordre.
+ Écrire une fonction\
	```c void bounded_sort(int *arr, int n, int b)```\
	qui prend en entrée un tableau `arr` de taille `n`, dont les entrées sont toutes comprises entre $0$ (inclus) et $b$ (exclus),
	et qui trie le tableau `arr` avec la méthode décrite précédemment.
+ L'hypothèse que l'on connaît une borne supérieure $b$ est-elle contraignante ? Comment s'en débarasser ?
	Implémentez votre solution dans une fonction\
	```c void bounded_sort_bis(int *arr, int n)```.\
+ Quelle est la complexité en temps et en espace de cet algorithme, dans le pire cas ? Dans le meilleur cas ?
+ Pour quels types de tableaux cet algorithme est-il bien plus intéressant à utiliser plutôt qu'un algorithme de tri
	par comparaison s'exécutant au pire cas en temps $O(n log(n))$ ?
	_La réponse attendue n'est pas mathématique, mais une description en quelques mots de la «~forme~» des données._


== Exercice A3 : Couplage de Cantor

_Fichier à rendre sous le nom `NOM-bijection.{c/ml}`._

Le but de cet exercice est de calculer la bijection $f$ de $NN^2$ dans $NN$ représentée en @cantor, appelée
«~couplage de Cantor~».
L'idée derrière cette bijection est simplement d'énumérer les paires d'entiers par diagonale. Au sein d'une diagonale, 
on énumère les paires selon les $x$ croissants.
Ainsi, on a par exemple $f(0,0) = 0$, $f(0,1) = 1$ et $f(1,0) = 2$, comme représenté en @cantor.
L'exercice est à faire dans le langage de votre choix.
#figure(
	cetz.canvas({
		import cetz.draw: *
		let n = 5
		for x in range(n) {
			for y in range(n) {
				circle((x,y), name: str(x)+"-"+str(y), radius: 1.5pt)
			}
		}
		set-style(line: (padding: 2pt))
		for d in range(n) {
			let y = d
			let x = 0
			while (y >= 1 and x < n - 1) {
				line(str(x)+"-"+str(y), str(x + 1)+"-"+str(y - 1), mark: (end: "barbed"))
				y -= 1
				x += 1
			}
			if (x < n - 1) {
				line(str(x)+"-"+str(y), str(0)+"-"+str(x + 1), mark: (end: "barbed"))
			}
		}
		for x in range(n) {
			for y in range(n) {
				set-style(content: (frame: "rect", stroke: none, fill: color.rgb(100%, 100%, 100%, 70%), padding: .02cm))
				content((name: str(x)+"-"+str(y), anchor: 45deg), text(size: .4em)[(#x, #y)], anchor: "south-west")
			}
		}
	}),
	caption: [Une bijection de $NN^2$ dans $NN$.],
) <cantor>
+ Définir une fonction *récursive*
	```c int bij(int x, int y)``` (en C) ou
	```ocaml bij: int * int -> int``` (en OCaml)
	calculant $f$.
// + Quelle est la complexité temporelle de `bij(x,y)`, en fonction de $x$, $y$ et $f(x,y)$ ?
// + Si votre fonction n'était pas *récursive terminale*, écrivez une nouvelle fonction qui l'est.
+ Vérifiez empiriquement que
$ f(x,y) = frac((x + y)(x + y + 1), 2) + x " pour " x, y in NN. $

_Pour la culture :_ 
Le couplage de Cantor a été introduit en 1873 par Georg Cantor.
Vous remarquerez que la fonction $f$ est un polynôme quadratique : en 1923, Rudolf Fueter et Georg Pólya
publient le théorème de Fueter–Pólya, qui affirme que $f$, et son symétrique $(x,y) mapsto f(y,x)$,
sont les *seules fonctions quadratiques* qui réalisent une bijection de $NN^2$ dans $NN$.
La conjecture Fueter–Pólya affirme elle que ce sont les *seules fonctions polynomiales* satisfaisant cette propriété.
À ce jour, la conjecture est encore ouverte !

== Exercice A4 : arbres de décision en OCaml

_Fichier à rendre sous le nom `NOM-decision-trees.ml`._\
*Ne faire cet exercice que si les trois premiers exercices ont été faits.*

#figure(tidy-tree-graph[
	- $x < 1.0$
		- $x < 0.5$
			- sortie 1
			- sortie 2
		- $x < 2.0$
			- $x < 1.21$
				- sortie 3
				- sortie 4 
			- sortie 5
	]+h(2cm)+
	tidy-tree-graph(draw-node: (
    tidy-tree-draws.label-match-draw-node.with(
      matches: (
        mark: (fill: color.rgb("#f8c291"), stroke: none),
        nil: (post: x => none)
      ),
    ),
  ))[
	- $x < 1.0$ <mark>
		- $x < 0.5$
			- sortie 1
			- sortie 2
		- $x < 2.0$ <mark>
			- $x < 1.21$ <mark>
				- sortie 3 <mark>
				- sortie 4 
			- sortie 5
	]
	,
  caption: [Un arbre de décision (à gauche)
	et nœuds visités par l'algorithme d'évaluation de l'arbre sur l'entrée $x=1.13$ (à droite).],
) <decision-tree>

Un arbre de décision est un arbre tel que celui représenté en @decision-tree :
il représente un algorithme prenant en entrée une variable $x$ de type ```ocaml float```,
et retournant une sortie de type ```ocaml 'a```---sur l'exemple de @decision-tree, le type de sortie
est ```ocaml string``` puisque ces sorties sont "sortie 1", ..., "sortie 5".
Les feuilles de cet arbre (les nœuds qui n'ont pas de fils) correspondent tous à des sorties.
Les nœuds internes (ceux avec des fils) sont eux étiquetés par des tests de la forme $x < "cst"$ où cst
est un flottant. Chaque nœud interne a exactement deux fils, appelés _fils gauche_ et _fils droit_.

Un arbre représente une fonction de type ```ocaml float -> 'a``` (appelée *sémantique* de l'arbre), définie de la façon 
récursive. Étant donné un flottant $x$, la sortie de cette fonction est obtenue en commençant à la _racine_ de l'arbre.
Si cette racine est une sortie, c'est notre valeur de retour. Sinon, c'est un nœud interne, qui est donc
étiqueté par un test de la forme $x < "cst"$ : c'est par exemple le cas sur la figure @decision-tree, et le test à la racine
est $x < 1.0$. Si le test est satisfait, on poursuit l'exécution de notre algorithme en allant dans le _fils gauche_ du nœud,
et sinon dans le fils droit.
Par exemple, si $x = 1.13$, sur l'arbre de @decision-tree, la sortie sera "sortie 3" : l'exécution de l'algorithme est
représentée sur la moitié droite de @decision-tree.

+ On définit ces arbres en OCaml de la façon suivante :\
	```ocaml 
	type 'a decision_tree_univariate =
		| TestUni of float * 'a decision_tree_univariate * 'a decision_tree_univariate
		| OutputUni of 'a;;
	```
	Les trois arguments du constructeur `TestUni` correspondent respectivement à la constante avec laquelle on compare $x$,
	le fils gauche du nœud, et son fils droit.
	+ Définir un arbre de décision `some_tree` de type ```ocaml string decision_tree_univariate``` correspondant
		à l'arbre de la @decision-tree.
	+ Écrire une fonction récursive\
		```ocaml eval_univariate: 'a decision_tree_univariate -> float -> 'a```\
		qui prend un arbre de décision, un flottant, et évalue la fonction définie par cet arbre sur ce flottant.
+ Les vrais arbres de décision ne manipulent en réalité pas qu'une seule variable mais plusieurs. Par convention et souci de 
	simplicité, on nommera ces variables $x_0, x_1, ..., x_(n-1)$ ($n in NN$ étant le nombre total de variables).
	Les tests sont désormais de la forme $x_i < "cst"$ ($i in [|0,n[|$) : on ne peut pas comparer des variables entre elles,
	mais on peut comparer n'importe quelle variable avec une constante.
	+ Définir un type ```ocaml 'a decision_tree``` permettant de représenter ces arbres de décision à plusieurs variables.
		_Indice : On pourra représenter la variable $x_i$ par l'entier $i$._
	+ Dans le cas $n=2$ (les variables sont donc $x_0$ et $x_1$), définir un arbre
		`quarter_planes` de type `string decision_tree` qui retourne "NE" (north-east), "NW" (north-west), "SW" (south-west), 
		"SE" (south-east) selon la position du point $(x_0, x_1)$ dans le plan : par exemple
		le quart de plan "NE" correspond aux points $lr("["0, +infinity "[") times lr("[" 0, +infinity "[")$,
		alors que le quart de plan
		"SE" correspond aux points $lr("["0, +infinity "[") times lr("]" -infinity, 0 "[")$.
	+ On souhaite maintenant écrire un algorithme pour évaluer ces arbres. Dans le cas univarié,
		l'entrée était représentée par un flottant. Dans notre cas, pour représenter une entrée $(x_0, x_1, ..., x_(n-1))$,
		on va utiliser un ```ocaml float array```.
		Écrire une fonction récursive\
		```ocaml eval: 'a decision_tree -> float array -> 'a```\
		qui prend un arbre de décision, un tableau de flottants, et évalue la fonction définie par cet arbre sur ce tableau.
		Pour rappel, la taille d'un tableau `arr` peut être obtenue avec ```ocaml Array.length arr```,
		et la $i$-ème entrée de ce tableau avec `arr.(i)`. On peut définir un tableau à l'aide de la syntaxe
		```ocaml [| x0 ; x1 ; ... |]```.
	+ Justifiez brièvement la terminaison de votre fonction `eval`. Donnez des bornes supérieures (raisonnables) sur
		la complexité temporelle et spatiale de cette même fonction.

=== Pour la culture : Arbres de décision & apprentissage
#figure(
	image("mnist.png", width: 50%),
  caption: [Images, représentant des chiffres, issues du jeu de données MNIST.],
) <mnist>
Les arbres de décision sont au cœur de plusieurs techniques de _machine learning_. Nous illustrons cela
un exemple de classification d'images, de $28 times 28$ pixels, en noir et blanc, représentant des chiffres, voir la @mnist.
Une telle image est représentée par un tableau de flottants de taille 784 (= $28 dot.c 28$). La $i$-ème entrée représente
la couleur du $i$-ème pixel : 0.0 est un pixel parfaitement blanc, et 1.0 représente un pixel parfaitement noir.

Le but d'un algorithme d'_apprentissage supervisé_, est, à partir d'un grand jeu d'exemples (c'est-à-dire d'images,
munies de la sortie attendue, c'est-à-dire ici du chiffre représenté sur l'image), d'apprendre une _fonction_
qui prend en entrée une telle image, et retourne le chiffre indiqué dessus.
#footnote[Bien sûr, la difficulté ne réside pas tant dans le fait de retourner la bonne réponse sur les données sur 
lesquelles on a appris, mais de retourner la bonne réponse sur d'autres données...]

Un arbre de décision est une façon naturelle et simple de représenter une telle fonction, dont les sorties sont
de type `int` (plus précisément, elles sont dans l'intervalle $[|0,9|]$.)
Souvent, apprendre un arbre de décision se révèle être relativement peu efficace (l'arbre est généralement très grand,
et la fonction apprise n'est pas toujours très satisfaisante). Une technique un peu plus raffinée, appelée
*forêts aléatoires* a été développée à la fin des années 1990s, pour pallier certains désavantages des arbres de décision.
L'idée est de, plutôt que d'apprendre *un seul* (grand) arbre de décision, de plutôt apprendre
*plusieurs* (petits) arbres---ce qui justifie le nom de «~forêt~». Pour que ces arbres soient distincts les uns des
autres un facteur aléatoire est introduit, en limitant artificiellement (et aléatoirement) quels pixels peuvent
être utilisés dans un test.
Les forêts aléatoires sont, bien que relativement simples, terriblement efficaces sur certains problèmes
d'apprentissage : c'est notamment le cas pour le problème de classification des chiffres sur le jeu de données MNIST (@mnist).