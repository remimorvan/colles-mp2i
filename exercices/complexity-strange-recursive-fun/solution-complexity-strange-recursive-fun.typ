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
  title: [Correction 10A2 : Complexité d'une fonction récursive]
)
#set enum(numbering: "1.a.")

= Correction 10B2 : Complexité d'une fonction récursive

```ocaml
let rec foo a b = 
  if a <= 0 || b <= 0 then
    max a b
  else (
    let x = foo (a-1) b
    and y = foo a (b-1) in
    if x <= y then
      2 * x
    else
      a * a + x
  );;
```

*Terminaison.* La seule méthode que vous avez vue en cours pour démontrer la terminaison d'une fonction
récursive est d'utiliser un *variant à valeurs dans $NN$*. La difficulté de cet exercice réside
dans le fait que la fonction `foo` a deux arguments, $a$ et $b$. Il faut donc trouver une quantité
dépendant de $a$ et $b$, à valeurs dans $NN$, et qui décroit strictement à chaque appel récursif.
On remarque que ces appels récursifs sont soit de la forme `foo (a-1) b` ou `foo a (b-1)`, càd que soit
$a$ soit $b$ est décrémenté, l'autre paramètre restant identique.
On a donc comme idée de choisir comme variant $a+b$. Cependant notre variant doit être à valeur dans $NN$,
et $a$ et $b$ peuvent être négatifs. *On prend donc comme variant $"max"(0, a+b)$.*

Par définition, il est à valeurs dans $NN$. En outre, on va montrer qu'il est strictement décroissant. Si $a <= 0$ ou $b <= 0$, alors l'algorithme termine. Sinon, $a > 0$ et $b > 0$,
donc $"max"(0, a+b) = a+b$. Les appels récursifs de la fonction sont `foo (a-1) b` et `foo a (b-1)`. Dans tous les cas, le variant
vaut $"max"(0, a+b-1) = a+b-1$ car $a > 0$ et $b > 0$, et donc $a+b-1 > 0$. Comme $a+b-1 < a+b$, on a donc bien que le variant décroit strictement à chaque appel récursif. Ainsi, la fonction
`foo` termine sur toute entrée.

*Complexité.* Comme pour la terminaison, le fait que `foo` prenne 
deux arguments complique un peu les choses.
On s'inspire donc la preuve de terminaison pour définir
$T(n)$ comme le maximum, sur $(a,b) in NN^2$ tel que $a+b = n$,
de la complexité temporelle de `foo a b`.#footnote[Pourquoi le maximum ? Car on cherche ici une borne sup sur la complexité.]


Soit $n in NN$. Soit $(a,b) in NN^2$ tel que $a+b = n$.
Soit $a <= 0$ ou $b <= 0$ et l'algorithme termine immédiatement.
Ou alors, on fait deux appels récursifs `foo (a-1) b` et
`foo a (b-1)`, et un nombre constants d'opérations arithmétiques. Chacun de ces appels 
récursifs a une complexité temporelle majorée par $T(n-1)$ car
$(a-1)+b = n-1$ et $a + (b-1) = n-1$.
On en déduit donc que la complexité temporelle de `foo a b` est
majorée par $2T(n-1) + O(1)$. On passant au max sur $(a,b) in NN^2$ tel que $a + b = n$, on en déduit que :
$ T(n) <= 2T(n-1) + O(1) $
et donc $T(n) in O(2^n)$.

*Ainsi, la fonction `foo` a une complexité temporelle constante si un de ses arguments est négatif, et au pire exponentielle en la somme des ses arguments sinon.*