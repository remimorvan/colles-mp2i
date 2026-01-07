#import "@preview/tdtr:0.4.3" : *
#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

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
  title: [Colle 8]
)
#set enum(numbering: "1.a.")

= Colle 8 · Sujet

*_À lire avant toute chose :_*
Apportez du soin à la qualité de vos réponses plus qu'à la quantité, et pensez à écrire des tests. 
Il faudra faire un premier rendu sur Moodle à la fin de la colle. Vous avez la possibilité de faire
un second rendu, également sur Moodle, jusqu'à ce dimanche à midi. Vous pouvez me contacter
par mail à l'adresse `remi@morvan.xyz`.

Lisez les exercices dans leur intégralité avant de vous lancer et ayez toujours de quoi écrire
devant vous. *#text(red)[Tout fichier rendu doit pouvoir être
compilé (en C), ou interprété (OCaml) sans erreur ni warning,
et contenir des tests codés en dur avec des assert.]*


== Exercice : Anagrammes en OCaml

_Fichier à rendre sous le nom `NOM-anagram.ml`._

Le but de cet exercice est de déterminer si deux chaînes de caractères sont des *anagrammes*,
c'est-à-dire si l'une peut être obtenue en permutant les caractères de l'autre.
Rien de plus simple pour déterminer si deux chaînes de caractères sont des anagrammes :
il suffit de compter le nombre d'occurrences de chaque caractère dans la chaîne, et
ces valeurs sont égales si et seulement si les deux chaînes sont des anagrammes.
Par exemple, "niche" est un anagramme de "chien",
"la crise économique" et "le scénario comique" sont des anagrammes, mais
en revanche "être ou ne pas être, voilà la question" n'est
pas un anagramme de "oui et la poser n'est que vanité orale" (la première chaîne contient deux 'ê' alors que la seconde non).#footnote[Ce sont en revanche des anagrammes si on ignore les espaces, les accents et la ponctuation. (Source : #link("https://www.topito.com/top-anagramme-retourner-cerveau")[topito.com].)]

Pour résoudre notre problème, je vous propose d'utiliser une *liste d'association*,
qui est une liste de type ```ocaml ('a * 'b) list```, 
de sorte que si $(c,v)$ et $(c',v')$ sont tous deux éléments de la liste, alors $c != c'$.
Autrement dit, une liste d'association encode une fonction qui associe des éléments
de type `'a` (appelés *clés*) à des éléments de type `'b` (appelés *valeurs*).
Par exemple, dans la liste\
```ocaml [('a', 1); ('b', 5); ('c', 0)]```\
de type ```ocaml (char * int) list```, on a associé la valeur 1 à 'a', 5 à 'b', et 0 à 'c'.
+
	+ Définir une fonction\
		```ocaml is_defined: ('a * 'b) list -> 'a -> bool```\
		qui prend une liste d'association, une clé, et détermine si une valeur lui est associée.
	+ Définir une fonction\ 
		```ocaml get_value: ('a * 'b) list -> 'a -> 'b```\
		qui prend une liste d'association, une clé, et retourne la valeur qui lui est associée
		(si elle existe, sinon elle produit une erreur).
	+ Définir une fonction\ 
		```ocaml update_value: ('a * 'b) list -> 'a -> 'b -> ('a * 'b) list```\
		qui prend une liste d'association, une clé $c$ , une valeur $v$ et qui retourne une nouvelle liste d'association
		où la nouvelle valeur de la clé $c$ est $v$.
		_Si la clé n'est pas présente, on se contentera d'ajouter la paire (c,v) à la liste. Sinon, on modifiera
		la valeur présente dans la liste._
	+ Écrivez une fonction\
		```ocaml count_chars_of_str: string -> (char * int) list```
		qui étant donné une chaîne de caractères, retourne une liste d'association comptant le nombre d'occurrences
		de chaque caractère.
+ 
	+ De quelle(s) fonction(s) sur les listes d'associations auriez-vous besoin pour déterminer,
		à l'aide de la fonction `count_chars_of_str`, si deux chaînes sont des anagrammes ?
		Implémentez ces fonctions annexes.
	+ En déduire une fonction\
		```ocaml are_anagrams: string -> string -> bool```
		qui détermine si deux chaînes sont des anagrammes.
	+ Donnez une borne supérieure (raisonnable) sur la complexité temporelle de votre fonction
		`count_chars_of_str`, puis de votre fonction `are_anagrams`.


== Exercice : Crible d'Ératosthène en C

_Fichier à rendre sous le nom `NOM-eratosthene.c`._

Le crible d'Ératosthène est un algorithme permettant de déterminer tous les nombres premiers plus petits qu'un entier $m$
passé en entrée.
L'algorithme repose sur une observation élémentaire : pour tout nombre naturel $k >= 2$, tous ses multiples de la forme $k * i$ avec $i > 1$ sont forcément composés. En fait, la réciproque est aussi vraie, par définition d'un nombre premier.
Le crible d'Ératosthène fonctionne en identifiant tous les entiers composés : ceux qui restent sont les nombres premiers !
L'algorithme maintient un tableau, qui contient l'information de si un nombre est composé ou premier (jusqu'à preuve du contraire). 
Initialement, tous les nombres sont supposés premiers, sauf 0 et 1. On commence par éliminer tous
les multiples de 2 (c'est-à-dire qu'on déclare tous les nombres de la forme $2*i$ avec $i > 1$ comme étant composés),
puis tous les multiples de 3, puis de 4, etc, jusqu'à $m-1$.
+ Exécutez cet algorithme à la main pour $m = 20$.
+ Quand est venue l'étape d'éliminer les multiples de 4, avez-vous éliminé des nombres qui étaient encore supposés être premiers ? Expliquez pourquoi, puis proposez une amélioration de l'algorithme.
+ Écrire une fonction\
	```c void remove_multiples(int *arr, int n, int k)```\
	qui prend en entrée un tableau `arr`, rempli de 0 et de 1, de taille $n$, ainsi qu'un entier $k$, et qui définit la valeur de
	`arr[k*i]` à 0 pour tous les $i > 1$.
+ En déduire une fonction\
	```c int* sieve_eratosthenes(int m)```\ 
	qui prend en entrée un entier $n$, et retourne un tableau de taille $m$,
	dont la $i$-ème entrée vaut $1$ si $i$ est premier, et $0$ sinon.
+ Donner une borne supérieure sur la complexité spatiale et temporelle de la fonction `remove_multiples` puis de la fonction `sieve_eratosthenes`.
+ On peut remarquer que si un nombre $n$ est composé, alors un de ses facteurs est forcément plus petit que $sqrt(n)$ (preuve, par l'absurde : si d'aventure $n$ pouvait s'écrire $k_1 dot k_2$ avec $k_1 > sqrt(n)$ et $k_2 > sqrt(n)$ alors on aurait $n = k_1 dot k_2 > sqrt(n) dot sqrt(n) = n$ : que nenni !). En déduire une amélioration de la fonction `sieve_eratosthenes`. Que deviennent ses complexités spatiales et temporelles ?
