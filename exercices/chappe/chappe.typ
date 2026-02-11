#import "@preview/cetz:0.4.2"

#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Télégraphe de Chappe en milieu montagneux],
  language: "c",
  difficulty: 3,
  themes: ("tableaux", "récursivité", "complexité", "I/O")
)

#figure(
	image("./chappe.png", width:30%),
	caption: [_#link("https://commons.wikimedia.org/wiki/File:T2-_d056_-_Fig._18._%E2%80%94_T%C3%A9l%C3%A9graphe_de_Chappe.png")[Télégraphe de Chappe]_, Louis Figuier.]
) <chappe>

Le *télégraphe de Chappe* est un système de télégraphe datant
de la fin du XVIIIème siècle, qui permet la transmission
d'un message de façon *visuelle*. Des tours comme celles
de la @chappe sont placées à intervalle régulier. Au sommet
de ses tours se trouvent deux bras articulés, qui selon leurs 
positions, encodent une information. Une première tour
transmet cette suite d'information, qui est réceptionné par une deuxième tour, qui la transmet à son tour, etc.

Ce système était redoutablement efficace : les tours étaient séparées d'une quinzaine de kilomètres, et il suffisait d'une dizaine de minutes pour transmettre un message entre Paris et Lille.

Le but de cet exercice est de déterminer *où construire des 
tours Chappe* pour transmettre un message entre une ville 
*A* et une ville *Z*, séparées par des montagnes.

Pour modéliser ce problème,
on se donne en entrée un tableau d'entiers.
Ce tableau relève l'altitude (assimilée à un entier)
sur la ligne droite reliant la ville *A* à la ville *Z*.
Par exemple, le tableau
```c {0,3,2,7,4,2,3,6,1}``` signifie que le point *A* est à
altitude $0$ et que le point *Z* est à altitude $1$.
On représente cette information visuellement de la façon suivante :
#figure(
	cetz.canvas({
		import cetz.draw: *
		let heights = (0,3,2,7,4,2,3,6,1)
		let max_height = 0
		for h in heights { if h > max_height {max_height = h} }
		line((0,0), (heights.len() - .5, 0), mark: (end: "barbed"))
		line((0,0), (0, max_height/2 + .5), mark: (end: "barbed"))
		for y in range(max_height+1) {
			line((-.07,y/2), (.07, y/2))
			content(((-.07,y/2)), [#y], padding: .13cm, anchor: "east")
		}
		for x in range(heights.len()) {
			circle((x, heights.at(x)/2), name: str(x), fill: black, radius: 1.5pt)
			// content((name: str(x), anchor: -90deg), [#heights.at(x)], padding: .13cm, anchor: "north")
		}
		content((name: str(0), anchor: -90deg), [*A*], padding: .13cm, anchor: "north")
		content((name: str(heights.len()-1), anchor: -90deg), [*Z*], padding: .13cm, anchor: "north")
		for x in range(heights.len()-1) {
			line(str(x), str(x+1), stroke:(dash: "solid"))
		}
	}),
	caption: [Visualisation du profil topographique décrit par le tableau
	```c {0,3,2,7,4,2,3,6,1}```.],
) <chappe-visu>
On suppose qu'une tour se trouve au point *A*, et une autre au point *Z*.
Le but de l'exercice est de *déterminer à quels points il faut placer une tour*, sous les contraintes suivantes :
- deux tours consécutives doivent pouvoir se voir mutuellement,
- on souhaite minimiser le nombre de tours (ça coûte cher : en plus de la construction, il y a un employé dans chaque tour).

+ Écrire une fonction\
	```c int are_mutually_visible(int elevation[], int x1, int x2)```\
	qui prend en entrée le tableau `elevation`
	décrivant le profil topographique, et deux indices `x1` et `x2` de ce tableau, et qui détermine si, si des tours étaient placées au point d'abscisse `x1` et d'abscisse `x2`, alors ces tours pourraient se
	voir mutuellement.
	
	#figure(
		cetz.canvas({
			import cetz.draw: *
			let heights = (0,3,2,7,4,2,3,6,1)
			let max_height = 0
			for h in heights { if h > max_height {max_height = h} }
			line((0,0), (heights.len() - .5, 0), mark: (end: "barbed"))
			line((0,0), (0, max_height/2 + .5), mark: (end: "barbed"))
			for y in range(max_height+1) {
				line((-.07,y/2), (.07, y/2))
				content(((-.07,y/2)), [#y], padding: .13cm, anchor: "east")
			}
			for x in (0,1,3,7) {
				line((x,-.07), (x,.07))
				content(((x,-.07)), [#x], padding: .13cm, anchor: "north")
			}
			for x in range(heights.len()) {
				circle((x, heights.at(x)/2), name: str(x), fill: black, radius: 1.5pt)
				// content((name: str(x), anchor: -90deg), [#heights.at(x)], padding: .13cm, anchor: "north")
			}
			for x in range(heights.len()-1) {
				line(str(x), str(x+1), stroke:(dash: "solid"))
			}
			line(str(0), str(3), stroke:(paint: blue, dash: "dashed"))
			line(str(3), str(7), stroke:(paint: red, dash: "dashed"))
		}),
		caption: [
			Lignes droites entre les points d'abscisse `x1` $= 0$ et `x2` $= 3$ (bleu),\
			et entre `x1` $= 3$ et `x2` $= 7$ (rouge)
			pour le profil ```c {0,3,2,7,4,2,3,6,1}```.],
	) <chappe-visu-mutually-visible>
	Par exemple (voir la @chappe-visu-mutually-visible), les tours
	entre `x1` $= 3$ et `x2` $= 7$ peuvent se voir,
	mais celles en `x1` $= 0$ et `x2` $= 3$ ne le peuvent pas puisque le point d'abscisse $1$
	bloque leur champ de vision.
+ Écrire une fonction\
	```c int is_solution_valid(int elevation[], int towers[], int n)```\
	qui détermine si une solution `towers` au problème `elevation` est 
	*valide*. `towers` et `elevations` sont des tableaux de taille $n$, et `towers` sera tel que
	`towers[i]` vaut 1 si on y a construit une tour, et 0 sinon.
	Par *valide*, on entend qu'un message peut être transmis de *A* à *Z*
	en utilisant ces tours : on ne cherche pas à déterminer si cette solution
	minimise le nombre de tours.
+ Nous allons implémenter des solutions au problème des tours de Chappe
	avec des algorithmes récursifs.
	On place initialement des tours aux points d'abscisses $0$ et $n-1$ ($n$ étant le nombre d'entrées),
	correspondant aux points *A* et *Z*. On va ensuite déterminer
	s'il y a besoin de construire une nouvelle tour. Si ce n'est pas le cas, l'algorithme termine. Sinon, on détermine un point *M*, situé entre *A*
	et *Z*, où construire une tour. On appelle alors récursivement cette procédure entre les points *A* et *M*, et entre les points *M* et *Z*.
	Différents algorithmes pour déterminer ce point *M* où construire une
	tour intermédiaire donneront différents algorithmes pour résoudre le problème.
	+ Exécutez cet algorithme à la main (_sur papier_) sur l'exemple
		de @chappe lorsque la stratégie pour choisir *M* est de prendre un point
		d'altitude maximal. (_Pas besoin de rendre cette question : vous 
		pouvez m'appeler pour me montrer vos exemples._)
	+ Écrivez une fonction\
		```c int *build_towers_highest(int elevation[], int n)```\
		qui implémente cet algorithme. En entrée, on prendra le profil 
		topographique, et on retournera un tableau de 0/1 de même taille,
		dont la $i$-ème entrée vaut 1 ssi on a construit une tour au
		point d'abscisse $i$.
	+ Quelle est la complexité temporelle de cette fonction ?
	+ Montrez que cette stratégie ne minimise pas le nombre de tours 
		construites. 
+ On change désormais de stratégie pour choisir *M* :
	pour tout point d'abscisse $x$, on considère son altitude $y(x)$
	et l'ordonnée $y'(x)$ du point d'abscisse $x$ sur la droite $(#text[*A*]#text[*Z*])$. On choisit *M* comme étant le point pour lequel $y(x) - y'(x)$ est maximal. Vous remarquerez que $y(x) - y'(x) > 0$ ssi le point d'abscisse $x$ entrave la vision entre *A* et *Z*. En un sens, le
	point *M* représente donc le point qui entrave le plus la vision entre
	les tours *A* et *Z*.
	+ Exécutez cet algorithme à la main sur l'exemple que vous avez trouvé à
		la question 3d.
	+ Écrivez une fonction\
		```c int *build_towers_biggest_obstruction(int elevation[], int n)```\
		qui implémente cet algorithme.
+ On admet qu'une solution est *optimale* si, et seulement si,
	pour tout point *M* où l'on a placé une tour,
	pour toute tour *G* strictement à gauche de *M*, pour toute tour
	*R* (_right_) située à droite de *M*, alors *M* entrave la vision
	entre *G* et *R*.
	+ Implémentez une fonction\
		```c int is_solution_optimal(int elevation[], int towers[], int n)```\
		qui détermine si une solution est optimale.
	+ Vérifiez empiriquement que les solutions calculées par
		`build_towers_biggest_obstruction` sont optimales.
+ Faire en sorte que, à l'exécution de votre programme, celui-ci demande
	à l'utilisateur de saisir le profil d'élévation (on rentrera un entier par ligne).
	Le programme affichera la solution en listant
	les abscisses des points où il y a des tours.