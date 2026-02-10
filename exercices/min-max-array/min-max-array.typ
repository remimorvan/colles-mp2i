#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Min-max d'un tableau],
  language: "c",
  difficulty: 2,
  tags: ("tableaux",),
	source: [#link("https://www.labri.fr/perso/fmoranda/pg101/")[Cours de C de Floréal Morandat à l'ENSEIRB].]
)

On souhaite, étant donné un tableau, calculer son minimum et son maximum.
Écrire une fonction\
```c void min_max(int l, int* t, int *min, int *max)```\
réalisant ce calcul. L'entrée `l` représente la taille du tableau `t`, et
`min` et `max` sont des pointeurs vers les cases mémoires où l'on souhaite stocker le résultat.
Vous être libres de choisir le comportement de cette fonction si le tableau est vide.