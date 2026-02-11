#import "@preview/cetz:0.4.2"

#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Couplage de Cantor],
  language: "ocaml",
  difficulty: 1,
  themes: ("récursivité",)
)

Le but de cet exercice est de calculer la bijection $f$ de $NN^2$ dans $NN$ représentée en @cantor, appelée
«~couplage de Cantor~».
L'idée derrière cette bijection est simplement d'énumérer les paires d'entiers par diagonale. Au sein d'une diagonale, 
on énumère les paires selon les $x$ croissants.
Ainsi, on a par exemple $f(0,0) = 0$, $f(0,1) = 1$ et $f(1,0) = 2$, comme représenté en @cantor.
L'exercice est à faire dans le langage de votre choix.
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
+ Définir une fonction *récursive*
	```c int bij(int x, int y)``` (en C) ou
	```ocaml bij: int * int -> int``` (en OCaml)
	calculant $f$.
// + Quelle est la complexité temporelle de `bij(x,y)`, en fonction de $x$, $y$ et $f(x,y)$ ?
// + Si votre fonction n'était pas *récursive terminale*, écrivez une nouvelle fonction qui l'est.
+ Vérifiez empiriquement que
$ f(x,y) = frac((x + y)(x + y + 1), 2) + x " pour " x, y in NN. $

_Pour la culture :_ 
Le couplage de Cantor a été introduit en 1873 par Georg Cantor.
Vous remarquerez que la fonction $f$ est un polynôme quadratique : en 1923, Rudolf Fueter et Georg Pólya
publient le théorème de Fueter–Pólya, qui affirme que $f$, et son symétrique $(x,y) mapsto f(y,x)$,
sont les *seules fonctions quadratiques* qui réalisent une bijection de $NN^2$ dans $NN$.
La conjecture Fueter–Pólya affirme elle que ce sont les *seules fonctions polynomiales* satisfaisant cette propriété.
À ce jour, la conjecture est encore ouverte !