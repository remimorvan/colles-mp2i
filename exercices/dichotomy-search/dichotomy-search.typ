#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Recherche dichotomique],
  language: "ocaml",
  difficulty: 1,
  themes: ("récursivité", "tableaux")
)

Écrire une fonction\
```ocaml 
dichotomy_search: 'a -> 'a array -> bool
```
déterminant si un élément appartient à un tableau *trié*.
Votre algorithme devra utiliser une fonction auxiliaire qui sera
*récursive terminale*, et qui sera
basée sur le principe de la dichotomie.