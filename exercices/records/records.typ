#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Types enregistrement],
  language: "ocaml",
  difficulty: 1,
  tags: ("types",)
)

On souhaite créer un type enregistrement `neighbourhood` qui permette de représenter une zone
géographique, correspondant à un code postal et à un nom de commune.
+  Définir un type `neighbourhood` de 
  sorte que l'instruction suivante soit valide.
  ```ocaml
  let bdx = {
    postal_code = 33000;
    city = "Bordeaux";
  }
  ```
+ Écrire une fonction `string_of_neighbourhood` de type `neighbourhood -> string` qui associe
  à chaque zone une chaîne de caractères la représentant. Par exemple,
  ```ocaml string_of_neighbourhood bdx``` retournera "33000 Bordeaux".