let rec split lst = match lst with
  (* Takes a list and splits its content into
    two lists of equal length
    (±1 if the initial list has odd length). *)
  | [] -> ([], [])
  | h::tail ->
    let (lst1, lst2) = split tail in (h::lst2, lst1);;

let rec merge lst1 lst2 = match lst1, lst2 with
  (* Merges two sorted lists into a sorted list. *)
  | [], lst2 -> lst2
  | lst1, [] -> lst1
  | h1::t1, h2::t2 when h1 < h2 -> h1::(merge t1 lst2)
  | lst1, h2::t2 -> h2::(merge lst1 t2);;

let rec merge_sort lst = match lst with
  (* Sorts a list using the merge sort algorithm. *)
  | [] -> []
  | [x] -> [x]
  | _ ->
    let lst1, lst2 = split lst in 
    merge (merge_sort lst1) (merge_sort lst2);;

let l = [0;2;1;0;9;4;3;2;8;4;5] in
let lsorted = merge_sort l in 
let rec print_lst lst = match lst with
    | [] -> ()
    | h::tail -> (print_int(h); print_char(' '); print_lst tail)
in print_lst l; print_newline(); print_lst lsorted; print_newline();
