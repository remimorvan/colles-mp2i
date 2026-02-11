#import "@preview/tdtr:0.4.3" : *

#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Arbres de décision],
  language: "ocaml",
  difficulty: 3,
  themes: ("récursivité", "arbres")
)

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
étiqueté par un test de la forme $x < "cst"$ : c'est par exemple le cas sur la @decision-tree, et le test à la racine
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

#heading(level: 2, numbering: none)[Pour la culture : Arbres de décision & apprentissage]
#figure(
	image("./mnist.png", width: 50%),
  caption: [Images, représentant des chiffres, issues du jeu de données MNIST.],
) <mnist>
Les arbres de décision sont au cœur de plusieurs techniques de _machine learning_. Nous illustrons cela sur
un exemple de classification d'images, de $28 times 28$ pixels, en noir et blanc, représentant des chiffres, voir la @mnist.
Une telle image est représentée par un tableau de flottants de taille 784 (= $28 dot.c 28$). La $i$-ème entrée représente
la couleur du $i$-ème pixel : 0.0 est un pixel parfaitement blanc, et 1.0 représente un pixel parfaitement noir.

Le but d'un algorithme d'_apprentissage supervisé_, est, à partir d'un grand jeu d'exemples (c'est-à-dire d'images,
munies de la sortie attendue, c'est-à-dire ici du chiffre représenté sur l'image), d'apprendre une _fonction_
qui prend en entrée une telle image, et retourne le chiffre indiqué dessus.
Bien sûr, la difficulté ne réside pas tant dans le fait de retourner la bonne réponse sur les données sur 
lesquelles on a appris, mais de retourner la bonne réponse sur d'autres données...

Un arbre de décision est une façon naturelle et simple de représenter une telle fonction, dont les sorties sont
de type `int` (plus précisément, elles sont dans l'intervalle $[|0,9|]$.)
Souvent, apprendre un arbre de décision se révèle être relativement peu efficace (l'arbre est généralement très grand,
et la fonction apprise n'est pas toujours très satisfaisante). Une technique un peu plus raffinée, appelée
*forêts aléatoires* a été développée à la fin des années 1990s, pour pallier certains désavantages des arbres de décision.
L'idée est de, plutôt que d'apprendre *un seul grand arbre* de décision, de plutôt apprendre
*plusieurs petits arbres*---ce qui justifie le nom de «~forêt~». Pour que ces arbres soient distincts les uns des
autres, un facteur aléatoire est introduit, en limitant artificiellement (et aléatoirement) quels pixels peuvent
être utilisés dans un test.
Les forêts aléatoires sont, bien que relativement simples, terriblement efficaces sur certains problèmes
d'apprentissage : c'est notamment le cas pour le problème de classification des chiffres sur le jeu de données MNIST (@mnist).