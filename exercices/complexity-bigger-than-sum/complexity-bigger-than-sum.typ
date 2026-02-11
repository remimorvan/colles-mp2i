#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Complexité d'une fonction sur des listes],
  language: "théorique",
  difficulty: 1,
  themes: ("complexité", "terminaison"),
) 

On considère les fonctions suivantes en OCaml.
```ocaml
let rec sum_list lst = match lst with
  | [] -> 0
  | h::t -> h + sum_list t;;

let rec is_bigger_than_sum lst = match lst with
  | [] -> true
  | h::t -> (h > sum_list t) && (is_bigger_than_sum t);;
```

Démontrez brièvement que la fonction `is_bigger_than_sum` termine sur toute entrée.
Quelle est sa complexité temporelle ?
