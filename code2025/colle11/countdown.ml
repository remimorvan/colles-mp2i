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

(* Question 4 *)

(* Soit n fixé. On considère une loi uniforme sur les listes de 0/1 de taille n.
---
La complexité temporelle de next_stack est proportionelle à la position du premier '1' dans la liste.
Or, la probabilité que le premier '1' soit en position 0 est 1/2,
qu'il soit en position 1 est de 1/4, et en position k de 1/2^k. (k < n)
La probabilité qu'il n'y ait aucun '1' est de 1/2^n.
---
La complexité moyenne de next_stack sur une liste tirée uniformément parmi les listes de 0/1 de taille n est donc de somme_(k=0)^n coût(premier '1' en position k) * proba(premier '1' en position k) + coût(aucun '1')*proba(aucun '1') = somme_(k=0)^n k * 1/2^k + O(1).

On pose f_n(x) = somme_(k=0)^n k * x^k.
Alors (1-x)f_n(x) = (somme_(k=0)^n k * x^k) - (somme_(k=0)^n k * x^(k+1))
= (somme_(k=0)^n k * x^k) - (somme_(k=1)^(n+1) (k-1) * x^k)
= (somme_(k=1)^n x^k) - n*x^(n+1)
= (x - x^(n+1))/(1-x) - n*x^(n+1)
= (x - x^(n+1) -n*x^(n+1) + n*x^(n+2))/(1-x),
et donc f_n(x) = (x - x^(n+1) -n*x^(n+1) + n*x^(n+2))/(1-x)^2.
En évaluant en x=1/2 puis en faisant tendre n vers +infinity,
on obtient que la complexité temporelle moyenne (sous une loi uniforme) de `next_stack` est
O((1/2)/(1/2)^2) = O(1), c'est-à-dire en temps constant.
*) 