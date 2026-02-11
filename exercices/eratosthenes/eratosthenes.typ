#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Crible d'Ératosthène],
  language: "c",
  difficulty: 2,
  themes: ("I/O", "tableaux", "complexité", "arithmétique")
)

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
	```c void remove_multiples(int arr[], int n, int k)```\
	qui prend en entrée un tableau `arr`, rempli de 0 et de 1, de taille $n$, ainsi qu'un entier $k$, et qui définit la valeur de
	`arr[k*i]` à 0 pour tous les $i > 1$.
+ En déduire une fonction\
	```c int* sieve_eratosthenes(int m)```\ 
	qui prend en entrée un entier $m$, et retourne un tableau de taille $m$,
	dont la $i$-ème entrée vaut $1$ si $i$ est premier, et $0$ sinon.
+ Donner une borne supérieure sur la complexité spatiale et temporelle de la fonction `remove_multiples` puis de la fonction `sieve_eratosthenes`.
+ On peut remarquer que si un nombre $n$ est composé, alors un de ses facteurs est forcément plus petit ou égal à $sqrt(n)$ (preuve, par l'absurde : si d'aventure $n$ pouvait s'écrire $k_1 dot k_2$ avec $k_1 > sqrt(n)$ et $k_2 > sqrt(n)$ alors on aurait $n = k_1 dot k_2 > sqrt(n) dot sqrt(n) = n$ : que nenni !). En déduire une amélioration de la fonction `sieve_eratosthenes`. Que deviennent ses complexités spatiales et temporelles ?
+ Faire en sorte qu'à l'exécution de votre programme, l'utilisateur
	doive saisir un entier $m$ ; votre programme écrira alors ensuite l'ensemble des entiers strictement plus petits que $m$ dans un fichier
	`./primes.txt`.