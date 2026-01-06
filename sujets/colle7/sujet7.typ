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
  title: [Colle 7]
)
#set enum(numbering: "1.a.")

= Colle 7 · Sujet

*_À lire avant toute chose :_*
Apportez du soin à la qualité de vos réponses plus qu'à la quantité, et pensez à écrire des tests. 
Il faudra faire un premier rendu sur Moodle à la fin de la colle. Vous avez la possibilité de faire
un second rendu, également sur Moodle, jusqu'à ce dimanche à midi. Vous pouvez me contacter
par mail à l'adresse `remi@morvan.xyz`.

Lisez les exercices dans leur intégralité avant de vous lancer et ayez toujours de quoi écrire
devant vous. *#text(red)[Tout fichier rendu doit pouvoir être
compilé (en C), ou interprété (OCaml) sans erreur ni warning,
et contenir des tests codés en dur avec des assert.]*

== Exercice : Une bijection de $NN^2$ dans $NN$ en OCaml

_Fichier à rendre sous le nom `NOM-bijection.ml`._

#figure(
	cetz.canvas({
		import cetz.draw: *
		let n = 5
		for x in range(n) {
			for y in range(n) {
				circle((x,y), name: str(x)+"-"+str(y), radius: 1.5pt)
			}
		}
		set-style(line: (padding: 2pt))
		for d in range(n) {
			let y = d
			let x = 0
			while (y >= 1 and x < n - 1) {
				line(str(x)+"-"+str(y), str(x + 1)+"-"+str(y - 1), mark: (end: "barbed"))
				y -= 1
				x += 1
			}
			if (x < n - 1) {
				line(str(x)+"-"+str(y), str(0)+"-"+str(x + 1), mark: (end: "barbed"))
			}
		}
		for x in range(n) {
			for y in range(n) {
				set-style(content: (frame: "rect", stroke: none, fill: color.rgb(100%, 100%, 100%, 70%), padding: .02cm))
				content((name: str(x)+"-"+str(y), anchor: 45deg), text(size: .4em)[(#x, #y)], anchor: "south-west")
			}
		}
	}),
	caption: [Une bijection de $NN^2$ dans $NN$.],
) <cantor>
Le but de cet exercice est de calculer la bijection $f$ de $NN^2$ dans $NN$ représentée en @cantor.
L'idée derrière cette bijection est simplement d'énumérer les paires d'entiers par diagonale. Au sein d'une diagonale, 
on énumère les paires selon les $x$ croissants.
Ainsi, on a par exemple $f(0,0) = 0$, $f(0,1) = 1$ et $f(1,0) = 2$, comme représenté en @cantor.
+ Définir une fonction *récursive*
	```ocaml bij: int * int -> int```
	calculant $f$.
// + Quelle est la complexité temporelle de `bij(x,y)`, en fonction de $x$, $y$ et $f(x,y)$ ?
// + Si votre fonction n'était pas *récursive terminale*, écrivez une nouvelle fonction qui l'est.
+ Vérifiez empiriquement que
	$ f(x,y) = frac((x y)(x y+1), 2) + x text(" pour ") x, y in NN. $

== Exercice : Triangle de Sierpiński en C

_Fichier à rendre sous le nom `NOM-sierpinski.c`._

#figure({
		let triangle = read("sierpinski.txt")
		text(size: 0.05em, weight: "bold", raw(triangle, block: true))
	},
  caption: [Le triangle de Sierpiński.],
	supplement: "Figure",
) <sierpinski>
Le *triangle de Sierpiński* est une figure fractale, découverte en 1915 par le mathématicien
Wacław Sierpiński, et représentée sur la figure @sierpinski.
C'est probablement l'une des figures fractales les plus simple à construire, grâce
à son étonnant rapport avec les coefficients binomiaux.
Le but de cet exercice est d'afficher ce fameux triangle de Sierpiński.
+ En utilisant la formule de Pascal, qu'on rappelle être
	$ binom(n,k) = binom(n-1,k-1) + binom(n-1,k) $
	pour $n in NN$ et $k in [|1,n-1|]$, écrire une fonction récursive, la plus simple possible,\
	```c int binom_naive(int k, int n)```\
	qui calcule $binom(n,k)$, sous réserve que $n >= 0$ et $k in [|0,n|]$.
	On ne cherchera *pas* à optimiser cette fonction.
+ Démontrer que cette fonction termine.
+ Donnez une borne supérieure (raisonnable) sur la complexité temporelle de ```c binom_naive(int k, int n)```, en fonction de $n$.
+ Écrire une fonction\
	```c void print_sierpinski_naive(int n)```
	qui prend en entrée un entier n, et affiche $n+1$ lignes du triangle de Pascal, c'est-à-dire que sur la $m$-ième ($m in [|0,n|]$),
	on affichera les coefficients binomiaux $binom(m,0), binom(m,1), ..., binom(m,m)$. Vous devriez remarquer que votre fonction est relativement lente à s'exécuter dès que $n$ s'approche de \~20.
+ *Modifiez* la fonction précédente pour qu'au lieu d'afficher l'entier $binom(m,k)$, elle affiche la caractère '█' si $binom(m,k)$ est 	
	impair, et le caractère espace sinon. Tada !
+ Tout ceci est bien joli, mais fort peu efficace. Pour améliorer notre algorithme, on va partir de l'observation que 
	si l'on connaît tous les coefficients binomiaux de la forme $binom(n-1,-)$, alors on peut calculer
	$binom(n,k) = binom(n-1,k-1) + binom(n-1,k)$ en temps constant ($n in NN without \{0\}, k in [|0,n|]$).
	Écrire une fonction\
	```c int *binom_list(int n, int *coefs_prec)```
	qui prend un entier $n in NN$, et le tableau des coefficients binomiaux d'ordre $n-1$, càd le tableau ${binom(n-1,0), binom(n-1,1), ..., binom(n-1,n-1)}$, et qui retoune le tableau des coefficients binomiaux d'ordre $n$. Lorsque $n = 0$, on pourra supposer
	que le pointeur passé en entrée est ```c NULL```.
+ Donnez une borne supérieure sur la complexité temporelle de votre fonction ```c binom_list```,
	en fonction de $n$.
+ En déduire une fonction\
	```c void print_sierpinski(int n)```\
	qui affiche les lignes $0$ à $n$ du triangle de Sierpiński, calculée de la fonction ```c binom_list```.
	Vous ferez particulièrement attention à ne pas avoir de fuite mémoire.
+ *Bonus (à faire seulement si tout les autres exercices sont finis, ou chez vous) :*\
	Améliorer votre fonction ```c print_sierpinski``` pour que figure ressemble à celle de la @sierpinski
	(càd pour que la pointe de votre triangle soit centrée et non alignée à gauche).

== Exercice : Anagrammes

_Fichier à rendre sous le nom `NOM-anagram.ml`._

Le but de cet exercices est de déterminer si deux chaînes de caractères sont des *anagrammes*,
c'est-à-dire si l'une peut-être obtenue en permutant les caractères de l'autre.
Rien de plus simple pour déterminer si deux chaînes de caractères sont des anagrammes :
il suffit de compter le nombre d'occurence de chaque caractère dans la chaîne, et
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
	+ Écrivez une fonction\
		```ocaml count_chars_of_str: string -> (char * int) list```
		qui étant donné une chaîne de caractères, retourne une liste d'association comptant le nombre d'occurences
		de chaques caractères.
+ 
	+ De quelle(s) fonction(s) sur les listes d'associations auriez-vous besoin pour déterminer,
		à l'aide de la fonction `count_chars_of_str`, si deux chaînes sont des anagrammes ?
		Implémentez ces fonctions annexes.
	+ En déduire une fonction\
		```ocaml are_anagrams: string -> string -> bool```
		qui détermine si deux chaînes sont des anagrammes.
	+ Donnez une borne supérieure (raisonnable) sur la complexité temporelle de votre fonction
		`count_chars_of_str`, puis de votre fonction `are_anagrams`.

== Exercice : Tri d'un tableau en temps linéaire

_Fichier à rendre sous le nom `NOM-bounded-sort.c`._

Le but de cet exercice est de trier un tableau d'entiers *positifs*, lorsque l'on connait une *borne (strictement)
supérieure $b$ sur les entrées du tableau*.
L'idée de l'algorithme est le suivant : 
on va créer un nouveau tableau `count` provisoire, de taille $b$, qui va compter le nombre d'occurences de chaque élément :
plus précisément ```c count[i]``` (pour $i in [|0,B[|$) sera le nombre d'éléments du tableau d'entrée égaux à $i$.
À partir de tableau, on pourra alors trier le tableau d'origine.
+ Écrire une fonction\
	```c void bounded_sort(int *arr, int *n, int *b)```\
	qui prend en entrée un tableau `arr` de taille `n`, dont les entrées sont toutes comprises entre $0$ (inclus) et $b$ (exclus),
	et qui trie le tableau `arr` avec la méthode décrite précédemment.
+ Quelle est la complexité en temps et en espace de cet algorithme, dans le pire cas ? Dans le meilleur cas ?
+ Pour quels types de tableaux cet algorithme est-il bien plus intéressant à utiliser plutôt qu'un algorithme de tri
	par comparaison s'exécutant au pire cas en temps $O(n log(n))$ ?
	_La réponse attendue n'est pas mathématique, mais une description en quelque mots de la « forme » des données._

== Exercice : Exponentiation rapide

_Fichier à rendre sous le nom `NOM-exp-square.ml`._

+ Implémentez, dans le langage de votre choix (C ou OCaml), un algorithme d'exponentiation rapide.
+ Quelle est sa complexité temporelle dans le pire cas ?
+ Justifiez sa terminaison.


== Exercice : Crible d'Ératosthène en C

_Fichier à rendre sous le nom `NOM-eratosthene.c`._

Le crible d'Érathosthène est un algorithme permettant de déterminer tous les nombres premiers plus petits qu'un entier $m$
passé en entrée.
L'algorithme repose sur une observation élémentaire : pour tout nombre naturel $k >= 2$, tous ses multiples de la forme $k * i$ avec $i > 1$ sont forcément composés. En fait, la réciproque est aussi vraie, par définition d'un nombre premier.
Le crible d'Érathosthène fonctionne en identifiant tous les entiers composés : ceux qui restent sont les nombres premiers !
L'algorithme maintient un tableau, qui contient l'information de si un nombre est composé ou premier (jusqu'à preuve du contraire). 
Initialement, tous les nombres sont supposés premiers, sauf 0 et 1. On commence par éliminer tous
les multiples de 2 (c'est-à-dire qu'on déclare tous les nombres de ma forme $2*i$ avec $i > 1$ comme étant composés),
puis tous les multiples de 3, puis de 4, etc, jusqu'à $m-1$.
+ Exécutez cet algorithme à la main pour $m = 20$.
+ Quand est venue l'étape d'éliminez les multiples de 4, avez-vous éliminé des nombres qui étaient encore supposés être premiers ? Expliquez pourquoi, puis proposez une amélioration de l'algorithme.
+ Écrire une fonction\
	```c void remove_multiples(int *arr, int n, int k)```\
	qui prend en entrée un tableau `arr`, rempli de 0 et de 1, de taille $n$, ainsi qu'un entier $k$, et qui défini la valeur de
	`arr[k*i]` à 0 pour tous les $i > 1$.
+ En déduire une fonction\
	```c int* sieve_eratosthenes(int m)```\ 
	qui prend en entrée un entier $n$, et retourne un tableau de taille $m$,
	dont la $i$-ème entrée vaut $1$ si $i$ est premier, et $0$ sinon.
+ Donner une borne supérieure sur la complexité spatiale et temporelle de la fonction `remove_multiples` puis de la fonction `sieve_eratosthenes`.
+ On peut remarquer que si un nombre $n$ est composé, alors un de ses facteurs est forcément plus petit que $sqrt(n)$ (preuve, par l'absurde : si d'aventure $n$ pouvait s'écrire $k_1 dot k_2$ avec $k_1 > sqrt(n)$ et $k_2 > sqrt(n)$ alors on aurait $n = k_1 dot k_2 > sqrt(n) dot sqrt(n) = n$ : que nenni !). En déduire une amélioration de la fonction `sieve_eratosthenes`. Que deviennent ses complexités spatiales et temporelles ?