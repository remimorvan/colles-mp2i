#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Correction d'un calcul de Fibonacci],
  language: "théorique",
  difficulty: 3,
  themes: ("correction", ),
) 

On considère la fonction suivante en OCaml.
```ocaml
let fibo n =
	assert(n>=0);
  let rec fibo_aux k a b =
		if k = n then
			b
		else
			fibo_aux (k+1) a (a + b)
  in fibo_aux 0 1 1;;
```
La personne qui a écrit cette fonction souhaitait que ```fibo n``` retourne le $n$-ème terme $f_n$
de la suite de Fibonacci, où $f_0 = f_1 = 1$ et $f_(n+2) = f_(n) + f_(n+1)$ pour tout $n in NN$.
Ce n'est malheureusement pas tout à fait le cas. Que calcule ```fibo n``` ? Prouvez-le.