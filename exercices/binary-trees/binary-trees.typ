#import "@preview/tdtr:0.4.3" : *
#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Arbres binaires],
  language: "ocaml",
  difficulty: 2,
  tags: ("récursivité", "arbres", "complexité")
)

On s'intéresse à des arbres binaires étiquettés par des entiers. Ce sont des structures, définies récursivement : un tel arbre est soit une simple feuille, à qui on a associé un entier,
soit un noeud interne, à qui on associe un entier (son étiquette), ainsi que deux arbres,
appelés _fils gauche_ et _fils droit_.
+ Définir un type `tree` permettant de représenter cette structure.
+ Définir une fonction\
  ```ocaml max_of_tree: tree -> int```\
  qui calcule la plus grande étiquette
  apparaissant sur un arbre.
+ Définir une fonction\
  ```ocaml max_of_subtrees_quad: tree -> tree```\
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