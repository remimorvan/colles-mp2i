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
  title: [Colle 8 · Sujet P]
)
#set enum(numbering: "1.a.")

= Colle 8 · Sujet P

*_À lire avant toute chose :_*
Apportez du soin à la qualité de vos réponses plus qu'à la quantité, et pensez à écrire des tests. 
Il faudra faire un premier rendu sur Moodle à la fin de la colle. Vous avez la possibilité de faire
un second rendu, également sur Moodle, jusqu'à ce dimanche à midi. Vous pouvez me contacter
par mail à l'adresse `remi@morvan.xyz`.

Lisez les exercices dans leur intégralité avant de vous lancer et ayez toujours de quoi écrire
devant vous. *#text(red)[Tout fichier rendu doit pouvoir être interprété sans erreur,
et contenir des tests codés en dur avec des assert.]* 

== Exercice P1 : Tri fusion en Python

_Fichier à rendre sous le nom `NOM-merge-sort.py`._

On rappelle que le tri fusion est un algorithme de tri récursif
dont le principe est le suivant : on découpe la liste en deux,
on trie chaque moitié (récursivement), puis on fusionne les deux résultats.

Voici une implémentation partielle de cet algorithme.
```python
def merge(lst1, lst2):
    """Merges two sorted lists into a sorted list."""
    res = []
    i = j = 0
    while (i < len(lst1) or j < len(lst2)):
        if i == len(lst1):
            res.append(lst2[j])
            j+=1
        elif j == len(lst2):
            res.append(lst1[i])
            i+=1
        elif lst1[i] < lst2[j]:
            res.append(lst1[i])
            i+=1
        else:
            res.append(lst2[j])
            j+=1
    return res

def split(lst):
    """Takes a list and splits its content into
    two lists of equal length (±1 if the initial list has odd length)."""
    raise NotImplementedError

def merge_sort(lst):
    """Sorts a list using the merge sort algorithm."""
    raise NotImplementedError
```
+ Lisez le code de la fonction `merge`, et exécutez-la à la main sur
	la paire de listes ```python ([0,2,4,8], [0,1,3,3])```.
	Pourquoi les conditions ```python if i == len(lst1)``` et
	```python elif j == len(lst2)``` sont-elles nécessaires ? _(Appelez-moi pour répondre à cette question à l'oral.)_
+ En Python, si `lst` est une liste et $i$ et $j$ sont deux entiers,
	alors ```python lst[i:j]``` retourne la sous-liste comprise
	entre les indices $i$ (inclus) et $j$ (exclus).
	En déduire une implémentation *simple* de la fonction `split`.
+ Implémentez la fonction `merge_sort`, de manière récursive.

== Exercice P2 : Anagrammes en Python

_Fichier à rendre sous le nom `NOM-anagram.py`._

Le but de cet exercice est de déterminer si deux chaînes de caractères sont des *anagrammes*,
c'est-à-dire si l'une peut être obtenue en permutant les caractères de l'autre.
Rien de plus simple pour déterminer si deux chaînes de caractères sont des anagrammes :
il suffit de compter le nombre d'occurrences de chaque caractère dans la chaîne, et
ces valeurs sont égales si et seulement si les deux chaînes sont des anagrammes.
Par exemple, "niche" est une anagramme de "chien",
"la crise économique" et "le scénario comique" sont des anagrammes, mais
en revanche "être ou ne pas être, voilà la question" n'est
pas une anagramme de "oui et la poser n'est que vanité orale" (la première chaîne contient deux 'ê' alors que la seconde non).#footnote[Ce sont en revanche des anagrammes si on ignore les espaces, les accents et la ponctuation. (Source : #link("https://www.topito.com/top-anagramme-retourner-cerveau")[topito.com].)]

Pour résoudre notre problème, je vous propose d'utiliser un *dictionnaire*.
+ Écrivez une fonction\
	```python count_chars_of_str(s)```\
	qui étant donné une chaîne de caractères, retourne un dictionnaire associant à chaque caractère de la chaîne son nombre d'occurrences.
+ Écrire une fonction\
	```python are_dict_equal(d1,d2)```\
	qui détermine, sans utiliser la syntaxe `d1==d2`,
	si deux dictionnaires sont égaux.
	(On s'attend à ce que
	```python {'a': 1, 'b': 2}```
	soit égal à ```python {'b': 2, 'a': 1}```,
	mais que ```python {'c': 3}``` ne soit 
	pas égal à ```python {'c': 3, 'd': 4}```.
	Prenez soin de tester votre fonction sur ces exemples.)
+ Vérifiez que `==` permet aussi de tester l'égalité (au sens
	défini dans la question précédente) entre deux dictionnaires.
+ Déduire des questions précédentes une fonction\
	```python are_anagrams(s1, s2)```\
	qui détermine si deux chaînes sont des anagrammes.
+ Donnez une borne supérieure (raisonnable) sur la complexité temporelle de votre fonction
	`count_chars_of_str`, puis de votre fonction `are_anagrams`.

== Exercice P3 : Crible d'Ératosthène en Python

_Fichier à rendre sous le nom `NOM-eratosthenes.py`._

Le crible d'Ératosthène est un algorithme permettant de déterminer tous les nombres premiers plus petits qu'un entier $m$
passé en entrée.
L'algorithme repose sur une observation élémentaire : pour tout nombre naturel $k >= 2$, tous ses multiples de la forme $k * i$ avec $i > 1$ sont forcément composés. En fait, la réciproque est aussi vraie, par définition d'un nombre premier.
Le crible d'Ératosthène fonctionne en identifiant tous les entiers composés : ceux qui restent sont les nombres premiers !
L'algorithme maintient un tableau, qui contient l'information de si un nombre est composé ou premier (jusqu'à preuve du contraire). 
Initialement, tous les nombres sont supposés premiers, sauf 0 et 1. On commence par éliminer tous
les multiples de 2 (c'est-à-dire qu'on déclare tous les nombres de la forme $2*i$ avec $i > 1$ comme étant composés),
puis tous les multiples de 3, puis de 4, etc, jusqu'à $m-1$.
+ Exécutez cet algorithme à la main pour $m = 20$.
+ Quand est venue l'étape d'éliminer les multiples de 4, avez-vous éliminé des nombres qui étaient encore supposés être premiers ? Expliquez pourquoi, puis proposez une amélioration de l'algorithme.
+ Écrire une fonction\
	```python remove_multiples(lst, k)```\
	qui prend en entrée une liste `lst` de 0/1,
	et qui change la $k*i$-ème valeur de cette liste à 0 pour tout $i>1$.
+ En déduire une fonction\
	```python sieve_eratosthenes(m)```\ 
	qui prend en entrée un entier $m$, et retourne un tableau de taille $m$,
	dont la $i$-ème entrée vaut $1$ si $i$ est premier, et $0$ sinon.
+ Donner une borne supérieure sur la complexité temporelle de la fonction `remove_multiples` puis de la fonction `sieve_eratosthenes`.
+ On peut remarquer que si un nombre $n$ est composé, alors un de ses facteurs est forcément plus petit ou égal à $sqrt(n)$ (preuve, par l'absurde : si d'aventure $n$ pouvait s'écrire $k_1 dot k_2$ avec $k_1 > sqrt(n)$ et $k_2 > sqrt(n)$ alors on aurait $n = k_1 dot k_2 > sqrt(n) dot sqrt(n) = n$ : que nenni !). En déduire une amélioration de la fonction `sieve_eratosthenes`. Que devient sa complexité temporelle ?
+ Écrire une fonction\
	```python primes(m)```\
	qui retourne la liste des nombres premiers strictement plus 
	petits que $m$.