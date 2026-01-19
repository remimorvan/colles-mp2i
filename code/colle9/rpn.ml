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

type 'a stack = 'a list;;

let empty_stack () = [];;

let is_stack_empty s = match s with
 | [] -> true
 | _ -> false;;

let push_on_stack s x = x::s;;

let pop_stack s = match s with
 | [] -> failwith "Empty stack"
 | h::t -> (h, t);;

let eval_rpn rpn =
  let rec eval_rpn_aux rpn stack = match rpn with
    | [] -> let res, _ = pop_stack stack in res
    | Int(n)::tail -> eval_rpn_aux tail (push_on_stack stack n)
    | Plus::tail ->
      let y, stack2 = pop_stack stack in
      let x, stack3 = pop_stack stack2 in
      eval_rpn_aux tail (push_on_stack stack3 (x+y))
    | Times::tail ->
      let y, stack2 = pop_stack stack in
      let x, stack3 = pop_stack stack2 in
      eval_rpn_aux tail (push_on_stack stack3 (x*y))
    in eval_rpn_aux rpn (empty_stack ());;

(* (1+2)*(3+4) *)
let e = Mult(Add(Const(1),Const(2)),Add(Const(3),Const(4)))
in assert (eval_expr e == eval_rpn (expr_to_rpn e));;

(* (1+2)*(3+4) *)
let e = Mult(Const(3),Add(Const(10),Const(5)))
in assert (eval_expr e == eval_rpn (expr_to_rpn e));;