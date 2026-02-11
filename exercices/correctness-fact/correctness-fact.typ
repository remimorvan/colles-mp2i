#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Correction d'un calcul récursif de la factorielle],
  language: "théorique",
  difficulty: 2,
  themes: ("correction", "terminaison", "complexité"),
) 

On considère la fonction suivante en OCaml, qui implémente le calcul de la factorielle avec une fonction récursive terminale.
```ocaml
let fact n =
	assert(n >= 0);
  let rec fact_aux n acc =
    if n = 0 then
			acc
    else
			fact_aux (n - 1) (n * acc)
  in fact_aux n 1
```
+ Démontrez que la fonction `fact` termine sur toute entrée.
+ Déterminez la complexité temporelle de cette fonction.
+ Démontrez que la fonction `fact` est correcte, c'est-à-dire que `fact n` vaut $n!$ pour tout $n in NN$.