#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Uno à une joueuse],
  language: "ocaml",
  difficulty: 3,
  themes: ("récursivité", "types", "complexité")
)

On s'intéresse à une variante du jeu de cartes Uno, à une joueuse.
Le jeu dispose de deux types de cartes :
- des cartes de valeurs, qui ont toute une couleur
	(rouge, jaune, vert ou bleu) et un chiffre,
- des cartes de changement de couleur.
Dans cette variante du jeu, il y a une carte initialement posée sur la table,
et la joueuse a en main un ensemble de cartes. Son but est de déposer l'ensemble de ses cartes
sur la pile.
Pour poser une carte sur la pile, il faut respecter les règles suivantes :
- on peut toujours poser une carte de changement de couleur,
- si la carte au sommet de la pile est un changement de couleur, on peut poser la carte qu'on souhaite,
- sinon, si une carte de valeur est au sommet de la pile et qu'on souhaite poser une carte de valeur,
	il faut soit que leur couleur coïncide, soit que leur chiffre coïncide.
Le but de l'exercice est, étant donnée une main de départ, de déterminer si une joueuse
a une stratégie lui permettant de vider entièrement sa main. 
+ Définir un type `card` permettant de représenter les cartes de ce jeu.
+ Montrer que le problème est non-trivial : donner un (tout petit) exemple où la joueuse peut
	vider sa main, et un (tout petit) exemple où elle ne peut pas le faire.
+ Définir une fonction\
	``` is_playable: card -> card -> bool```,\
	qui prend la dernière carte jouée et une 
	carte que l'on souhaite jouer, et qui retourne si on peut effectivement jouer cette carte.
+ On veut implémenter ici une stratégie _gloutonne_ : on va regarder la liste des cartes qu'on a en 
	main, et on va jouer la première carte que l'on peut jouer. On réitère ce processus jusqu'à ce
	que l'on ne puisse plus jouer, c'est-à-dire soit jusqu'à ce qu'on n'ait plus de carte en main (victoire !), soit jusqu'à ce qu'aucune de nos cartes ne soit jouable.
	Définir une fonction récursive terminale\
	``` greedy_play : card -> card list -> card list -> int```\
	qui prend en entrée la dernière carte jouée, et la main de la joueuse (séparée en deux listes), et 
	qui retourne le nombre de cartes restant dans la main de la joueuse après avoir appliqué cette stratégie gloutonne jusqu'à ne plus pouvoir jouer. 
	Les deux listes de cartes représentent respectivement les cartes que l'on a déjà essayé, sans succès, 
	de jouer sur la pile actuelle, et les cartes que l'on a pas encore essayé de jouer.
+ Quelles sont les complexités temporelles et spatiales, dans le pire cas, de cette fonction ?
+ Montrez que cette stratégie n'est pas optimale, c'est-à-dire qu'il existe une main initiale telle
	qu'en utilisant la stratégie gloutonne, on se retrouve à ne plus pouvoir jouer en ayant encore des cartes en main, alors qu'il existe une autre stratégie permettant de vider sa main.
+ Implémenter une fonction récursive\
	``` optimal_play : card -> card list -> int```
	qui prend en entrée la dernière carte jouée, et la main de la joueuse, et qui retourne
	le nombre de cartes restant dans la main de la joueuse après avoir appliqué une stratégie optimale.