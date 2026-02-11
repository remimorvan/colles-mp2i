(* Question 1 *)

let rna_to_codon_list (rna: string) =
	assert(String.length(rna) mod 3 = 0);
	let rec rna_to_codon_list_aux (pos: int) (codons: string list) = 
		if pos + 3 > String.length(rna) then
			List.rev codons
		else (
			rna_to_codon_list_aux (pos + 3) ((String.sub rna pos 3)::codons)
		)
	in rna_to_codon_list_aux 0 [];;

assert(rna_to_codon_list "AUGUGACUC" = ["AUG"; "UGA"; "CUC"]);;
	
(* Question 2 *)

let is_codon_init (codon: string) = 
	codon = "UUG" || codon = "CUG" || codon = "AUG";;

let is_codon_stop (codon: string) = 
	codon = "UAA" || codon = "UAG" || codon = "UGA";;

(* Question 3 *)

let rec is_defined list key = match list with
  | [] -> false
  | (k, v)::tail -> k = key || is_defined tail key;; 

let rec value_of list key = match list with
  | [] -> failwith("Key not found")
  | (k, v)::_ when k = key -> v
  | _::tail -> value_of tail key;;

let lst_assoc = [(0, "abc"); (5, "def")] in
assert(is_defined lst_assoc 0);
assert(is_defined lst_assoc 5);
assert(not (is_defined lst_assoc 3));
assert(value_of lst_assoc 5 = "def");;

let codon_to_amino_acid_data = [ ("UUU", "Phe") ; ("UUC", "Phe") ; ("UUA", "Leu") ;
("UUG", "Leu") ; ("CUU", "Leu") ; ("CUC", "Leu") ; ("CUA", "Leu") ; ("CUG",
"Leu") ; ("AUU", "Ile") ; ("AUC", "Ile") ; ("AUA", "Ile") ; ("AUG", "Met") ;
("GUU", "Val") ; ("GUC", "Val") ; ("GUA", "Val") ; ("GUG", "Val") ; ("UCU",
"Ser") ; ("UCC", "Ser") ; ("UCA", "Ser") ; ("UCG", "Ser") ; ("CCU", "Pro") ;
("CCC", "Pro") ; ("CCA", "Pro") ; ("CCG", "Pro") ; ("ACU", "Thr") ; ("ACC",
"Thr") ; ("ACA", "Thr") ; ("ACG", "Thr") ; ("GCU", "Ala") ; ("GCC", "Ala") ;
("GCA", "Ala") ; ("GCG", "Ala") ; ("UAU", "Tyr") ; ("UAC", "Tyr") ; ("CAU", "His") ; ("CAC", "His") ; ("CAA", "Gln") ;
("CAG", "Gln") ; ("AAU", "Asn") ; ("AAC", "Asn") ; ("AAA", "Lys") ; ("AAG",
"Lys") ; ("GAU", "Asp") ; ("GAC", "Asp") ; ("GAA", "Glu") ; ("GAG", "Glu") ;
("UGU", "Cys") ; ("UGC", "Cys") ; ("UGG", "Trp") ; ("CGU",
"Arg") ; ("CGC", "Arg") ; ("CGA", "Arg") ; ("CGG", "Arg") ; ("AGU", "Ser") ;
("AGC", "Ser") ; ("AGA", "Arg") ; ("AGG", "Arg") ; ("GGU", "Gly") ; ("GGC",
"Gly") ; ("GGA", "Gly") ; ("GGG", "Gly") ];;

let codon_to_amino_acid (codon: string) = 
	assert(is_defined codon_to_amino_acid_data codon);
	value_of codon_to_amino_acid_data codon;;

assert (codon_to_amino_acid "AGA" = "Arg");;

(* Question 4 *)

let rec synthesis (rna: string) =
	let rec codons_to_amino_acids (codons: string list) (is_init: bool) (amino_acids: string list) =
	match codons with
	| [] -> failwith "Synthesis reached end of codons before reaching a stop codon."
	| cod::codons_tail when not is_init -> 
		codons_to_amino_acids codons_tail (is_codon_init cod) (amino_acids)
	| cod::codons_tail when is_codon_stop cod ->
		List.rev amino_acids
	| cod::codons_tail ->
		codons_to_amino_acids codons_tail (is_init) ((codon_to_amino_acid cod)::amino_acids)
	in codons_to_amino_acids (rna_to_codon_list rna) false [];;

assert (synthesis "CUCAUGCAGAGUAUGUGAAGCCCCUUC" = ["Gln";"Ser";"Met"]);;