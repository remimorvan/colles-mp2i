#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Anagrammes],
  language: "ocaml",
  difficulty: 2,
  themes: ("dictionnaires", "récursivité", "complexité")
)

Le but de cet exercice est de déterminer si deux chaînes de caractères sont des *anagrammes*,
c'est-à-dire si l'une peut être obtenue en permutant les caractères de l'autre.
Rien de plus simple pour déterminer si deux chaînes de caractères sont des anagrammes :
il suffit de compter le nombre d'occurrences de chaque caractère dans la chaîne, et
ces valeurs sont égales si et seulement si les deux chaînes sont des anagrammes.
Par exemple, "niche" est une anagramme de "chien",
"la crise économique" et "le scénario comique" sont des anagrammes, mais
en revanche "être ou ne pas être, voilà la question" n'est
pas une anagramme de "oui et la poser n'est que vanité orale" (la première chaîne contient deux 'ê' alors que la seconde non).#footnote[Ce sont en revanche des anagrammes si on ignore les espaces, les accents et la ponctuation. (Source : #link("https://www.topito.com/top-anagramme-retourner-cerveau")[topito.com].)]

Pour résoudre notre problème, je vous propose d'utiliser une *liste d'association*,
qui est une liste de type ```ocaml ('a * 'b) list```, 
de sorte que si $(c,v)$ et $(c',v')$ sont tous deux éléments de la liste, alors $c != c'$.
Autrement dit, une liste d'association encode une fonction qui associe des éléments
de type `'a` (appelés *clés*) à des éléments de type `'b` (appelés *valeurs*).
Par exemple, dans la liste\
```ocaml [('a', 1); ('b', 5); ('c', 0)]```\
de type ```ocaml (char * int) list```, on a associé la valeur 1 à 'a', 5 à 'b', et 0 à 'c'.
+
	+ Définir une fonction\
		```ocaml is_defined: ('a * 'b) list -> 'a -> bool```\
		qui prend une liste d'association, une clé, et détermine si une valeur lui est associée.
	+ Définir une fonction\ 
		```ocaml get_value: ('a * 'b) list -> 'a -> 'b```\
		qui prend une liste d'association, une clé, et retourne la valeur qui lui est associée
		(si elle existe, sinon elle produit une erreur).
	+ Définir une fonction\ 
		```ocaml update_value: ('a * 'b) list -> 'a -> 'b -> ('a * 'b) list```\
		qui prend une liste d'association, une clé $c$ , une valeur $v$ et qui retourne une nouvelle liste d'association
		où la nouvelle valeur de la clé $c$ est $v$.
		_Si la clé n'est pas présente, on se contentera d'ajouter la paire (c,v) à la liste. Sinon, on modifiera
		la valeur présente dans la liste._
	+ Écrivez une fonction\
		```ocaml count_chars_of_str: string -> (char * int) list```
		qui étant donné une chaîne de caractères, retourne une liste d'association comptant le nombre d'occurrences
		de chaque caractère.
+ 
	+ De quelle(s) fonction(s) sur les listes d'associations auriez-vous besoin pour déterminer,
		à l'aide de la fonction `count_chars_of_str`, si deux chaînes sont des anagrammes ?
		Implémentez ces fonctions annexes.
	+ En déduire une fonction\
		```ocaml are_anagrams: string -> string -> bool```
		qui détermine si deux chaînes sont des anagrammes.
	+ Donnez une borne supérieure (raisonnable) sur la complexité temporelle de votre fonction
		`count_chars_of_str`, puis de votre fonction `are_anagrams`.
