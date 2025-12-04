type tree = Leaf of int | Node of (int * tree * tree);;

(* ---
Une première version un peu naïve en temps quadratique.
--- *)

let rec max_of_tree = function
  | Leaf(k) -> k
  | Node(k, t1, t2) -> max k (max (max_of_tree t1) (max_of_tree t2));;

let rec max_of_subtrees_quad = function
  | Leaf(k) -> Leaf(k)
  | Node(k, t1, t2) ->
    let m = max_of_tree (Node(k, t1, t2))
    in Node(m, max_of_subtrees_quad t1, max_of_subtrees_quad t2);;

(* La fonction max_of_subtrees_quad est quadratique en temps (dans le meilleur & pire cas) :
chaque appel à max_of_tree est linéaire en la taille du sous-arbre,
et on appelle cette fonction pour chaque noeud.
On peut facilement améliorer le code en se rendant compte que le calcul de
max_of_tree est facilement calculable à partir des arbres max_of_subtrees_quad t1
et max_of_subtrees_quad t2.
*)
  
(* --- 
Version en temps linéaire.
--- *)

let label_of_root = function
  | Leaf(k) -> k
  | Node(k, _, _) -> k;;

let rec max_of_subtrees_lin = function
  | Leaf(k) -> Leaf(k)
  | Node(k, t1, t2) ->
    let m1 = max_of_subtrees_lin(t1) and m2 = max_of_subtrees_lin(t2)
    in let k1 = label_of_root(m1) and k2 = label_of_root(m2)
    in let local_max = max k (max k1 k2) in
    Node(local_max, m1, m2);;

let t = Node(10, Leaf(3), Node(4, Leaf(0), Node(7, Leaf(1), Leaf(2))))
and m1 = Node(10, Leaf(3), Node(7, Leaf(0), Node(7, Leaf(1), Leaf(2))))
  in let m2 = max_of_subtrees_lin(t) in assert(m1 = m2);;

(* Complexité temporelle (pire & meilleur cas) :
- label_of_root : constante 
- max_of_subtrees_lin : nombre d'opération bornée pour chaque noeud -> complexité linéaire. *)