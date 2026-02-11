type 'a decision_tree_univariate =
  | TestUni of float * 'a decision_tree_univariate * 'a decision_tree_univariate
  | OutputUni of 'a;;

(* Question 1a. *)

let some_tree = 
  TestUni(1.0,
    TestUni(0.5,
      OutputUni("sortie 1"),
      OutputUni("sortie 2")
    ),
    TestUni(2.0,
      TestUni(1.21,
        OutputUni("sortie 3"),
        OutputUni("sortie 4")
      ),
      OutputUni("sortie 5")
    )
  );;

(* Question 1b. *)

let rec eval_univariate tree x = match tree with
  | OutputUni(out) -> out
  | TestUni(y, left_child, _) when x < y -> eval_univariate left_child x
  | TestUni(_, _, right_child) -> eval_univariate right_child x;;

assert(eval_univariate some_tree 1.13 = "sortie 3");;

(* Question 2a *)

type 'a decision_tree =
  | Test of int * float * 'a decision_tree * 'a decision_tree
  | Output of 'a;;

(* Question 2b *)

let quarter_planes = 
  Test(0, 0.0, 
    Test(1, 0.0, 
      Output("SW"),
      Output("NW")
    ),
    Test(1, 0.0,
      Output("SE"),
      Output("NE")
    )
  );;

(* Question 2c *)

let rec eval tree x = match tree with
  | Output(out) -> out
  | Test(i, y, _, _) when i >= Array.length x -> failwith("Undefined variable.")
  | Test(i, y, left_child, _) when x.(i) < y -> eval left_child x
  | Test(_, _, _, right_child) -> eval right_child x;;

assert (eval quarter_planes [|-1.; -1.|] = "SW");
assert (eval quarter_planes [|1.; -1.|] = "SE");
assert (eval quarter_planes [|-1.; 1.|] = "NW");
assert (eval quarter_planes [|1.; 1.|] = "NE");;

(* Question 2d *)

(* On choisit comme variant de la fonction eval la hauteur de l'arbre passé en entrée.
Il est à valeur dans N, et décroit à chaque appel, donc la fonction termine. *)
(* Autre variant possible : la taille de l'arbre (nombre total de noeuds). *)