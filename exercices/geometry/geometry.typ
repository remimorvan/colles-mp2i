#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Un peu de géométrie du plan],
  language: "ocaml",
  difficulty: 2,
  themes: ("types", "float")
)

On souhaite représenter des points, des cercles, et des disques
en OCaml. Un point sera représenté par une paire d'abscisse et d'ordonnée
(qui seront des `float`), un cercle par un point (son centre) et un rayon (un `float`), et un disque par les mêmes informations.

+ Définir un type `point` représentant un point.
+ Définir un type `shape` représentant un objet géométrique (soit un cercle, soit un disque).
+ Écrire une fonction\
	```ocaml belongs_to: point -> shape -> bool```\
	qui détermine si un point appartient à un objet.
	#footnote[On rappelle qu'un disque est plein, contrairement à un cercle. Par exemple, le point de coordonnées $(1, frac(1,2))$ appartient au disque de centre $(0,0)$ et de rayon $2$.]