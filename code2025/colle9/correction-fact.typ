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
  title: [Correction 9A3 : Correction et complexité d'une fonction récursive]
)
#set enum(numbering: "1.a.")

= Correction 9A3 : Correction et complexité d'une fonction récursive

```ocaml
let fact n =
	assert(n >= 0);
  let rec fact_aux n acc =
    if n = 0 then
			acc
    else
			fact_aux (n - 1) (n * acc)
  in fact_aux n 1
```

*Terminaison.*
Pour montrer que la fonction `fact` termine sur toute entrée,
il suffit de montrer que la fonction `fact_aux` termine sur toute entrée
`n acc` telle que `n >= 0` (condition assurée par le assert).
On considère le variant $n$ :
- il décroît à chaque appel récursif puisque l'appel se fait avec la valeur $n-1$
- il est positif puisque initialement $n >= 0$ et, dès que $n=0$, l'algorithme termine.
On a donc un variant à valeur dans $NN$ et strictement décroissant : l'arbre des appels
récursifs est donc nécessairement fini, et ainsi `fact_aux` termine sur toute
entrée `n acc` telle que `n >= 0`. Puisque `fact n` se contente de vérifier que $n >= 0$
(le programme retourne une erreur et donc s'arrête si ce n'est pas le cas) puis d'appeler `fact_aux n acc`, on en déduit que `fact n` s'arrête sur toute entrée.

*Complexité.*
En notant $T(n)$ la complexité temporelle de `fact_aux n acc`, on a que
$T(0) = O(1)$ et $T(n+1) = T(n) + O(1)$, et donc $T(n) = O(n)$.
Par suite, la complexité temporelle de `fact n` est linéaire en $n$.

*Correction.*
On va montrer par récurrence sur $n in NN$ que `fact_aux n acc` $ = #raw("acc") * n!$.
Pour $n=0$, c'est vrai puisque $#raw("acc") * 0! = #raw("acc")$.
Supposons la propriété vraie au rang $n$. Alors `fact_aux (n+1) acc`
est égal à `fact_aux n ((n+1)*acc) `, qui par hypothèse de récurrence vaut 
$(n+1) * #raw("acc") * n! = #raw("acc") * (n+1)!$.
Ainsi, on a que `fact_aux n acc` $ = #raw("acc") * n!$ pour tout $n in NN$.
Comme `fact n` retourne `fact_aux n 1`, on en déduit que `fact n` vaut $n!$,
et donc que la fonction `fact` est correcte.