type 'a queue = {
  front: 'a list;
  back: 'a list;
};;

let new_queue () = {
  front = [];
  back = [];
};;

let is_empty q = match q.front, q.back with
  | [], [] -> true
  | _ -> false;;

let enqueue q x = {
  front = q.front;
  back = x::q.back;
};;

let rec dequeue q = match q.front, q.back with
  | [], [] -> failwith "Empty queue."
  | x::front_tail, _ -> ({front = front_tail; back = q.back;}, x)
  | _ -> dequeue {front = List.rev q.back; back = [];};;

let rec print_queue q =
  if not (is_empty q) then
    let q2, x = dequeue q in
    (print_int x;
    print_newline ();
    print_queue q2);;

print_queue (enqueue (enqueue (enqueue (new_queue ()) 0) 1) 2);;

type 'a tree =
| Node of 'a * 'a tree * 'a tree 
| Leaf of 'a;;

let bfs t =
  let rec aux subtrees_to_visit elements =
    if is_empty subtrees_to_visit then
      elements
    else
      let subtrees_to_visit, tree = dequeue subtrees_to_visit in
      match tree with
      | Leaf(x) -> aux subtrees_to_visit (enqueue elements x)
      | Node(x, t1, t2) ->
        let subtrees_to_visit = enqueue (enqueue subtrees_to_visit t1) t2 in
        aux subtrees_to_visit (enqueue elements x)
      in aux (enqueue (new_queue ()) t) (new_queue ());;

let example_tree =
  Node (0,
    Node (1, Leaf 3, Leaf 4),
    Node (2,
      Node (5, Leaf 7, Leaf 8),
      Leaf 6)
  );;
let q = bfs example_tree in print_queue q;;