(* Question 1 *)

let rec is_defined lst k = match lst with
  | [] -> false
  | (k', v)::tail when k = k' -> true
  | _::tail -> is_defined tail k;;

assert (is_defined [('a', 0); ('b', 1)] 'b');;
assert (not (is_defined [('a', 0); ('b', 1)] 'c'));;

let rec get_value lst k = match lst with
  | [] -> failwith("Unknown key.")
  | (k', v)::tail when k = k' -> v
  | _::tail -> get_value tail k;;

assert (get_value [('a', 0); ('b', 1)] 'b' == 1);;

let rec update_value lst k v = match lst with
  | [] -> [(k, v)]
  | (k', v')::tail when k = k' -> (k', v)::tail
  | (k', v')::tail -> (k', v')::(update_value tail k v);;

assert (get_value (update_value [('a', 0); ('b', 1)] 'c' 2) 'c' == 2);;
assert (get_value (update_value [('a', 0); ('b', 1)] 'c' 2) 'b' == 1);;
assert (get_value (update_value [('a', 0); ('b', 1)] 'c' 2) 'a' == 0);;
assert (get_value (update_value [('a', 0); ('b', 1)] 'a' 2) 'a' == 2);;
assert (get_value (update_value [('a', 0); ('b', 1)] 'a' 2) 'b' == 1);;

let count_chars_of_str str =
  let rec aux pos count_chars =
    if pos = String.length str then
      count_chars
    else 
      let old_count = (
        if is_defined count_chars str.[pos] then
          get_value count_chars str.[pos]
        else 0
      ) in aux (pos+1) (update_value count_chars str.[pos] (old_count+1))
  in aux 0 [];;

let lst = count_chars_of_str "chien de chine"
in assert (get_value lst 'e' = 3);
assert (not (is_defined lst 'z'));;

(* Question 2 *)

let rec get_keys lst = match lst with
  | [] -> []
  | (k, v)::tail -> k::(get_keys tail);;

let are_assoc_list_equal lst1 lst2 = 
  let is_assoc_list_dominated lst1 lst2 =
    (* Vérifie si, pour toute clé de lst1, cette clé est aussi présente de lst2 et les valeurs coïncides. *)
    let rec iter_on_keys keys list_coincide = match keys with
    | [] -> list_coincide
    | k::keys_tail -> iter_on_keys keys_tail (list_coincide && is_defined lst2 k && (get_value lst1 k == get_value lst2 k))
    in iter_on_keys (get_keys lst1) true
  in (is_assoc_list_dominated lst1 lst2) && (is_assoc_list_dominated lst2 lst1)
;;

let are_anagrams_of str1 str2 =
  let cpt1 = count_chars_of_str str1
  and cpt2 = count_chars_of_str str2
in are_assoc_list_equal cpt1 cpt2;;

assert(are_anagrams_of "niche de chien" "chien de chine");;
assert(are_anagrams_of "la crise économique" "le scénario comique");;
assert(not (are_anagrams_of "être ou ne pas être, voilà la question" "oui et la poser n'est que vanité orale"));;

