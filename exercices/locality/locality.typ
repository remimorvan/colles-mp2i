#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Types sommes et produits],
  language: "ocaml",
  difficulty: 1,
  themes: ("types",)
)

On souhaite définir un type `locality` qui représente un échelon du maillage   
territorial français : pour faire simple, on veut seulement représenter soit des communes 
(représentée par un entier à cinq chiffres, qui est leur code INSEE), soit des départements 
(représentés par un entier à deux chiffres). Par exemple, le code INSEE de Bordeaux est le 33063, et 
le numéro de département de la Gironde est le 33.
+ Écrire un type somme `locality` correspondant à la description précédente. 
+ Écrire une fonction `is_part_of` de type `locality -> locality -> bool` qui détermine
	si 1. la première localité est une commune, 2. la seconde est un département, et 3.
  la commune appartient au département.
	On admettra que les deux premiers chiffres du code INSEE d'une commune
	correspondent à son numéro de département.