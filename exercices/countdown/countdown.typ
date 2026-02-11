#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Un compteur et sa complexité moyenne],
  language: "ocaml",
  difficulty: 2,
  themes: ("piles/files", "terminaison", "complexité", "récursivité"),
) 

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