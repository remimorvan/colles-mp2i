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
  title: [Colle 6 · Sujet A]
)
#set enum(numbering: "1.a.")

= Colle 6 · Sujet A

*_À lire avant toute chose :_*
Apportez du soin à la qualité de vos réponses plus qu'à la quantité, et pensez à écrire des tests. 
Il faudra faire un premier rendu sur Moodle à la fin de la colle. Vous avez la possibilité de faire
un second rendu, également sur Moodle, jusqu'à ce dimanche à midi. Vous pouvez me contacter
par mail à l'adresse `remi@morvan.xyz`.

Lisez les exercices dans leur intégralité avant de vous lancer et ayez toujours de quoi écrire
devant vous. *#text(red)[Tout fichier rendu doit pouvoir être
compilé (en C), ou interprété (OCaml) sans erreur ni warning,
et contenir des tests codés en dur avec des assert.]*

== Exercice A1 : Fusion de tableau

// Plus dur qu'il n'y parait. Ok pour les élèves rigoureux, mais pour les autres il y a plusieurs difficultés.
// C'est un bon exo, mais pas un exo de cours.

_Fichier à rendre sous le nom `NOM-merge.c`._

Écrire une fonction\
```c  int* merge_sorted(int *arr1, int n1, int *arr2, int n2)```\
prenant deux tableaux *triés* et leur taille, et retournant un tableau
résultant de la fusion de ces deux tableaux. Plus précisément,
on souhaite que l'ensemble des nouveaux éléments de ce tableau soit l'union
des deux tableaux passés en entrée, et que le nouveau soit trié.
Votre algorithme devra être en temps linéaire en la taille de l'entrée.

== Exercice A2 : Un brin de génétique en OCaml 

// Remarque : un peu dur, beaucoup de type.
// Bien dans l'idée mais à retravailler : certaines questions pas utiles pour la dernière question.

_Fichier à rendre sous le nom `NOM-ARNm.ml`._

L'acide ribonucléique messager (ARNm) est une molécule qui intervient
dans la synthèse des protéines à partir de l'ADN.
On peut voir un brin d'ARNm comme un mot sur l'alphabet $\{A, U, G, C\}$,
chaque lettre étant appelée *nucléotide*.
#footnote[Les lettres A, U, G et C font respectivement référence aux nucléotides adénine, uracile, guanine et cytosine.]
L'algorithme pour synthétiser une protéine à partir d'un brin ARNm est le suivant :
- on regroupe les nucléotides par groupe de trois ;
	chaque groupe de trois nucléotides (par exemple "AUG" et "CGA") est appelé "codon" ;
- chaque codon produit un acide aminé (par exemple `Phe` (_phénylalanine_), ou `Lys` (_lysine_)),
	ou indique le début de la synthèse (`init`), ou l'arrêt de la synthèse (`stop`). 
	Un codon qui indique le début de la synthèse est aussi toujours associé à un acide aminé.
	Par exemple, "AUG" indique le début de la synthèse et est associé à l'acide aminé "Met".
	La première fois qu'on le rencontrera, celà initiera la synthèse de la protéine, mais la
	seconde fois, il produira l'acide aminé "Met".
	#footnote[Bien évidemment, tout ceci est une simplification de la réalité.]

Considérons par exemple le brin d'ARN messager
$ "CUCAUGCAGAGUAUGUGAAGCCCCUUC". $
Ses codons sont
$ underbrace("CUC", mono("Leu"))
	underbrace("AUG", mono("init/Met"))
	underbrace("CAG", mono("Gln"))
	underbrace("AGU", mono("Ser"))
	underbrace("AUG", mono("init/Met"))
	underbrace("UGA", mono("stop"))
	underbrace("AGC", mono("Ser"))
	underbrace("CCC", mono("Pro"))
	underbrace("UUC", mono("Phe")). $
Lors de la synthèse, on obtiendra donc la protéine définie par la suite d'acide aminé
`Gln Ser Met`. Le but de cet exercice est de simuler cette synthèse en OCaml.

+ Définir un type `nucleotide`, puis écrire une fonction\
	```ocaml nucleotide_of_char: char -> nucleotide```\
	qui retourne le nucléotide associé à un caractère.
	Par soucis de simplicité, on représentera un acide aminé par une chaîne de caractères,
	et un codon par un triplet de nucléotides.
	```ocaml type amino_acid = string;;
	type codon = (nucleotide * nucleotide * nucleotide);;```
+	Définir un type `effect` qui contient l'effet de chaque codon, c'est-à-dire :
	- est-ce que c'est un codon stopant ?
	- si ça ne l'est pas, on souhaite l'information de l'acide aminé produit, et de si
		c'est un codon initiant.
+ On souhaite définir une structure qui décrit l'information de quel acide aminé est associé à
	un codon donné : on va utiliser une *liste d'association*.
	Une liste d'association est une liste de type ```ocaml ('a * 'b) list```, 
	de sorte que si $(c,v)$ et $(c',v')$ sont tous deux éléments de la liste, alors $c != c'$.
	Autrement dit, une liste d'association encode une fonction qui associe des éléments
	de type `'a` (appelés *clés*) à des éléments de type `'b` (appelés *valeurs*).
	+ Définir une fonction\
		```ocaml is_defined: ('a * 'b) list -> 'a -> bool```\
		qui prend une liste d'association, une clé, et détermine si une valeur lui est associée.
	+ Définir une fonction\ 
		```ocaml value_of: ('a * 'b) list -> 'a -> 'b```\
		qui prend une liste d'association, une clé, et retourne la valeur qui lui est associée
		(si elle existe, sinon elle produit une erreur).
+ À partir de la liste d'association de type `(string * string) list`
	```ocaml
	let codon_to_amino_acid = [ ("UUU", "Phe") ; ("UUC", "Phe") ; ("UUA", "Leu") ; ("UUG", "Leu") ; ("CUU", "Leu") ; ("CUC", "Leu") ; ("CUA", "Leu") ; ("CUG", "Leu") ; ("AUU", "Ile") ; ("AUC", "Ile") ; ("AUA", "Ile") ; ("AUG", "Met") ; ("GUU", "Val") ; ("GUC", "Val") ; ("GUA", "Val") ; ("GUG", "Val") ; ("UCU", "Ser") ; ("UCC", "Ser") ; ("UCA", "Ser") ; ("UCG", "Ser") ; ("CCU", "Pro") ; ("CCC", "Pro") ; ("CCA", "Pro") ; ("CCG", "Pro") ; ("ACU", "Thr") ; ("ACC", "Thr") ; ("ACA", "Thr") ; ("ACG", "Thr") ; ("GCU", "Ala") ; ("GCC", "Ala") ; ("GCA", "Ala") ; ("GCG", "Ala") ; ("UAU", "Tyr") ; ("UAC", "Tyr") ; ("UAA", "stop") ; ("UAG", "stop") ; ("CAU", "His") ; ("CAC", "His") ; ("CAA", "Gln") ; ("CAG", "Gln") ; ("AAU", "Asn") ; ("AAC", "Asn") ; ("AAA", "Lys") ; ("AAG", "Lys") ; ("GAU", "Asp") ; ("GAC", "Asp") ; ("GAA", "Glu") ; ("GAG", "Glu") ; ("UGU", "Cys") ; ("UGC", "Cys") ; ("UGA", "stop") ; ("UGG", "Trp") ; ("CGU", "Arg") ; ("CGC", "Arg") ; ("CGA", "Arg") ; ("CGG", "Arg") ; ("AGU", "Ser") ; ("AGC", "Ser") ; ("AGA", "Arg") ; ("AGG", "Arg") ; ("GGU", "Gly") ; ("GGC", "Gly") ; ("GGA", "Gly") ; ("GGG", "Gly") ];;
	```
	et de l'information que les codons initiants sont exactement `UUG`, `CUG` et `AUG`,
	*produire* une liste d'association `codon_to_effect` de type `(codon * effect) list`.\
	_Par « produire » on sous-entend qu'il ne faut *pas* écrire cette liste à la main, 
	mais écrire un bout de code qui génère cette liste à partir de la liste fournie._
+ Écrire une fonction\
	```ocaml string_to_codon_list: string -> codon list```\
	qui associe à une chaîne de caractères (par ex. "CUCAUGCAGAGUAUGUGAAGCCCCUUC")
	sa liste de codons.
+ Déduire de ces questions une fonction (récursive) de type\
	```ocaml synthesis: string -> amino_acid list```\
	qui produit, à partir d'une chaîne de caractères représentant un brin d'ARN messager,
	la chaîne d'acide aminés de la protéine qu'il produit.

#pagebreak()

== Exercice A3 : Tri d'un tableau 0/1 en C
// Source : bouquin MP2I/MPI

_Fichier à rendre sous le nom `NOM-twoway-sort.c`._

+ Écrire une fonction \
	```c void swap(int *arr, int i, int j)```\
	qui échange les éléments n°`i` et `j` du tableau `arr`.
+ Écrire une fonction \
	```c twoway_sort(int *arr, int n)```\
	qui prend en entrée un tableau et sa taille,
	et qui le *trie en place*. *On supposera que le tableau ne contient
	que les valeurs 0 et 1*, et la seule opération qui vous est permise
	est la fonction `swap` de la question précédente.
	La complexité temporelle de votre algorithme doit être au pire linéaire.\
+ *Question bonus, à ne faire que si vous avez terminé tout le reste de la feuille.*\
	Écrire une fonction \
	```c dutch_flag(int *arr, int n)```\
	qui prend en entrée un tableau et sa taille,
	et qui le *trie en place*. On supposera que le tableau ne contient
	que les valeurs 0, 1 ou 2, et la seule opération qui vous est permise
	est la fonction `swap` de la question précédente.
	La complexité temporelle de votre algorithme doit être au pire linéaire.\
	_Cette question nécessite une réflexion algorithmique non-triviale. Plus encore que pour les autres questions, *faites des dessins sur une feuille*._