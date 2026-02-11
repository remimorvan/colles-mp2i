#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Triangle de Sierpiński],
  language: "c",
  difficulty: 3,
  themes: ("tableaux", "récursivité", "complexité", "terminaison", "I/O")
)

Le *triangle de Sierpiński* est une figure fractale, représentée sur la @sierpinski, et découverte en 1915 par le mathématicien
Wacław Sierpiński.
C'est probablement l'une des figures fractales les plus simples à construire, grâce
à son étonnant rapport avec les coefficients binomiaux.
Le but de cet exercice est d'afficher cette fractale.
#figure({
		let triangle = read("sierpinski.txt")
		text(size: 0.05em, weight: "bold", raw(triangle, block: true))
	},
  caption: [Le triangle de Sierpiński.],
	kind: image
) <sierpinski>
+ En utilisant la formule de Pascal, qu'on rappelle être
	$ binom(n,k) = binom(n-1,k-1) + binom(n-1,k) $
	pour $n in NN$ et $k in [|1,n-1|]$, écrire une fonction récursive, la plus simple possible,\
	```c int binom_naive(int k, int n)```\
	qui calcule $binom(n,k)$, sous réserve que $n >= 0$ et $k in [|0,n|]$.
	On ne cherchera *pas* à optimiser cette fonction.
+ Justifiez que cette fonction termine, puis donnez une borne supérieure (raisonnable) sur la complexité temporelle de 	```c binom_naive(int k, int n)```, en fonction de $n$.
+ Écrire une fonction\
	```c void print_sierpinski_naive(int n)```\
	qui prend en entrée un entier n, et affiche $n+1$ lignes du triangle de Pascal, c'est-à-dire que sur la $m$-ième ligne ($m in [|0,n|]$),
	on affichera les coefficients binomiaux $binom(m,0), binom(m,1), ..., binom(m,m)$. Vous devriez remarquer que votre fonction est relativement lente à s'exécuter dès que $n$ s'approche de \~20.
+ *Modifiez* la fonction précédente pour qu'au lieu d'afficher l'entier $binom(m,k)$, elle affiche le caractère '█' si $binom(m,k)$ est 	
	impair, et le caractère espace sinon. Tada !
+ Tout ceci est bien joli, mais fort peu efficace. Pour améliorer notre algorithme, on va partir de l'observation que 
	si l'on connaît tous les coefficients binomiaux de la forme $binom(n-1,-)$, alors on peut calculer
	$binom(n,k) = binom(n-1,k-1) + binom(n-1,k)$ en temps constant ($n in NN without \{0\}, k in [|0,n|]$).
	Écrire une fonction\
	```c int *binom_list(int n, int *coefs_prec)```\
	qui prend un entier $n in NN$, et le tableau des coefficients binomiaux d'ordre $n-1$, càd le tableau ${binom(n-1,0), binom(n-1,1), ..., binom(n-1,n-1)}$, et qui retourne le tableau des coefficients binomiaux d'ordre $n$. Lorsque $n = 0$, on pourra supposer
	que le pointeur passé en entrée est ```c NULL```.
+ Donnez une borne supérieure sur la complexité temporelle de votre fonction ```c binom_list```,
	en fonction de $n$.
+ En déduire une fonction\
	```c void print_sierpinski(int n)```\
	qui affiche les lignes $0$ à $n$ du triangle de Sierpiński, calculée avec la fonction ```c binom_list```.
	Vous ferez particulièrement attention à ne pas avoir de fuite mémoire.
+ *Bonus (à faire seulement si tous les autres exercices sont finis, ou chez vous) :*\
	Améliorer votre fonction ```c print_sierpinski``` pour que votre figure ressemble à celle de la @sierpinski
	(càd pour que la pointe de votre triangle soit centrée et non alignée à gauche).  
	Faire en sorte que pouvoir passer en argument à l'exécutable le nombre de lignes du triangle
	que l'on souhaite afficher. Pour rappel, dans le prototype\
	```c int main(int argc, char *argv[])```\
	`argc` désigne le nombre d'arguments passés à l'exécutable, et `argv` est un tableau de chaînes 
	de caractères contenant ces arguments.
