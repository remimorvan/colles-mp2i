#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Correction d'un calcul d'une somme d'entiers],
  language: "théorique",
  difficulty: 2,
  themes: ("correction", ),
) 

On considère la fonction suivante en OCaml.
```ocaml
let sum_integers n =
  let rec aux k acc =
    assert(k >= 0);
    if k = 0 then
      acc
    else
      aux (k-1) (k+acc)
  in aux n 0;;
```
Démontrez que `sum_integers n` retourne $frac(n(n+1),2)$
pour tout $n in NN$.