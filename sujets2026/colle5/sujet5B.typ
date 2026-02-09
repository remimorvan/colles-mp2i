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
  title: [Colle 5 · Sujet B]
)
#set enum(numbering: "1.a.")

= Colle 5 · Sujet B

*_À lire avant toute chose :_*
Apportez du soin à la qualité de vos réponses plus qu'à la quantité, et pensez à écrire des tests. 
Il faudra faire un premier rendu sur Moodle à la fin de la colle. Vous avez la possibilité de faire
un second rendu, également sur Moodle, jusqu'à ce dimanche à midi. Vous pouvez me contacter
par mail à l'adresse `remi@morvan.xyz`.

Lisez les exercices dans leur intégralité avant de vous lancer et ayez toujours de quoi écrire
devant vous. *Je vous demande de commencer par les deux premiers exercices*, mais vous êtes ensuite libres de choisir l'ordre dans lequel vous résolvez les exercices suivants.


== Exercice 1 : Types enregistrement en Ocaml

_Fichier à rendre sous le nom `NOM-records.ml`._

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

== Exercice 2 : Min-max d'un tableau en C
// Source : cours Floréal

_Fichier à rendre sous le nom `NOM-minmax.c`._

On souhaite, étant donné un tableau, calculer son minimum et son maximum.
Écrire une fonction\
```c void min_max(int l, int* t, int *min, int *max)```\
réalisant ce calcul. L'entrée `l` représente la taille du tableau `t`, et
`min` et `max` sont des pointeurs vers les cases mémoires où l'on souhaite stocker le résultat.
Vous être libres de choisir le comportement de cette fonction si le tableau est vide.

== Exercice 3 : Uno à une joueuse en OCaml

_Fichier à rendre sous le nom `NOM-uno.ml`._

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

== Exercice 4 : Retournement de chaîne en C
// Source : cours Floréal

_Fichier à rendre sous le nom `NOM-mirror.c`._

+ Écrire une fonction\
	```c void reverse(char* str, char* str_rev)```\
	qui prend deux chaînes de caractères `str` et `str_rev`, et qui
	écrit sur `str_rev` le miroir de `str`. Le miroir est obtenu
	en lisant la chaîne de droite à gauche. Par exemple, le renversé
	de "Hello world!" est "!dlrow olleH".
	On supposera que la chaîne `str_rev` est de taille suffisante pour stocker le résultat.

	Vous pourrez tester votre code avec la fonction `main` suivante.
	```c
	int main(int argc, char** argv) {
			char str[100] = "Hello world!";
			char str_rev[100] = "";
			reverse(str, str_rev);
			printf("%s\n", str_rev);
			return 0;
	}
	```
+ Dessinez l'état de la mémoire avant l'appel de `reverse`, puis juste avant le retour de la fonction `reverse`.