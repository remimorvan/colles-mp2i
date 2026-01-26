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
  title: [Correction 9B1 : Correction d'une boucle while]
)
#set enum(numbering: "1.a.")

= Correction 9B1 : Correction d'une boucle while

```c
int array_sum(int *arr, int n) {
	assert(arr != NULL);
	assert(n >= 0);
	int sum = 0;
	int i = 0;
	while (i < n) {
		sum = sum + arr[i];
		i++;
	}
	return sum;
}
```

*Terminaison.*
Soit `(arr, n)` une entrée de l'algorithme,
et soit $M in NN union \{+infinity\}$ le nombre d'itérations de la boucle.
On note $(i_k)_(0 < k < M)$ la suite des valeurs prises par la variable $i$,
c'est-à-dire que $i_k$ est la valeur de la variable $i$ à la fin de la $i$-ème 
itération de la boucle.
La seulement opération de la boucle consiste à incrémenter $i$,
et donc $i_(k+1) = i_k + 1$ pour tout $k in [|0,M-1|]$.
Comme $i_0 = 0$, une récurrence immédiate sur $k in [|0,M|]$ donne que $i_k = k$.
La condition de la boucle `i < n` est donc atteinte quand $k=n$ (puisque $i_n = n$), ce qui montre que $M <= n$.
Ainsi, pour toute entrée `(arr, n)`, l'algorithme termine en au plus $n$ étapes.
#footnote[La terminaison peut aussi se démontrer en considérant le variant $n-i$ et/ou par l'absurde, mais c'est ici un peu overkill.]

*Complexité.*
La preuve précédente montre que l'on fait au plus $n$ itérations de la boucle.
Chaque itération étant en temps constant, on en déduit que 
```c array_sum(arr, n)``` s'exécute en temps linéaire en $n$.

*Correction.*
On considère l'invariant de boucle $cal(I)$: « $i in [|0,n|]$ et
$#raw("sum") = sum_(k=0)^(i-1) #raw("arr")\[k]$ ».
- L'invariant est vrai au début de la boucle puisque $i=0$ et $#raw("sum") = 0$.
- Supposons $cal(I)$ vrai au début
	d'une itération de la boucle, et montrons qu'il est vrai à la fin de cette itération.
	Pour toute variable `x` du code, on note `x` sa valeur au début de la boucle et `x'`
	sa valeur à la fin. Puisque l'on est rentré dans le corps de la boucle, on sait que $i < n$. La boucle se contente de modifier `sum` et `i`.
	D'une part $#raw("i'") = #raw("i") + 1$ et donc $i' <= n$.
	D'autre part $#raw("sum'") = #raw("sum") + #raw("arr")\[i]$,
	donc en utilisant $cal(I)$ il vient que
	$ #raw("sum'") = sum_(k=0)^(i-1) #raw("arr")\[k] + #raw("arr")\[i] =
		sum_(k=0)^(i'-1) #raw("arr")\[k], $
	et donc $cal(I)$ est vrai à la fin de cette itération de la boucle.

Puisque l'algorithme termine, on sort de la boucle, et donc il existe un moment
où la condition de boucle
`i < n` est fausse, et donc `i >= n`.
Or par $cal(I)$ on sait que $i in [|0,n|]$ et donc $i=n$.
Toujours par $cal(I)$, on en déduit que $#raw("sum") = sum_(k=0)^(n-1) #raw("arr")\[k]$.
Ainsi, ```c array_sum(int *arr, int n)``` retourne la somme des `n` premiers éléments du tableau `arr` pour tout entier positif $n$.