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
  title: [Colle 11 · Sujet]
)
#set enum(numbering: "1.a.")

= Colle 11 · Sujet 

*_À lire avant toute chose :_*
Apportez du soin à la qualité de vos réponses plus qu'à la quantité, et pensez à écrire des tests. 
Il faudra faire un premier rendu sur Éléa à la fin de la colle. Vous avez la possibilité de faire
un second rendu, également sur Éléa, jusqu'à ce dimanche à midi. Vous pouvez me contacter
par mail à l'adresse `remi@morvan.xyz`.

Lisez les exercices dans leur intégralité avant de vous lancer et ayez toujours de quoi écrire
devant vous. *#text(red)[Tout fichier rendu doit pouvoir être
compilé (en C, avec l'option `-Wall`), ou interprété (OCaml) sans erreur ni warning,
et contenir des tests codés en dur avec des assert.]*

== Exercice : Un compteur en OCaml

_Fichier à rendre sur papier ou sous le nom `NOM-countdown.ml`._

On considère la fonction (partielle) suivante, qui transforme une pile de 0 et de 1 en
une autre pile de 0 et de 1.
- initialement, on part d'une pile remplie d'un nombre arbitraire de 1
- ensuite, on itère la construction suivante sur la pile :
	- si le sommet de la pile est un 1, on le remplace par un 0.
	- sinon, on dépile tous les 0 jusqu'à tomber sur le premier 1 ; on remplace ce 1 par un 0,
		puis on réempile un 1 pour 0 dépilé.
	- sinon (càd s'il n'y a que des 0), on s'arrête.

+ Itérez cette fonction sur la pile [1;1;1], jusqu'à ce que l'algorithme termine.
	Que semble faire cette fonction ?
+ On souhaite maintenant l'implémenter en OCaml. Comme notre fonction est *partielle* (sur la 
	pile remplie de 0, on ne retourne rien), on va utiliser le *type option*.
	En OCaml, le type `'a option` permet de représenter soit un objet de
	type `'a` (`Some (x)`), ou rien (`None`). C'est très utile pour définir des fonctions partielles.
	Par exemple
	```ocaml
	let first_elem lst = match lst with
		| [] -> None
		| h::_ -> Some(h)
	```
	est une fonction de type ```ocaml 'a list -> 'a option``` qui
	retourne le premier élément d'une liste.\
	+ Écrire une fonction\
		```ocaml next_stack: int list -> int list option```
		qui prend une pile et retourne soit `Some(p)` où p est la pile obtenue par la fonction décrite dans l'énoncé, soit `None` s'il n'y a rien à retourner.
	+ Écrire une fonction récursive\
		```ocaml countdown: int list option -> unit```\
		qui ne fait rien sur `None`, et sur `Some(p)` applique récursivement la fonction
		`next_stack` à `p` en affichant l'état de la pile à chaque étape.
+ Donnez un variant permettant de montrer que la fonction `countdown` termine.

== Exercice : Correction d'un algo de racine carrée en C

_Fichier à rendre sur papier ou sous le nom `NOM-correctness-sqrt.{txt/pdf}`._

```c
int my_sqrt(int n) {
	assert(n >= 0);
	int i = 0;
	while ((i + 1) * (i + 1) <= n) {
		i++;
	}
	return i;
}
```
Que retourne `my_sqrt(n)` pour $n in NN$ ? Démontrez-le (on pourra admettre que la fonction termine sur toute entrée).