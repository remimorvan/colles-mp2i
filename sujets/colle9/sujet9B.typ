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
  title: [Colle 9 · Sujet B]
)
#set enum(numbering: "1.a.")

= Colle 9 · Sujet B

*_À lire avant toute chose :_*
Apportez du soin à la qualité de vos réponses plus qu'à la quantité, et pensez à écrire des tests. 
Il faudra faire un premier rendu sur Moodle à la fin de la colle. Vous avez la possibilité de faire
un second rendu, également sur Moodle, jusqu'à ce dimanche à midi. Vous pouvez me contacter
par mail à l'adresse `remi@morvan.xyz`.

Lisez les exercices dans leur intégralité avant de vous lancer et ayez toujours de quoi écrire
devant vous. *#text(red)[Tout fichier rendu doit pouvoir être
compilé (en C, avec l'option `-Wall`), ou interprété (OCaml) sans erreur ni warning,
et contenir des tests codés en dur avec des assert.]*

== Exercice B1 : Correction et terminaison d'une boucle while

_Fichier à rendre sur papier ou sous le nom `NOM-correction-array-sum.{txt/pdf}`._

```c
int array_sum(int *arr, int n) {
	assert(arr != NULL);
	assert(n >= 0);
	int sum = 0;
	int i = 0;
	while (i < n) {
		sum = sum + arr[i];
		i++;
	}
	return sum;
}
```
+ Démontrez que la fonction `array_sum` termine sur toute entrée.
+ Déterminez la complexité temporelle de cette fonction.
+ Démontrez sa correction, c'est-à-dire que ```c array_sum(int *arr, int n)``` retourne la somme des `n` premiers éléments du tableau `arr` pour tout entier positif $n$.

== Exercice B2 : Notation polonaise inversée en OCaml

_Fichier à rendre sous le nom `NOM-rpn.ml`._

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


== Exercice B3 : Correction et complexité d'une fonction récursive

_Fichier à rendre sur papier ou sous le nom `NOM-correction-fibo.{txt/pdf}`._
On considère la fonction suivante en OCaml.
```ocaml
let fibo n =
	assert(n>=0);
  let rec fibo_aux k val_p val_pp =
		if k = n then
			val_pp
		else
			fibo_aux (k+1) val_pp (val_p + val_pp)
  in fibo_aux 0 1 1;;
```
La personne qui a écrit cette fonction souhaitait que ```fibo n``` retourne le $n$-ème terme $f_n$
de la suite de Fibonacci, où $f_0 = f_1 = 1$ et $f_(n+2) = f_(n) + f_(n+1)$ pour tout $n in NN$.
Ce n'est malheureusement pas tout à fait le cas. Que calcule ```fibo n``` ? Prouvez-le.