#import "../../template.typ": exercise
#let exercise = exercise.with(data: json("../../data.json"))

#exercise(
  title: [Un brin de génétique],
  language: "ocaml",
  difficulty: 3,
  themes: ("récursivité", "dictionnaires")
)

L'acide ribonucléique messager (ARNm) est une molécule qui intervient
dans la synthèse des protéines à partir de l'ADN.
On peut voir un brin d'ARNm comme un mot sur l'alphabet $\{A, U, G, C\}$,
chaque lettre étant appelée *nucléotide*.
#footnote[Les lettres A, U, G et C font respectivement référence aux nucléotides adénine, uracile, guanine et cytosine.]
L'algorithme pour synthétiser une protéine à partir d'un brin ARNm est le suivant :
- on regroupe les nucléotides par groupe de trois ;
	chaque groupe de trois nucléotides (par exemple "AUG" et "CGA") est appelé "codon" ;
- chaque codon produit un acide aminé (par exemple `Phe` (_phénylalanine_), ou `Lys` (_lysine_)),
	ou indique le début de la synthèse (`init`), ou l'arrêt de la synthèse (`stop`). 
	Un codon qui indique le début de la synthèse est aussi toujours associé à un acide aminé.
	Par exemple, "AUG" indique le début de la synthèse et est associé à l'acide aminé "Met".
	La première fois qu'on le rencontrera, celà initiera la synthèse de la protéine, mais la
	seconde fois, il produira l'acide aminé "Met".
	#footnote[Bien évidemment, tout ceci est une simplification de la réalité.]

Considérons par exemple le brin d'ARN messager
$ "CUCAUGCAGAGUAUGUGAAGCCCCUUC". $
Ses codons sont
$ underbrace("CUC", mono("Leu"))
	underbrace("AUG", mono("init/Met"))
	underbrace("CAG", mono("Gln"))
	underbrace("AGU", mono("Ser"))
	underbrace("AUG", mono("init/Met"))
	underbrace("UGA", mono("stop"))
	underbrace("AGC", mono("Ser"))
	underbrace("CCC", mono("Pro"))
	underbrace("UUC", mono("Phe")). $
Lors de la synthèse, on obtiendra donc la protéine définie par la suite d'acide aminé
`Gln Ser Met`. Le but de cet exercice est de simuler cette synthèse en OCaml.

+ Définir une fonction\
	```ocaml rna_to_codon_list: string -> string list```
	qui associe à un brin d'ARNm la liste de ses codons.
+ Écrire des fonctions\
	```ocaml 
	is_codon_init: string -> bool 
	is_codon_stop: string -> bool 
	```
	qui détermine si un codon est initiant ou stopant. Les codons initiants sont
	UUG, CUG et AUG; les codons stopant sont UAA, UAG et UGA.
+ On souhaite définir une structure qui décrit l'information de quel acide aminé est associé à
	un codon donné : on va utiliser une *liste d'association*.
	Une liste d'association est une liste de type ```ocaml ('a * 'b) list```, 
	de sorte que si $(c,v)$ et $(c',v')$ sont tous deux éléments de la liste, alors $c != c'$.
	Autrement dit, une liste d'association encode une fonction qui associe des éléments
	de type `'a` (appelés *clés*) à des éléments de type `'b` (appelés *valeurs*).
	+ Définir une fonction\
		```ocaml is_defined: ('a * 'b) list -> 'a -> bool```\
		qui prend une liste d'association, une clé, et détermine si une valeur lui est associée.
	+ Définir une fonction\ 
		```ocaml value_of: ('a * 'b) list -> 'a -> 'b```\
		qui prend une liste d'association, une clé, et retourne la valeur qui lui est associée
		(si elle existe, sinon elle produit une erreur).
	+ À partir de la liste d'association de type `(string * string) list`
		```ocaml
		let codon_to_amino_acid_data = [ ("UUU", "Phe") ; ("UUC", "Phe") ; ("UUA", "Leu") ; ("UUG", "Leu") ; ("CUU", "Leu") ; ("CUC", "Leu") ; ("CUA", "Leu") ; ("CUG", "Leu") ; ("AUU", "Ile") ; ("AUC", "Ile") ; ("AUA", "Ile") ; ("AUG", "Met") ; ("GUU", "Val") ; ("GUC", "Val") ; ("GUA", "Val") ; ("GUG", "Val") ; ("UCU", "Ser") ; ("UCC", "Ser") ; ("UCA", "Ser") ; ("UCG", "Ser") ; ("CCU", "Pro") ; ("CCC", "Pro") ; ("CCA", "Pro") ; ("CCG", "Pro") ; ("ACU", "Thr") ; ("ACC", "Thr") ; ("ACA", "Thr") ; ("ACG", "Thr") ; ("GCU", "Ala") ; ("GCC", "Ala") ; ("GCA", "Ala") ; ("GCG", "Ala") ; ("UAU", "Tyr") ; ("UAC", "Tyr") ; ("CAU", "His") ; ("CAC", "His") ; ("CAA", "Gln") ; ("CAG", "Gln") ; ("AAU", "Asn") ; ("AAC", "Asn") ; ("AAA", "Lys") ; ("AAG", "Lys") ; ("GAU", "Asp") ; ("GAC", "Asp") ; ("GAA", "Glu") ; ("GAG", "Glu") ; ("UGU", "Cys") ; ("UGC", "Cys") ; ("UGG", "Trp") ; ("CGU", "Arg") ; ("CGC", "Arg") ; ("CGA", "Arg") ; ("CGG", "Arg") ; ("AGU", "Ser") ; ("AGC", "Ser") ; ("AGA", "Arg") ; ("AGG", "Arg") ; ("GGU", "Gly") ; ("GGC", "Gly") ; ("GGA", "Gly") ; ("GGG", "Gly") ];;
		```
		définir une fonction
		```ocaml codon_to_amino_acid: string -> string```
		qui retourne l'acide aminé associé à un codon passé en argument.
+ Le but de cette question est de produire une fonction
	```ocaml synthesis: string -> string list```\
	qui prend une chaîne de caractère représentant un brin d'ARN messager,
	et retourne la chaîne d'acide aminés de la protéine produite par ce brin.
	+ Donnez une description haut-niveau d'un tel algorithme.
		_On s'attend à une réponse de quelques lignes, en français (pas de pseudo-code), expliquant le fonctionnement de cet algorithme. Il est inutile de détailler commenter calculer les fonctions
		implémentées aux questions précédentes._
	+ Implémentez la fonction `synthesis`.