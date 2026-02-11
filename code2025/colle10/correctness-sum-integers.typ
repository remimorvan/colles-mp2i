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
  title: [Correction 10A1/10B1 : Correction d'une fonction récursive]
)
#set enum(numbering: "1.a.")

= Correction 10A1/10B1 : Correction d'une fonction récursive

```ocaml
let sum_integers n =
  let rec aux k acc =
    assert(k >= 0);
    if k = 0 then
      acc
    else
      aux (k-1) (k+acc)
  in aux n 0;;
```

Montrons par récurrence sur $k in NN$ que $#raw("aux k acc") = #raw("acc") + sum_(i=0)^k i$.
Pour $k=0$, la propriété est vraie puisque $#raw("aux 0 acc")$ retourne `acc`.
Soit $k in NN$ tel que la propriété est vraie au rang $k$.
Alors $ #raw("aux (k+1) acc") = #raw("aux k (k+1+acc)") $
et par hypothèse de récurrence, cette dernière quantité vaut
$(#raw("acc") + k + 1) + sum_(i=0)^k i = #raw("acc") = sum_(i=0)^(k+1) i$,
donc la propriété est vraie au rang $k+1$.
Or `sum_integers n` retourne `aux n 0`, qui vaut donc $0 + sum_(i=0)^n i = frac(n(n+1),2).$