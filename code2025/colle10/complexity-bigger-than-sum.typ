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

*Terminaison.* La fonction `is_bigger_than_sum` appelant la fonction `sum_list`,
on va d'abord montrer que celle-ci termine.
On choisit comme variant la taille de la liste passée en entrée. Par définition, est est à valeur
dans $NN$, et par ailleurs elle décroit à chaque appel récursif (instruction `h::t -> h + sum_list t`),
et donc la fonction `sum_list` termine. 
On peut maintenant montrer que la fonction `is_bigger_than_sum` termine : on choisit encore une fois
comme variant la taille de la liste passée en entrée, qui est à valeur dans $NN$ et strictement décroissant
à chaque appel récursif ; par ailleurs les autres instructions utilisée par la fonction `is_bigger_than_sum` terminent (notamment l'appel `sum_list`), et ainsi la fonction `is_bigger_than_sum` termine sur toute entrée.

*Complexité*. La fonction `sum_list` se contente de parcourir une unique fois la liste passée en entrée,
on additionnant ses entrées : elle a donc une complexité temporelle exactement linéaire en son entrée.
La fonction `is_bigger_than_sum` se contente également de parcourir une unique fois la liste passée en 
entrée, mais à chaque étape on fait appel à la fonction `sum_list` sur la queue de la liste, qui est 
linéaire en cette queue de la liste, et donc linéaire en la liste initiale.
On obtient donc un complexité temporelle au plus quadratique en la taille de la liste passée en entrée.
