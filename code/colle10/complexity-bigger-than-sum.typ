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
  title: [Correction 10A2 : Complexité d'une fonction récursive]
)
#set enum(numbering: "1.a.")

= Correction 10A2 : Complexité d'une fonction récursive

On considère les fonctions suivantes en OCaml.
```ocaml
let rec sum_list lst = match lst with
  | [] -> 0
  | h::t -> h + sum_list t;;

let rec is_bigger_than_sum lst = match lst with
  | [] -> true
  | h::t -> (h < sum_list t) && (is_bigger_than_sum t);;
```

_Remarque : La fonction `is_bigger_than_sum` porte en fait mal son nom : elle devrait soit s'appeler `is_smaller_than_sum` où on devrait changer `h < sum_list t` en `h > sum_list t`._
