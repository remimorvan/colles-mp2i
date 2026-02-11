(* Question 1 *)

type nucleotide = A | U | G | C;;
let nucleotide_of_char c = match c with
  | 'A' -> A
  | 'U' -> U 
  | 'G' -> G
  | 'C' -> C
  | _ -> failwith("Unknown nucleotide");;

assert(nucleotide_of_char 'U' = U);;

type amino_acid = string;;
type codon = (nucleotide * nucleotide * nucleotide);;

(* Question 2 *)

type effect = Stop | AA of (amino_acid * bool);;
(* Dans le constructeur AA, le booléen représente si le codon est initiant. *)

(* Question 3 *)

let rec is_defined list key = match list with
  | [] -> false
  | (k, v)::tail -> k = key || is_defined tail key;; 

let rec value_of list key = match list with
  | [] -> failwith("Key not found")
  | (k, v)::_ when k = key -> v
  | _::tail -> value_of tail key;;

let lst_assoc = [(0, "abc"); (5, "def")] in
assert(is_defined lst_assoc 0 && is_defined lst_assoc 5 && not (is_defined lst_assoc 3) && value_of lst_assoc 5 = "def");;

(* Question 4 *)

let codon_to_amino_acid = [ ("UUU", "Phe") ; ("UUC", "Phe") ; ("UUA", "Leu") ;
("UUG", "Leu") ; ("CUU", "Leu") ; ("CUC", "Leu") ; ("CUA", "Leu") ; ("CUG",
"Leu") ; ("AUU", "Ile") ; ("AUC", "Ile") ; ("AUA", "Ile") ; ("AUG", "Met") ;
("GUU", "Val") ; ("GUC", "Val") ; ("GUA", "Val") ; ("GUG", "Val") ; ("UCU",
"Ser") ; ("UCC", "Ser") ; ("UCA", "Ser") ; ("UCG", "Ser") ; ("CCU", "Pro") ;
("CCC", "Pro") ; ("CCA", "Pro") ; ("CCG", "Pro") ; ("ACU", "Thr") ; ("ACC",
"Thr") ; ("ACA", "Thr") ; ("ACG", "Thr") ; ("GCU", "Ala") ; ("GCC", "Ala") ;
("GCA", "Ala") ; ("GCG", "Ala") ; ("UAU", "Tyr") ; ("UAC", "Tyr") ; ("UAA",
"stop") ; ("UAG", "stop") ; ("CAU", "His") ; ("CAC", "His") ; ("CAA", "Gln") ;
("CAG", "Gln") ; ("AAU", "Asn") ; ("AAC", "Asn") ; ("AAA", "Lys") ; ("AAG",
"Lys") ; ("GAU", "Asp") ; ("GAC", "Asp") ; ("GAA", "Glu") ; ("GAG", "Glu") ;
("UGU", "Cys") ; ("UGC", "Cys") ; ("UGA", "stop") ; ("UGG", "Trp") ; ("CGU",
"Arg") ; ("CGC", "Arg") ; ("CGA", "Arg") ; ("CGG", "Arg") ; ("AGU", "Ser") ;
("AGC", "Ser") ; ("AGA", "Arg") ; ("AGG", "Arg") ; ("GGU", "Gly") ; ("GGC",
"Gly") ; ("GGA", "Gly") ; ("GGG", "Gly") ];;

let codon_of_string s = 
  assert(String.length s = 3);
  ((nucleotide_of_char s.[0], nucleotide_of_char s.[1], nucleotide_of_char s.[2]) : codon);;

assert(codon_of_string "UGA" = (U, G, A));;

let effect_of_aa c aa = match aa with
  | "stop" -> Stop
  | _ ->
    let is_initial = (c = "UUG") || (c = "CUG") || (c = "AUG")
    in AA(aa, is_initial);;

assert(effect_of_aa "CUG" "Leu" = AA("Leu", true));;

let codon_to_effect = 
  let rec aux cta cte = match cta with 
  | [] -> cte
  | (str_codon, str_aa)::tail ->
      aux tail ((codon_of_string str_codon, effect_of_aa str_codon str_aa)::cte)
  in aux codon_to_amino_acid [];;

(* Question 6 *)

let string_to_codon str = 
  let n = String.length str
  in let rec build_list i lst =
    if i + 2 < n then
      let c = ((nucleotide_of_char str.[i], nucleotide_of_char str.[i+1], nucleotide_of_char str.[i+2]) : codon)
      in build_list (i+3) (c::lst)
    else List.rev lst
  in build_list 0 [];;

assert(string_to_codon "" = [] && string_to_codon "UGCAAGU" = [(U, G, C); (A, A, G)]);;

let synthesis (rna: string) =
  let rec build_effect_list codon_list effect_list = match codon_list with
  | [] -> List.rev effect_list
  | c::tail ->
    let ef = value_of codon_to_effect c
    in build_effect_list tail (ef::effect_list)
  in let effect_list = build_effect_list (string_to_codon rna) []
  in let rec build_prot effect_list aa_list has_started = match effect_list with
    | [] -> failwith("Expected stop")
    | Stop::ef_tail -> List.rev aa_list
    | AA(aa, is_init)::ef_tail when has_started ->
      build_prot ef_tail (aa::aa_list) true
    | AA(aa, is_init)::ef_tail when is_init ->
      build_prot ef_tail aa_list true
    | AA(aa, is_init)::ef_tail ->
      build_prot ef_tail aa_list has_started
    in build_prot effect_list [] false;;

assert(synthesis "CUCAUGCAGAGUAUGUGAAGCCCCUUC" = ["Gln"; "Ser"; "Met"]);;