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
  title: [Correction 9B3 : Correction et complexité d'une fonction récursive]
)
#set enum(numbering: "1.a.")

= Correction 9B3 : Correction et complexité d'une fonction récursive

Par soucis de lisibilité, on renomme les valeurs `a` et `b`
de l'énoncé en `a` et `b`.

```ocaml
let fibo n =
	assert(n>=0);
  let rec fibo_aux k a b =
		if k = n then
			b
		else
			fibo_aux (k+1) b (a + b)
  in fibo_aux 0 1 1;;
```

En regardant les valeurs retournées par `fibo n` pour des petites valeurs de $n$, on conjecture que `fibo n` $= f_{n+1}$.
On donne ici deux preuves de ce fait :
- la première preuve rentre parfaitement dans les clous du cours, en démontrant par   
  récurrence la valeur retournée par `fibo_aux`
- la deuxième preuve ne rentre pas vraiment dans le cadre des théorèmes et
  méthodes vues en cours, mais est beaucoup plus courte.

== Première preuve

On donne d'abord une définition et un lemme avant de s'attaquer à la correction de l'algorithme.

*Définition.* Pour $a,b in NN$, on note
$("Fibo"(a, b, k))_(k in NN)$ la suite définie par récurrence
par $"Fibo"(a, b, 0) = a$, $"Fibo"(a, b, 1) = b$
et $ "Fibo"(a, b, k+2) = "Fibo"(a, b, k) + "Fibo"(a, b, k+1) $ pour $k in NN$.

*Lemme.* Pour tout $a, b, k in NN$, $"Fibo"(a, b, k+1) = "Fibo"(b, a+b, k)$.

*Preuve.* Soit $a,b in NN$. On montre par récurrence double sur $k in NN$ que
$"Fibo"(a, b, k+1) = "Fibo"(b, a+b, k)$. Pour $k=0$, les deux quantités valent $b$
et sont donc égales. De même, pour $k=1$, les deux quantités valent $a+b$.
Si la propriété est vraie au rangs $k in NN$ et $k+1$,
alors $"Fibo"(a, b, k+3) = "Fibo"(a, b, k+1) + "Fibo"(a, b, k+2)$
et donc, en utilisant l'hypothèse de récurrence aux rangs $k$ et $k+1$,
$"Fibo"(a, b, k+3) = "Fibo"(b, a+b, k) + "Fibo"(b, a+b, k+1) 
= "Fibo"(b, a+b, k+2)$. CQFD.

*Correction.*
À l'aide de ce lemme, on va maintenant démontrer la correction de la fonction.
On commence par démontrer par récurrence sur $k in [|0,n|]$ que
$ \(cal(H)_k\): #raw("fibo_aux (n-k) a b") =
"Fibo"(#raw("a"), #raw("b"), k+1). $
- Si $k = 0$, alors $#raw("fibo_aux n a b") = #raw("b") = "Fibo"(#raw("a"), #raw("b"), 1)$, et donc $\(cal(H)_0\)$.
- Soit $k in [|0,n-1|]$ tel que $\(cal(H)_k\)$. Or
  $ #raw("fibo_aux (n-k-1) a b")
    = #raw("fibo_aux (n-k) b (a + b)"),
  $ et comme $\(cal(H)_k\)$, on en déduit que
  $ #raw("fibo_aux (n-k-1) a b")
    = "Fibo"(#raw("b"), #raw("a + b"), k+1),
  $
  qui, par le lemme, est égal à
  $"Fibo"(#raw("a"), #raw("b"), k+2)$,
  et donc $\(cal(H)_(k+1)\)$.
Ainsi, pour tout $k in [|0,n|]$, $\(cal(H)_k\)$.

Or, pour $n in NN$ `fibo n` retourne `fibo_aux 0 1 1`, qui vaut
$"Fibo"(1, 1, n+1) = f_(n+1)$ par $\(cal(H)_n\)$.
Ainsi, on a bien montré que pour tout $n in NN$, `fibo n` $= f_(n+1)$.

*Remarque.* Si on voulait calculer $f_n$ à la place, il suffirait dans le cas $k=n$
de retourner `a` plutôt que `b`.

== Deuxième preuve

_Inspiré de la copie de Matthias RINUCCINI._

La fonction `fibo_aux k a b` est *récursive terminale*, donc son arbre d'appels 
récursifs est *filiforme*, c'est-à-dire chaque nœud qui n'est pas une feuille n'a
exactement qu'un enfant.
On note donc $k_m$, $a_m$, $b_m$ ($m$ entier) la liste des valeurs
prises par les arguments de `fibo_aux` lorsque l'on appelle
`fibo_aux 0 1 1`.

Montrons par récurrence sur $m in [|0,n|]$ que $k_m = m$, $a_m = f_m$
et $b_m = f_(m+1)$.
- Par définition, $(k_0, a_0, b_0) = (0, 1, 1) = (0, f_0, f_1)$.
- Soit $m in [|0,n-1|]$ tel que $k_m = m$, $a_m = f_m$
  et $b_m = f_(m+1)$.
  Alors $k_(m+1) = k_m + 1 = m+1$, $a_(m+1) = b_m = f_(m+1)$ et $b_(m+1) = a_m + b_(m) = f_m + f_(m+1) = f_(m+2)$.
Ainsi, pour tout $m in [|0,n|]$, on a $k_m = m$, $a_m = f_m$
et $b_m = f_(m+1)$. Or `fibo_aux n a b` retourne `b`, qui vaut donc à ce moment là $b_n = f_(n+1)$.
Ainsi, pour tout $n in NN$, `fibo n` retourne $f_(n+1)$.