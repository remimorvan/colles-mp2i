type tree = Leaf of int | Node of (int * tree * tree);;

(* ---
Une première version un peu naïve en temps quadratique.
--- *)

let rec max_of_tree t = match t with
  (* Retourne la plus grand étiquette apparaissant dans un arbre. *)
  | Leaf(k) -> k
  | Node(k, t1, t2) -> max k (max (max_of_tree t1) (max_of_tree t2));;

assert(max_of_tree(Node(5, Node(14, Leaf(1), Leaf(-35)), Node(0, Leaf(1), Leaf(18)))) = 18);;

let rec max_of_subtrees_quad t = match t with
  (* Étant donné un arbre, retourne un arbre de même forme, dont chaque nœud
  est étiquetté par le maximum de sous-arbre enraciné en ce nœud. *)
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

let label_of_root t = match t with
  (* Retourne l'étiquette de la racine (le noeud le plus externe) d'un arbre. *)
  | Leaf(k) -> k
  | Node(k, _, _) -> k;;

assert(label_of_root(Leaf(42)) = 42);
assert(label_of_root(Node(-1, Leaf(2), Node(0, Leaf(4), Leaf(128)))) = -1);;

let rec max_of_subtrees_lin t = match t with
  (* Étant donné un arbre, retourne un arbre de même forme, dont chaque nœud
  est étiquetté par le maximum de sous-arbre enraciné en ce nœud. *)
  | Leaf(k) -> Leaf(k)
  | Node(k, t1, t2) ->
    let m1 = max_of_subtrees_lin(t1) and m2 = max_of_subtrees_lin(t2)
    in let k1 = label_of_root(m1) and k2 = label_of_root(m2)
    in let local_max = max k (max k1 k2) in
    Node(local_max, m1, m2);;

(* Test de la fonction max_of_subtrees_lin. *)
let t = Node(10, Leaf(3), Node(4, Leaf(0), Node(7, Leaf(1), Leaf(2))))
and m1 = Node(10, Leaf(3), Node(7, Leaf(0), Node(7, Leaf(1), Leaf(2))))
  in let m2 = max_of_subtrees_lin(t) in assert(m1 = m2);;

(* Complexité temporelle (pire & meilleur cas) :
- label_of_root : constante 
- max_of_subtrees_lin : nombre d'opération bornée pour chaque noeud -> complexité linéaire. *)