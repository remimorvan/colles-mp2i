#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Complexité d'une drôle de fonction récursive],
  language: "théorique",
  difficulty: 3,
  themes: ("complexité", "terminaison"),
) 

On considère la fonction suivante en OCaml, de type ```ocaml int -> int -> int```.
```ocaml
let rec foo a b = 
  if a <= 0 || b <= 0 then
    max a b
  else (
    let x = foo (a-1) b
    and y = foo a (b-1) in
    if x <= y then
      2 * x
    else
      a * a + x
  );;
```

+ Démontrez que cette fonction termine sur toute entrée à l'aide d'un variant dans $NN$.
+ Quelle est sa complexité temporelle ?

_Remarque :_ Attention à ne pas sous-estimer la difficulté de cet exercice, qui paraît _a priori_ 
trivial à toute personne expérimentée, mais qui contient en fait un difficulté conceptuelle : définir un variant dans $NN$ pour une fonction ayant plusieurs paramètres.
Il me semble important d'insister sur le fait que ce variant soit dans $NN$ : on pourrait certes
démontrer la terminaison à l'aide dans $NN^2$ muni de l'ordre lexicographique, mais la première
question sert aussi à mettre sur la bonne voie pour la question de la complexité.