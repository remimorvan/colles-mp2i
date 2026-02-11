#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Nombre de voyelles],
  language: "c",
  difficulty: 2,
  themes: ("tableaux",),
	source: [#link("https://www.labri.fr/perso/fmoranda/pg101/")[Cours de C de Floréal Morandat à l'ENSEIRB.]]
)

On souhaite déterminer le nombre de voyelles dans une chaîne de caractères en C.
+ Écrire une fonction\
	```c int in_array(char x, int n, char *arr)```\
	qui détermine si un caractère `x` est présent dans un tableau de caractères `arr` de taille `n`.
+ *En déduire* une fonction\
	```c int is_vowel(char c)```\
	qui détermine si un caractère est une voyelle.\
	_(Votre code doit tenir en deux lignes, sinon c'est que vous vous compliquez la vie.)_
+ En déduire une fonction\
	```c int nb_vowels(char *str)```\
	qui retourne le nombre total de voyelles contenues dans une chaîne de caractères.