#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Exponentiation rapide],
  language: "ocaml",
  difficulty: 1,
  themes: ("récursivité", "complexité", "terminaison", "arithmétique")
)

+ Implémentez un algorithme d'exponentiation rapide.
+ Justifiez sa terminaison.
+ Quelle est sa complexité temporelle dans le pire cas ?