type card = Val of char * int | ChangeColor;;

let is_playable last_card new_card = match last_card, new_card with
  | _, ChangeColor -> true
  | ChangeColor, _ -> true
  | Val(c1, n1), Val(c2, n2) -> c1 = c2 || n1 = n2

let rec greedy_play (init_card: card) (card_to_process: card list) (card_passed: card list) =
  match card_to_process with
  | [] -> List.length card_passed
  | card_head::card_tail when is_playable init_card card_head ->
    greedy_play card_head ((List.rev card_passed) @ card_tail) []
  | card_head::card_tail ->
    greedy_play init_card card_tail (card_head::card_passed);;

let hand = [Val('R', 8); ChangeColor; Val('B', 5); Val('R', 3)]
  in assert ((greedy_play ChangeColor hand []) = 1);;

(* Question supplémentaire : écrire une version qui cherche la solution optimale. *)