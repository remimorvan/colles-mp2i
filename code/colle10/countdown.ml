(* Question 1 *)

(* En itérant la construction sur la pile [1;1;1], on obtient :
- [1;1;1]
- [0;1;1]
- [1;0;1]
- [0;0;1]
- [1;1;0]
- [0;1;0]
- [1;0;0]
- [0;0;0]
On reconnaît un compteur binaire !
*)

(* Question 2 *)

let rec next_stack p = match p with
  | [] -> None
  | 1::t -> Some(0::t)
  | 0::t -> (match next_stack t with
    | None -> None
    | Some(t2) -> Some(1::t2))
  | _ -> failwith "Stack should only contain 0s and 1s.";;

let rec print_list l = match l with
  | [] -> print_newline ()
  | h::t -> print_int h; print_char ' '; print_list t;;

let rec countdown p = match p with
  | None -> ()
  | Some(t) -> print_list t; countdown (next_stack t);;

let l = [1;1;1;1] in countdown (Some(l));;

(* Question 3 *)

(* On prend comme variant :
- 0 si p = None
- 1 + somme_i p_i * 2^i si p = Some([p_0, p_1, ..., p_n]).
Puisque next_stack fait décroitre un compteur en binaire, ce variant est strictement
décroissant. Il est à valeur dans N par construction. Et donc, countdown termine.
*)