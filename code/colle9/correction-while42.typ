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
  title: [Correction 9A1 : Correction d'une boucle while]
)
#set enum(numbering: "1.a.")

= Correction 9A1 : Correction d'une boucle while

```c
int get_first(int *arr, int n) {
	int i = 0;
	while (i < n && arr[i] < 42) {
		i++;
	}
	return i;
}
```

On souhaite montrer la fonction `get_first`, sur un tableau `arr`, de taille `n`, retourne
- le plus petit indice `i` tel que `arr[i] >= 42`, si un tel indice existe ;
- `n`, sinon.

*Terminaison.*
Soit `(arr, n)` une entrée de l'algorithme,
et soit $M in NN union \{+infinity\}$ le nombre d'itérations de la boucle.
On note $(i_k)_(0 < k < M)$ la suite des valeurs prises par la variable $i$,
c'est-à-dire que $i_k$ est la valeur de la variable $i$ à la fin de la $i$-ème 
itération de la boucle.
La seulement opération de la boucle consiste à incrémenter $i$,
et donc $i_(k+1) = i_k + 1$ pour tout $k in [|0,M-1|]$.
Comme $i_0 = 0$, une récurrence immédiate sur $k in [|0,M|]$ donne que $i_k = k$.
La condition de la boucle `i < n && arr[i] < 42` est donc atteinte quand $k=n$ (puisque $i_n = n$), ce qui montre que $M <= n$.
Ainsi, pour toute entrée `(arr, n)`, l'algorithme termine en au plus $n$ étapes.
#footnote[La terminaison peut aussi se démontrer en considérant le variant $n-i$ et/ou par l'absurde, mais c'est ici un peu overkill.]

*Correction.*
On considère l'invariant de boucle $cal(I)$: « $i in [|0,n|]$ et $#raw("arr")\[j] < 42$ pour tout $j in [|0,i-1|]$ ».
- L'invariant est vrai au début de la boucle puisque $i=0$.
- Supposons $cal(I)$ vrai au début
	d'une itération de la boucle, et montrons qu'il est vrai à la fin de cette itération.
	Pour toute variable `x` du code, on note `x` sa valeur au début de la boucle et `x'`
	sa valeur à la fin. Puisque l'on est rentré dans le corps de la boucle, on sait que $i < n$
	et $#raw("arr")\[i] < 42$. Or $i' = i+1$ donc du fait que $i < n$ on en déduit que $i' <= n$,
	et donc que $i' in [|0,n|]$ puisque $i' > i >= 0$ (par $(cal(I))$).
	En outre, (par $(cal(I))$) donne que $#raw("arr")\[j] < 42$ pour tout $j < i$,
	et la condition de la boucle donne que $#raw("arr")\[i] < 42$. Il s'en suit donc que
	$#raw("arr")\[j] < 42$ pour tout $j <= i$ i.e. pour tout $j < i'$.
	Ainsi, $(cal(I))$ est vrai à la fin de l'itération de la boucle.

Puisque l'algorithme termine, on sort de la boucle, et donc il existe un moment
où la condition de boucle
`i < n && arr[i] < 42` est fausse, et donc `i >= n` ou `arr[i] >= 42`.
- _1er cas: `i >= n`._ $(cal(I))$ donne que $i in [|0,n|]$, et donc $i = n$,
et que $#raw("arr")\[j] < 42$ pour tout $j < n$.
- _2nd cas: `i < n` et `arr[i] >= 42`_ Or $(cal(I))$ nous donne que $#raw("arr")\[j] < 42$ pour tout $j in [|0,i-1|]$, ce qui prouve que $i$ est le plus petit indice tel que `arr[i] >= 42`.

Ainsi, l'algorithme `get_first`,
sur un tableau `arr`, de taille `n`, retourne
- le plus petit indice `i` tel que `arr[i] >= 42`, si un tel indice existe ;
- `n`, sinon.