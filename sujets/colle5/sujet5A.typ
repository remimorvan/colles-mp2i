#import "@preview/tdtr:0.4.1" : *

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
  title: [Colle 5 · Sujet A]
)
#set enum(numbering: "1.a.")

= Colle 5 · Sujet A

*_À lire avant toute chose :_*
Apportez du soin à la qualité de vos réponses plus qu'à la quantité, et pensez à écrire des tests. 
Il faudra faire un premier rendu sur Moodle à la fin de la colle. Vous avez la possibilité de faire
un second rendu, également sur Moodle, jusqu'à ce dimanche à midi. Vous pouvez me contacter
par mail à l'adresse `remi@morvan.xyz`.

Lisez les exercices dans leur intégralité avant de vous lancer et ayez toujours de quoi écrire
devant vous. *Je vous demande de commencer par les deux premiers exercices*, mais vous êtes libres de choisir l'ordre dans lequel vous résolvez les exercices 
suivants.

== Exercice 1 : Types sommes et produits en Ocaml

_Fichier à rendre sous le nom `NOM-locality.ml`._

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

== Exercice 2 : Gestion de la mémoire en C

_Fichier à rendre sous le nom `NOM-memory.c`._

+ Le code suivant a un comportement indéterminé. Pourquoi ?
  ```c
  #include <stdio.h>

  int* foo(int step) {
      int p[9] = {0};
      for (int i = 0; i < 9; i += step) {
          p[i] = 1;
      }
      return p;
  }

  int main(int argc, char** argv) {
      int* p = foo(2);
      printf("%d\n", p[4]);
      return 0;
  }
  ```
+ Corrigez le code de la fonction `foo`, puis dessinez l'état de la mémoire juste
  avant l'exécution de l'instruction ```c return p;```.

== Exercice 3 : Nombre de voyelles en C

// Source : cours Floréal
_Fichier à rendre sous le nom `NOM-vowels.c`._

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

== Exercice 4 : Arbres binaires en Ocaml

_Fichier à rendre sous le nom `NOM-trees.ml`._

On s'intéresse à des arbres binaires étiquettés par des entiers. Ce sont des structures, définies récursivement : un tel arbre est soit une simple feuille, à qui on a associé un entier,
soit un noeud interne, à qui on associe un entier (son étiquette), ainsi que deux arbres,
appelés _fils gauche_ et _fils droit_.
+ Définir un type `tree` permettant de représenter cette structure.
+ Définir une fonction\
  ``` max_of_tree: tree -> int```,\
  qui calcule la plus grande étiquette
  apparaissant sur un arbre.
+ Définir une fonction\
  ``` max_of_subtrees_quad: tree -> tree```\
  qui prend un arbre,
  et retourne un nouvel arbre obtenu à partir du premier en remplaçant l'étiquette d'un nœud
  par la plus grande valeur apparaissant sous ce nœud.
  #footnote[Par «~sous ce nœud~» on veut dire formellement «~dans le sous-arbre enraciné en ce nœud~».]
  Par exemple, sur l'entrée
  
  #align(center)[
    #table(
      columns: (auto, auto, auto),
      stroke: none,
      inset: 10pt,
      align: horizon+center,
      tidy-tree-graph(compact: true)[
        - 7
          - 3
            - 2
            - 4
          - 10
            - 1
            - 0
      ],
      [la fonction `max_of_subtrees_quad` retournera],
      tidy-tree-graph(compact: true)[
        - 10
          - 4
            - 2
            - 4
          - 10
            - 1
            - 0
      ]+[.]
    )
  ]
+ Déterminez les complexités spatiales et temporelles de votre fonction `max_of_subtrees_quad`. Votre fonction est-elle récursive terminale ?
+ Si votre fonction n'a pas une complexité temporelle linéaire, donnez-en une nouvelle version
  pour qui c'est le cas.