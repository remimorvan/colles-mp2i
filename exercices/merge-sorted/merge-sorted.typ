#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Fusion de tableaux triés],
  language: "c",
  difficulty: 2,
  themes: ("tableaux", "tri")
)

Écrire une fonction\
```c  int* merge_sorted(int arr1[], int n1, int arr2[], int n2)```\
prenant deux tableaux *triés* et leur taille, et retournant un tableau
résultant de la fusion de ces deux tableaux. Plus précisément,
on souhaite que l'ensemble des nouveaux éléments de ce tableau soit l'union
des deux tableaux passés en entrée, et que le nouveau soit trié.
Votre algorithme devra être en temps linéaire en la taille de l'entrée.