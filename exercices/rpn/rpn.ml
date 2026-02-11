(* Question 1
  (1+2)*(3+4) s'écrit 1 2 + 3 4 + * en notation polonaise inversée,
  et 1 + 2 * 3 + 5 s'écrit 1 2 3 * + 5 +. *)

(* Question 2 *)

type expr =
| Const of int
| Add of expr * expr
| Mult of expr * expr;;

let rec eval_expr e = match e with
  | Const(n) -> n
  | Add(e1, e2) -> (eval_expr e1) + (eval_expr e2)
  | Mult(e1, e2) -> (eval_expr e1) * (eval_expr e2);;

assert(eval_expr (Mult(Const(2), Add(Const(1), Const(3)))) == 8);;

(* Cette fonction est en temps linéaire : on fait au plus
une opération par constructeur présent dans l'expression. *)

(* Question 3 *)

type int_or_op = Int of int | Plus | Times;;

let rec expr_to_rpn e = match e with
  | Const(n) -> [Int(n)]
  | Add(e1, e2) -> (expr_to_rpn e1)@(expr_to_rpn e2)@[Plus]
  | Mult(e1, e2) -> (expr_to_rpn e1)@(expr_to_rpn e2)@[Times];;

let rec e = Add(Mult(Const(1),Const(2)), Const(3))
and eq_list lst1 lst2 = match lst1,lst2 with
 | [],[] -> true
 | [],_ | _,[] -> false
 | h1::t1, h2::t2 -> (h1=h2)&&(eq_list t1 t2)
in assert(eq_list (expr_to_rpn e) [Int(1);Int(2);Times;Int(3);Plus]);;

(* Question 4 *)

let eval_rpn rpn =
  let rec eval_rpn_aux rpn stack = match rpn, stack with
    | [], [res] -> res
    | Int(n)::tail, _ -> eval_rpn_aux tail (n::stack)
    | Plus::tail, x::y::stack_tail ->
      eval_rpn_aux tail ((x+y)::stack_tail)
    | Times::tail, x::y::stack_tail ->
      eval_rpn_aux tail ((x*y)::stack_tail)
    | _ -> failwith "Unexpected stack content."
    in eval_rpn_aux rpn [];;

(* (1+2)*(3+4) *)
let e = Mult(Add(Const(1),Const(2)),Add(Const(3),Const(4)))
in assert (eval_expr e == eval_rpn (expr_to_rpn e));;

(* (1+2)*(3+4) *)
let e = Mult(Const(3),Add(Const(10),Const(5)))
in assert (eval_expr e == eval_rpn (expr_to_rpn e));;