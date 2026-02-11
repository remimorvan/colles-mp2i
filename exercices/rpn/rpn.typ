#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Notation polonaise inversée],
  language: "ocaml",
  difficulty: 2,
  themes: ("récursivité", "complexité", "arbres", "piles/files", "I/O", "arithmétique")
)

La *notation polonaise inversée* (_reverse polish notation_ ou _RPN_ en anglais) permet de décrire
des expressions arithmétiques sans utiliser de 
parenthèses.
L'idée est simple : plutôt que d'écrire les 
opérateurs entre ses arguments, comme on le fait 
en notation infixe (la notation « classique »),
on écrit plutôt *l'opérateur après les arguments.*
Par exemple, $1+2$ devient 1 2 +.
De même, $(1 + 2) + 3$ devient $1 2 + 3 +$.
Au contraire, $1 + (2 + 3)$ devient 1 2 3 + +.

+ Écrire $(1+2)*(3+4)$
	et $1+2*3+4$ en notation polonaise inversée.
+ On se dote d'un type récursif en OCaml
	```ocaml type expr =
	 | Const of int
	 | Add of expr * expr
	 | Mult of expr * expr;;```
	qui permet de représenter des expressions arithmétiques.
	+ Écrire une fonction\
		```ocaml eval_expr: expr -> int```\
		qui évalue une telle expression.
	+ Quelle est la complexité temporelle de votre 	
		fonction ```eval_expr``` ?
+ Écrire une fonction\
		```ocaml expr_to_rpn: expr -> int_or_op list```\
		qui transforme une expression arithmétique
		en une liste qui représente cette
		expression en notation polonaise inversée, où 
		```ocaml 
		type int_or_op = Int of int | Plus | Times;;
		```
		Par exemple, sur l'entrée
		``` Add(Mult(Const(1),Const(2)), Const(3))```
		votre algorithme retournera
		```ocaml [Int(1);Int(2);Times;Int(3);Plus]```.
+ Le but de cette question est d'écrire une fonction\ ```ocaml eval_rpn: int_or_op list -> int```\
	qui évalue une liste de caractères représentant une expression arithmétique en notation polonaise inversée.
	Un algorithme très efficace pour ce faire
	consiste à utiliser une pile : on part d'une pile vide, et on traite la liste de caractères
	de la façon suivante :
	- si c'est un entier, on l'empile 
	- si c'est un opérateur, on l'applique aux deux entiers présents au sommet de la pile, et on empile le résultat.
	Un exemple, pour le calcul $3*(10+5)$, qui donne
	3  10 5 + \* en notation polonaise inversée, est
	donné en @rpn.
	#figure(
		image("rpn.png", width:50%),
		caption: [« Représentation de la structure de lecture d'une expression RPN par stacks. De gauche à droite et de haut en bas, case par case (étapes). » Figure par Stonemountain420,
		issue de #link("https://commons.wikimedia.org/wiki/File:CPT-RPN-example1.svg")[Wikimedia], sous licence CC BY SA 3.0.]
	) <rpn>
	+ Écrire la fonction ```ocaml eval_rpn: int_or_op list -> int```.
	+ Vérifiez sur plusieurs expressions de type 
		`expr` que les évaluer directement avec
		`eval_expr` donne le même résultat que
		de les transformer en notation polonaise inversée
		avec `expr_to_rpn` puis de les évaluer
		avec `eval_rpn`.